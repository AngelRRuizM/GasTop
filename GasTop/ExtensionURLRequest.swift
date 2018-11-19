//
//  ExtensionURLRequest.swift
//  PassengerApp
//
//  Created by Comonfort on 4/30/18.
//  Copyright © 2018 Comonfort. All rights reserved.
//

import Foundation

extension URLRequest {
    
    private func percentEscapeString(_ string: Any) -> String {
        var str: String;
        if (string is String) {
            str = string as! String
        }
        else {
            str = String.init(describing: string);
        }
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return str
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : Any]) {
        httpMethod = "POST"
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
