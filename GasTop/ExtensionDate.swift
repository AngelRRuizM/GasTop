//
//  ExtensionDate.swift
//  GasTop
//
//  Created by Alumno on 11/18/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

extension Date {
    
    static func fromString(_ dateStr: String) -> Date {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yy"
        return formater.date(from: dateStr)!
    }
    
    func toString() -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yy";
        return formater.string(from: self);
    }
    
}
