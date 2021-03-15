//
//  WeatherViewController.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    var realm: Realm!
    var openTask: Results<Welcome> {
        get {
            return realm.objects(Welcome.self)
        }
    }
    
    var realm2: Realm!
    var weekLoad: Results<Lists> {
        get {
            return realm2.objects(Lists.self)
        }
    }
    
    
    var weather = [Welcome]()
    var weekWeather = [Week]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 600
        
    }
    

    
    func save() {
        WeatherLoader().load {
            weathers in self.weather = weathers
            try! self.realm.write {
                self.realm.add(self.weather, update: .all)
                self.TableView.reloadData()
            }
        }
        
        WeatherLoader().weekLoad {
            week in self.weekWeather = week
            try! self.realm2.write {
                self.realm2.add(self.weekWeather, update: .all)
                self.TableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        save()
        realm2 = try! Realm()
        realm = try! Realm()
    
        TableView.dataSource = self
      
    }
}

extension WeatherViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
        return openTask.count
        } else {
            if weekLoad.count > 16 {
                return 16
            } else {
                return weekLoad.count
        }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
          
            let cell = TableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! WeatherTableViewCell

       let cat = openTask[indexPath.row]
            
            cell.cityNameLabel.text = "\(cat.name)"
            cell.degreeLebel.text = "\(Int(cat.main!.temp) - 273)\u{00B0}"
        cell.weatherLebel.text = "\(cat.weather[0].weatherDescription ?? "Error")"
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(cat.weather[0].icon ?? "14n")@2x.png")
            cell.iconImageView.loaded(url: iconURL!)
            
            
            
            
            
            cell.maxMinLabel.text = "Макс. \(Int(cat.main!.tempMax) - 273)\u{00B0},  Мин. \(Int(cat.main!.tempMin) - 273)\u{00B0}"

            return cell

        } else {

            let newCell = TableView.dequeueReusableCell(withIdentifier: "week", for: indexPath) as! WeekWeatherTableViewCell
            
            let cats = weekLoad[indexPath.row]
            
            
            newCell.degreesLabel.text = "\(Int(cats.main!.temp) - 273)\u{00B0}"

            let date = cats.dt
            let myDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+3")
            dateFormatter.locale = .init(identifier: "ru_RU_POSIX")
            dateFormatter.dateFormat = "dd EEEE HH:mm"
            let strDate = dateFormatter.string(from: myDate)
            newCell.dayLabel.text = "\(strDate)"

            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(cats.weather[0].icon)@2x.png")
            newCell.iconImageView.loaded(url: iconURL!)


            return newCell
        }

    }

}

 extension UIImageView {
    func loaded(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

