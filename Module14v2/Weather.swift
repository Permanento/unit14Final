//
//  Weather.swift
//  Module14v2
//
//  Created by Сергей Гринько on 21.03.2021.
//

import Foundation

class Weather{
    let temp: Int
    let humidity:Int
    let pressure:Int
    let minTemp:Int
    let maxTemp:Int
    let weatherDescription:String
    var date = ""
    
    init?(today:NSDictionary) {
        guard let current = today["current"] as? NSDictionary,
          let temp = current["temp"] as? Double,
          let pressure = current["pressure"] as? Int,
          let humidity = current["humidity"] as? Int,
          let descrContainer = current["weather"] as? NSArray,
          let descr2Container = descrContainer[0] as? NSDictionary,
          let description = descr2Container["description"] as? String,
          let daily = today["daily"] as? NSArray,
          let firstDay = daily[0] as? NSDictionary,
          let minMaxTemp = firstDay["temp"] as? NSDictionary,
          let minTemp = minMaxTemp["min"] as? Double,
          let maxTemp = minMaxTemp["max"] as? Double
        else {
            print("proval")
            return nil
        }
        
       
        func celsius(farenheight:Double) -> Int{
            let cels = Int(round(farenheight - 273.15))
            
            return cels
        }
        
        self.temp = celsius(farenheight: temp)
        self.minTemp = celsius(farenheight: minTemp)
        self.maxTemp = celsius(farenheight: maxTemp)
        self.humidity = humidity
        self.pressure = Int(Double(pressure) / 1.33322)
        self.weatherDescription = description
        DispatchQueue.main.async {
        PersistanceRealm.shared.addWeather(temp: self.temp, humidity: self.humidity, pressure: self.pressure, minTemp: self.minTemp, maxTemp: self.maxTemp, weatherDescription: self.weatherDescription, date: self.date)
        }
    }
 
    
    init?(otherdays:NSDictionary) {
        guard let temp = otherdays["temp"] as? NSDictionary,
              let min = temp["min"] as? Double,
              let max = temp["max"] as? Double,
              let date = otherdays["dt"] as? Int,
              let weather = otherdays["weather"] as? NSArray,
              let weatherElement = weather[0] as? NSDictionary,
              let description = weatherElement["description"] as? String
          
        else {
            print("proval")
            return nil
        }
        
      
        func celsius(farenheight:Double) -> Int{
            let cels = Int(round(farenheight - 273.15))
           
            return cels
        }
        
        self.temp = 0
        self.minTemp = celsius(farenheight: min)
        self.maxTemp = celsius(farenheight: max)
        self.humidity = 0
        self.pressure = 0
        self.weatherDescription = description
        
        
        let dateCreation = Date(timeIntervalSince1970: TimeInterval(date))
        let dateF = DateFormatter()
        dateF.dateStyle = .short
        self.date = dateF.string(from: dateCreation)
        DispatchQueue.main.async {
        PersistanceRealm.shared.addWeather(temp: self.temp, humidity: self.humidity, pressure: self.pressure, minTemp: self.minTemp, maxTemp: self.maxTemp, weatherDescription: self.weatherDescription, date: self.date)
        }
        
    
    }
    
    
    
    
    
    
    
}
