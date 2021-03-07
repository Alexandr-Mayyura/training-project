//
//  LoadWether.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation
import Alamofire



class AlamofireLoader {

func alamoLoaderCity (completion: @escaping ([Welcome]) -> Void) {

    AF.request("https://api.openweathermap.org/data/2.5/weather?q=Moscow&lang=ru&appid=044633d225ca168a0a9163bcbf81b6aa").responseJSON { respons in

        guard let data = respons.data else { return }

            do {
                let moscowWeather = try JSONDecoder().decode(Welcome.self, from: data)

                let weathers: [Welcome] = [moscowWeather]

                DispatchQueue.main.async {
                    completion(weathers)
                    
                }

                } catch let error {
                print(error)
                }
    }
}
     
func alamoLoaderWeek(completion: @escaping ([Week]) -> Void) {
    
    AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Moscow&cnt=16&lang=ru&appid=87d1c1817b13e0e7a1f1439c2a17a10c")
     .responseJSON { respons in
        
        guard let data = respons.data else { return }
        
    
            do {
                let weekWeather = try JSONDecoder().decode(Week.self, from: data)

                let week: [Week] = [weekWeather]
                
                DispatchQueue.main.async {
                    completion(week)
                   
                }

                } catch let error {
                print(error)
                }
     }
    
}

}
