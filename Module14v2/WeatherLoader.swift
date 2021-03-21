//
//  WeatherLoader.swift
//  Module14v2
//
//  Created by Сергей Гринько on 21.03.2021.
//

import Foundation


protocol WeatherLoaderDelegate {
    func loaded(weathers:[Weather])
}


class WeatherLoader {
    
    var delegate: WeatherLoaderDelegate?
    
    func loadWeather (){
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=55.75&lon=37.61&appid=53d4e3f7d2b760bcb4b29e60678b13ec")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let jsonDict = json as? NSDictionary,
            let daily = jsonDict["daily"] as? NSArray{
                
                DispatchQueue.main.async {
                PersistanceRealm.shared.clearWeathers()
                }
                var todayWeather:Weather
                todayWeather = Weather(today: jsonDict)!
                var allWeathers:[Weather]
                allWeathers = []
                allWeathers.append(todayWeather)
                
                for i in 1...6 {
                    var otherWeather:Weather
                    otherWeather = Weather(otherdays: daily[i] as! NSDictionary)!
                    allWeathers.append(otherWeather)
                }
                

                DispatchQueue.main.async {
                    self.delegate?.loaded(weathers: allWeathers)
                }
                }
                
                
               

            }
            
            task.resume()
        }
        
        
    }
