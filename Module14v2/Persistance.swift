//
//  Persistance.swift
//  Module14v2
//
//  Created by Сергей Гринько on 19.03.2021.
//

import Foundation


class Persistance{
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    
    var userName: String?{
        set {UserDefaults.standard.set(newValue,forKey: kUserNameKey)}
        get {return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    
    private let kUserLastNameKey = "Persistance.kUserLastNameKey"
    
    var userLastName: String?{
        set {UserDefaults.standard.set(newValue,forKey: kUserLastNameKey)}
        get {return UserDefaults.standard.string(forKey: kUserLastNameKey)}
    }
    
    private let kWeathersArrayKey = "Persistance.kWeathersArrayKey"
    var weathersArray: [Weather]{
        set {UserDefaults.standard.set(newValue,forKey: kWeathersArrayKey)}
        get {return UserDefaults.standard.array(forKey: kWeathersArrayKey) as? [Weather] ?? []}
    }
    
}
