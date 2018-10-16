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

    init (id: Int byUser: Int, forGasStation: Int, date: Date, generalScore: Float, generalComment: String?, magnaPrice: Float?,premiumPrice: Float?, dieselPrice: Float?, serviceScore: Float?, serviceComment: String?, timeScore: Float?, timeComment: String?, gasScore: Float?, gasComment: String?) {

        self.id = id;
        self.byUser = byUser;
        self.forGasStation = forGasStation;
        self.date = date;

        self.generalScore = generalScore;
        self.generalComment = generalComment;
        self.magnaPrice = magnaPrice;
        self.premiumPrice = premiumPrice;
        self.dieselPrice = dieselPrice;

        self.serviceScore = serviceScore;
        self.serviceComment = serviceComment;
        self.timeScore = timeScore;
        self.timeComment = timeComment;
        self.gasScore = gasScore;
        self.gasComment = gasComment;
    }
}