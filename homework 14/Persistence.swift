//
//  Persistence.swift
//  homework 14
//
//  Created by Aleksandr Mayyura on 03.03.2021.
//

import Foundation


class Persistenc {
    static let shared = Persistenc()
    
    private let userNameKey = "Persistenc.userNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: userNameKey)}
        get { return UserDefaults.standard.string(forKey: userNameKey)}
    }
    
    private let userLastNameKey = "Persistenc.userLastNameKey"
    var userLastName: String? {
        set { UserDefaults.standard.set(newValue, forKey: userLastNameKey)}
        get { return UserDefaults.standard.string(forKey: userLastNameKey)}
    }
}
