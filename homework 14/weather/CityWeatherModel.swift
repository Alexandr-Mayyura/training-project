//
//  CityWeatherModel.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation


class Welcome: Decodable {

    let weather: [Weather]
    let main: Main
    let name: String

}

class Main: Decodable {
    
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
    }
}

class Weather: Decodable {
  
    let icon: String
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon

    }
}

