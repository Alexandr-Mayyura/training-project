//
//  CityWeatherModel.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation
import RealmSwift


class Welcome: Object, Decodable {

    var weather = RealmSwift.List<Weather>()
    @objc dynamic var main: Main?
    @objc dynamic  var name: String = ""

    
    override class func primaryKey() -> String? {
          return "name"
      }
    
    private enum CodingKeys: String, CodingKey {
           case weather
           case main
           case name
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            let kitchens = try container.decodeIfPresent([Weather].self, forKey: .weather) ?? [Weather()]
        weather.append(objectsIn: kitchens)
        self.main = try container.decode(Main.self, forKey: .main)
        
    }
  }


class Main: Object, Decodable {
    
    @objc dynamic  var temp: Double
    @objc dynamic  var tempMin: Double
    @objc dynamic var tempMax: Double
    
//    override class func primaryKey() -> String? {
//           return "temp"
//       }
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
    }
    
//    convenience required init(from decoder: Decoder) throws {
//        self.init {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.temp = try container.decode(Double.self, forKey: .temp)
//        self.tempMin = try container.decode(Double.self, forKey: .tempMin)
//        self.tempMax = try container.decode(Double.self, forKey: .tempMax)
//        }
//    }
        
}

class Weather: Object, Decodable {
  
    @objc dynamic var icon: String? = ""
    @objc dynamic var weatherDescription: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon

    }
}

