//
//  PersistanceRealm.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import Foundation


import RealmSwift

class Task: Object{
    @objc dynamic var taskDescription = ""
}

class WeatherObj: Object {
    @objc dynamic var temp = 0
    @objc dynamic var humidity = 0
    @objc dynamic var pressure = 0
    @objc dynamic var minTemp = 0
    @objc dynamic var maxTemp = 0
    @objc dynamic var weatherDescription = ""
    @objc dynamic var date = ""
}

class PersistanceRealm {
    static let shared = PersistanceRealm()
    
    private let realm = try! Realm()
    
    func addTask(description:String){
        let task = Task()
        task.taskDescription = description
        try! realm.write{
            realm.add(task)
        }
    }
    
    func getTasks() -> [Task] {
        var outputArr:[Task] = []
        let realmObjects = realm.objects(Task.self)
        
        for object in realmObjects{
            outputArr.append(object)
        }
        
        
        return outputArr
    }
    
    func getTaskByIndex(index: Int) -> Task{
        let tasks = realm.objects(Task.self)
        
        return tasks[index]
    }
    
    func test(){
        let realmObjects = realm.objects(Task.self)
        
        for object in realmObjects{
            print(object.taskDescription)
        }
    }
    
    func deleteTask(index: Int){
        let tasks = realm.objects(Task.self)
        
        let taskToDelete = tasks[index]
        
        try! realm.write{
            realm.delete(taskToDelete)
        }
    }
    
    func addWeather(temp:Int,humidity:Int,pressure:Int,minTemp:Int,maxTemp:Int,weatherDescription:String,date:String){
        let weather = WeatherObj()
        weather.temp = temp
        weather.humidity = humidity
        weather.pressure = pressure
        weather.minTemp = minTemp
        weather.maxTemp = maxTemp
        weather.weatherDescription = weatherDescription
        weather.date = date
        try! realm.write{
            realm.add(weather)
        }
    }
    
    func getAllWeathers() -> [WeatherObj]{
        var weathers:[WeatherObj] = []
        let realmObjects = realm.objects(WeatherObj.self)
        
        for object in realmObjects{
            weathers.append(object)
        }
        
        
        return weathers
    }
    
    func clearWeathers(){
        let weathers = realm.objects(WeatherObj.self)
        for i in weathers{
            try! realm.write{
                realm.delete(i)
            }
        }
    }
}
