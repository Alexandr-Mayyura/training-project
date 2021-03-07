//
//  WeekWetherModel.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation


struct Week: Decodable {
    let list: [Lists]
}

struct Lists: Decodable {
    let dt: Double
    let main: MainClass
    let weather: [Weathers]
}

struct MainClass: Decodable {
    let temp: Double
}

struct Weathers: Decodable {
    
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
       
        case weatherDescription = "description"
        case icon
    }
}
