//
//  UserDefaultManager.swift
//  ItunesTestApp
//
//  Created by Николай Петров on 15.04.2022.
//

import UIKit

class DataBase {
    
    static let shared = DataBase()
    
    enum SettingKeys: String {
        case uasers
        case activeUser
        
    }
    
    let defaults = UserDefaults.standard
    let usersKey = SettingKeys.uasers.rawValue
    let activeUserKey = SettingKeys.activeUser.rawValue
    
    var users: [User] {
        get {
            if let data = defaults.value(forKey: usersKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: usersKey)
            }
        }
    }
    
    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String, age: Date) {
        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password, age: age)
        
        users.insert(user, at: 0)
    }
    
    var activeUser: User? {
        get {
            if let data = defaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            } else {
                return nil
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    func saveActiveUser(user: User) {
        activeUser = user
    }
}
