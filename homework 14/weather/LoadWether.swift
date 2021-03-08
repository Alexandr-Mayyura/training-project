//
//  LoadWether.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 05.03.2021.
//

import Foundation




class WeatherLoader {

    func load(completion: @escaping ([Welcome]) -> Void) {

        let url = "https://api.openweathermap.org/data/2.5/weather?q=Moscow&lang=ru&appid=044633d225ca168a0a9163bcbf81b6aa"
        guard let request = URL(string: url) else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }

                do {
                    let moscowWeather = try JSONDecoder().decode(Welcome.self, from: data)

                    let weathers: [Welcome] = [moscowWeather]

                    DispatchQueue.main.async {

                        completion(weathers)

                    }

                } catch let error {
                    print(error)
                }
            } .resume()
        }


    func weekLoad(completion: @escaping ([Week]) -> Void) {

        let url = "https://api.openweathermap.org/data/2.5/forecast?q=Moscow&cnt=16&lang=ru&appid=87d1c1817b13e0e7a1f1439c2a17a10c"
        guard let request = URL(string: url) else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            guard error == nil else { return }

                do {
                    let weekWeather = try JSONDecoder().decode(Week.self, from: data)

                    let week: [Week] = [weekWeather]

                    DispatchQueue.main.async {

                        completion(week)
                    }

                } catch let error {
                    print(error)
                }
            } .resume()
        }

}
    
