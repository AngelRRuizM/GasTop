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
    static let ROUTE = "/user";
    private static var userResultCallback = userResultCallbackDefault
    private static let userResultCallbackDefault = { (_ user: User?) -> Void in }


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
    
    private static func loginLocalUser(_ user: User) {
        userDefaults.set(user.email, forKey: "email")
        userDefaults.synchronize()
        userDefaults.set(user.id, forKey: "id")
        userDefaults.synchronize()
        userDefaults.set(user.username, forKey: "username")
    }
    
    static func getLoggedUserId() -> Int? {
        return userDefaults.integer(forKey: "id");
    }
    
    static func getLoggedUserUsername() -> String? {
        return userDefaults.string(forKey: "username");
    }
    
    static func getUser (fromId id: Int, callback: @escaping (_ user: User?) -> Void = { _ in }) {
        userResultCallback = callback;
        HTTPHandler.makeHTTPGetRequest(route: User.ROUTE + "/\(id)", httpBody: nil, callbackFunction: extractUser)

    }
    
    static func logout() {
        let domain = Bundle.main.bundleIdentifier!
        userDefaults.removePersistentDomain(forName: domain)
        userDefaults.synchronize()
    }

    static func login(email: String, password: String,callback: @escaping (_ user: User?) -> Void = { _ in }) {
        let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        userResultCallback = callback;

        HTTPHandler.makeHTTPGetRequest(route: User.ROUTE + "?email=\(encodedEmail)&password=\(encodedPassword)", httpBody: nil, callbackFunction: login)
    }

    static private func extractUser(_ data: Data?) {
        do {
            let user = try JSONDecoder().decode(User.self, from: data!)
            print ("\nDECODED USER: \(user.username)\n")
            userResultCallback(user);
        }
        catch let jsonError {
            userResultCallback = userResultCallbackDefault;
            print(jsonError);
        }
    }
    
    static private func login(_ data: Data?) {
        do {
            let users = try JSONDecoder().decode([User].self, from: data!)
            
            if (users.count > 0) {
                let user = users[0];
                print ("\nLogin in: \(user.username)\n")
                loginLocalUser(user);
                userResultCallback(user);
                return;
            }
            
        }
        catch let jsonError {
            
            print(jsonError);
        }
        userResultCallback (nil);
        userResultCallback = userResultCallbackDefault;
        logout();
    }

}
