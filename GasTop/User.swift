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
    static let ROUTE = "/users";
    private static var returnedUser: User?;

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
    
    private static func loginLocalUser() {
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
    
    static func getUser (fromId id: Int) -> User? {
        HTTPHandler.makeHTTPGetRequest(route: User.ROUTE + "/\(id)", httpBody: nil, callbackFunction: extractUser)
        return returnedUser;
    }

    static func login(email: String, password: String) -> Bool {
        let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let encodedPassword = password.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        HTTPHandler.makeHTTPPostRequest(route: User.ROUTE + "?email=\(encodedEmail)&password=\(encodedPassword)", parameters: nil, callbackFunction: extractUser);

        if (returnedUser != nil) {
            loginLocalUser();
            return true;
        }
        return false;
    }

    static private func extractUser(_ data: Data?) {
        do {
            let user = try JSONDecoder().decode(User.self, from: data!)
            returnedUser = user;
            print ("\nDECODED USER: \(user)\n")
        }
        catch let jsonError {
            print(jsonError);
        }
    }

}
