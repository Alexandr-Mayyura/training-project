//
//  WeekWetherModel.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation
import RealmSwift

class Week: Object, Decodable {
    
    var list = RealmSwift.List<Lists>()
    
   
    @objc dynamic var id: String = NSUUID().uuidString
    
    override class func primaryKey() -> String? {
       
          return "id"
      }
    
    private enum CodingKeys: String, CodingKey {
           case list
    }
    
   
    
}

class Lists: Object, Decodable {
    
    @objc dynamic var dt: Double = 0
    @objc dynamic var main: MainClass?
    var weather = RealmSwift.List<Weathers>()
    
    private enum CodingKeys: String, CodingKey {
           case dt
           case main
           case weather
    }
    
//    convenience required init(from decoder: Decoder) throws {
//       self.init()
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.dt = try container.decode(Double.self, forKey: .dt)
//        self.main = try container.decode(MainClass.self, forKey: .main)
//        let kitchens = try container.decodeIfPresent([Weathers].self, forKey: .weather) ?? [Weathers()]
//        weather.append(objectsIn: kitchens)
//
//    }
}

class MainClass: Object, Decodable {
    @objc dynamic var temp: Double
    
    enum CodingKeys: String, CodingKey {

        case temp
    }
}

class Weathers: Object, Decodable {
    
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var icon: String = ""

    enum CodingKeys: String, CodingKey {
       
        case weatherDescription = "description"
        case icon
    }
}
