//
//  Review.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

class GasStation: Codable
{
    var id: Int;
    var byUser: Int;
    var forGasStation: Int;
    var date: Date;

    var generalScore: Float;
    var generalComment: String?;
    var magnaPrice: Float?;
    var premiumPrice: Float?;
    var dieselPrice: Float?;

    var serviceScore: Float?;
    var serviceComment: String?;
    var timeScore: Float?;
    var timeComment: String?;
    var gasScore: Float?;
    var gasComment: String?;



}