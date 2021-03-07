//
//  WeatherViewController.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import UIKit


class WeatherViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    
    var weather = [Welcome]()
    var weekWeather = [Week]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.estimatedRowHeight = 600
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AlamofireLoader().alamoLoaderCity {
        weathers in
            self.weather = weathers
        }
        
        AlamofireLoader().alamoLoaderWeek {
            week in
            self.weekWeather = week
            self.TableView.reloadData()
        }
        
        TableView.dataSource = self
    }
   
}

extension WeatherViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 16
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {

            let cell = TableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! WeatherTableViewCell

            let cat = weather[indexPath.row]

            cell.cityNameLabel.text = "\(cat.name)"
            cell.degreeLebel.text = "\(Int(cat.main.temp) - 273)\u{00B0}"
            cell.weatherLebel.text = "\(cat.weather[0].weatherDescription)"
            let iconURL = URL(string: "https://openweathermap.org/img/wn/\(cat.weather[0].icon)@2x.png")
            cell.iconImageView.loaded(url: iconURL!)
            cell.maxMinLabel.text = "Макс. \(Int(cat.main.tempMax) - 273)\u{00B0},  Мин. \(Int(cat.main.tempMin) - 273)\u{00B0}"

            return cell

        } else {

            let newCell = TableView.dequeueReusableCell(withIdentifier: "week", for: indexPath) as! WeekWeatherTableViewCell

            let cats = weekWeather[0].list[indexPath.row]

            newCell.degreesLabel.text = "\(Int(cats.main.temp) - 273)\u{00B0}"

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

