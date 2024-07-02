//
//  UserLocalStore.swift
//  ToDoListApp
//
//  Created by kavita chauhan on 02/07/24.
//

import Foundation

class UserLocalStore{
    
    static let shared = UserLocalStore()
    
    // MARK: Setting
    
    var emailId :String {
        get {
            return UserDefaults.standard.value(forKey: "emailId") as? String ?? "false"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "emailId")
        }
    }
    
    var password :String {
        get {
            return UserDefaults.standard.value(forKey: "password") as? String ?? "false"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
}
