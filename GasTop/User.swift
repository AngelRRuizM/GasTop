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
    
    init (id: Int, username: String, email:String)
    {
        self.id = id;
        self.email = email;
        self.username = username;
    }
}
