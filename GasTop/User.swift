//
//  User.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

class User : Codable
{
    var id: Int;
    var username: String;
    var email:String;
    
    static private let userDefaults = UserDefaults.standard;

    
    init (id: Int, username: String, email:String)
    {
        self.id = id;
        self.email = email;
        self.username = username;
    }
    
    static func loginLocalUser(id: Int, username: String, email: String) {
        userDefaults.set(email, forKey: "email")
        userDefaults.synchronize()
        userDefaults.set(id, forKey: "id")
        userDefaults.synchronize()
        userDefaults.set(username, forKey: "username")
    }
    
    static func getLoggedUserId() -> Int? {
        return userDefaults.integer(forKey: "id");
    }
    
    static func getLoggedUserUsername() -> String? {
        return userDefaults.string(forKey: "username");
    }
    
    static func getUser (fromId id:Int) -> User? {
        return nil;
    }
}
