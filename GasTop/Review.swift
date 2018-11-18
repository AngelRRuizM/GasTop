//
//  Review.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

class Review: Codable
{
    static let ROUTE = "/reviews";
    private static var returnedReviews: [Review] = [];

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
    
    init (id: Int, byUser: Int, forGasStation: Int, date: Date, generalScore: Float, generalComment: String?, magnaPrice: Float?,premiumPrice: Float?, dieselPrice: Float?, serviceScore: Float?, serviceComment: String?, timeScore: Float?, timeComment: String?, gasScore: Float?, gasComment: String?) {

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
    
    convenience init (byUser: Int, forGasStation: Int, date: Date, generalScore: Float, generalComment: String?, magnaPrice: Float?,premiumPrice: Float?, dieselPrice: Float?, serviceScore: Float?, serviceComment: String?, timeScore: Float?, timeComment: String?, gasScore: Float?, gasComment: String?) {
        
        self.init (-1, byUser, forGasStation, date, generalScore, generalComment, magnaPrice, premiumPrice, dieselPrice, serviceScore, serviceComment, timeScore, timeComment, gasScore, gasComment);
    }

    convenience init(id: Int, byUser: Int, forGasStation: Int, date: Date, generalScore: Float) {
        self.init (id, byUser, forGasStation, date, generalScore, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    }

    convenience init(byUser: Int, forGasStation: Int, date: Date, generalScore: Float) {
        self.init (-1, byUser, forGasStation, date, generalScore, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
    }
    
    func getAsJSONParams() -> [String : String] {
        let jsonDic = [
            "byUser": String(byUser),
            "forGasStation" = String(forGasStation),
            "date" = String(date),
            "generalScore" = String(generalScore)
        ];

        if (generalComment != nil) {
            jsonDic["generalComment"] = String(generalComment);
        }
        if (magnaPrice != nil) {
            jsonDic["magnaPrice"] = String(magnaPrice);
        }
        if (premiumPrice != nil) {
            jsonDic["premiumPrice"] = String(premiumPrice);
        }
        if (dieselPrice != nil) {
            jsonDic["dieselPrice"] = String(dieselPrice);
        }

        if (serviceScore != nil) {
            jsonDic["serviceScore"] = String(serviceScore);
        }
        if (serviceComment != nil) {
            jsonDic["serviceComment"] = String(serviceComment);
        }
        if (timeScore != nil) {
            jsonDic["timeScore"] = String(timeScore);
        }
        if (timeComment != nil) {
            jsonDic["timeComment"] = String(timeComment);
        }
        if (gasScore != nil) {
            jsonDic["gasScore"] = String(gasScore);
        }
        if (gasComment != nil) {
            jsonDic["gasComment"] = String(gasComment)
        }
    }

    static func sendReview(_ review: Review) {
        HTTPHandler.makeHTTPPostRequest(route: Review.ROUTE, parameters: review.getAsJSONParams())
    }
    
    static func getReviews(fromUserId id: Int) -> [Review] {

        HTTPHandler.makeHTTPGetRequest(route: Review.ROUTE + "?byUser=\(id)", httpBody: nil, callbackFunction: extractReviews)
        return returnedReviews;
    }
    
    static func getReviews(forGasStationId id: Int) -> [Review] {
        HTTPHandler.makeHTTPGetRequest(route: Review.ROUTE + "?forGasStation=\(id)", httpBody: nil, callbackFunction: extractReviews)
        return returnedReviews;
    }

    private static func extractReviews(_ data: Data?) {
        do {
            let reviews = try JSONDecoder().decode([Review].self, from: data!)

            returnedReviews.removeAll();
            returnedReviews += reviews;

            print ("\nDECODED REVIEWS: \(reviews)\n")
        }
        catch let jsonError {
            print(jsonError);
        }
    }
}
