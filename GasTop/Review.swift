//
//  Review.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

enum ReviewKeys: String, CodingKey {
    case id = "id";
    case byUser = "byUser";
    case forGasStation = "forGasStation";
    case date = "date";

    case generalScore = "generalScore";
    case generalComment = "generalComment";
    case magnaPrice = "magnaPrice";
    case premiumPrice = "premiumPrice";
    case dieselPrice = "dieselPrice";

    case serviceScore = "serviceScore";
    case serviceComment = "serviceComment";
    case timeScore = "timeScore";
    case timeComment = "timeComment";
    case gasScore = "gasScore";
    case gasComment = "gasComment";
}

class Review: Codable
{
    static let ROUTE = "/review";
    private static let returnedReviewsCallbackDefault: (_ reviews: [Review]) -> Void = { _ in }
    private static var returnedReviewsCallback = returnedReviewsCallbackDefault;

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
    
    required init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ReviewKeys.self);

        self.id = try container.decode(Int.self, forKey: .id);
        self.byUser = try container.decode(Int.self, forKey: .byUser);
        self.forGasStation = try container.decode(Int.self, forKey: .forGasStation);

        let dateString = try container.decode(String.self, forKey: .date);
        self.date = Date.fromString(dateString);

        self.generalScore = try container.decode(Float.self, forKey: .generalScore);
        self.generalComment = try? container.decode(String.self, forKey: .generalComment);
        self.magnaPrice = try? container.decode(Float.self, forKey: .magnaPrice);
        self.premiumPrice = try? container.decode(Float.self, forKey: .premiumPrice);
        self.dieselPrice = try? container.decode(Float.self, forKey: .dieselPrice);

        self.serviceScore = try? container.decode(Float.self, forKey: .serviceScore);
        self.serviceComment = try? container.decode(String.self, forKey: .serviceComment);
        self.timeScore = try? container.decode(Float.self, forKey: .timeScore);
        self.timeComment = try? container.decode(String.self, forKey: .timeComment);
        self.gasScore = try? container.decode(Float.self, forKey: .gasScore);
        self.gasComment = try? container.decode(String.self, forKey: .gasComment);
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ReviewKeys.self);

        try container.encode(byUser, forKey: .byUser);
        try container.encode(forGasStation, forKey: .forGasStation);

        let dateString = date.toString();
        try container.encode(dateString, forKey: .date);

        try container.encode(generalScore, forKey: .generalScore);
        try container.encode(generalComment, forKey: .generalComment);
        try container.encode(magnaPrice, forKey: .magnaPrice);
        try container.encode(premiumPrice, forKey: .premiumPrice);
        try container.encode(dieselPrice, forKey: .dieselPrice);

        try container.encode(serviceScore, forKey: .serviceScore);
        try container.encode(serviceComment, forKey: .serviceComment);
        try container.encode(timeScore, forKey: .timeScore);
        try container.encode(timeComment, forKey: .timeComment);
        try container.encode(gasScore, forKey: .gasScore);
        try container.encode(gasComment, forKey: .gasComment);

    }
    
    convenience init (byUser: Int, forGasStation: Int, date: Date, generalScore: Float, generalComment: String?, magnaPrice: Float?,premiumPrice: Float?, dieselPrice: Float?, serviceScore: Float?, serviceComment: String?, timeScore: Float?, timeComment: String?, gasScore: Float?, gasComment: String?) {
        
        self.init (id: -1, byUser: byUser, forGasStation: forGasStation, date: date, generalScore: generalScore, generalComment: generalComment, magnaPrice: magnaPrice, premiumPrice: premiumPrice, dieselPrice: dieselPrice, serviceScore: serviceScore, serviceComment: serviceComment, timeScore: timeScore, timeComment: timeComment, gasScore: gasScore, gasComment: gasComment);
    }

    convenience init(id: Int, byUser: Int, forGasStation: Int, date: Date, generalScore: Float) {
        self.init (id: id, byUser: byUser, forGasStation: forGasStation, date: date, generalScore: generalScore, generalComment: nil, magnaPrice: nil, premiumPrice: nil, dieselPrice: nil, serviceScore: nil, serviceComment: nil, timeScore: nil, timeComment: nil, gasScore: nil, gasComment: nil)
    }

    convenience init(byUser: Int, forGasStation: Int, date: Date, generalScore: Float) {
        self.init (id: -1, byUser: byUser, forGasStation: forGasStation, date: date, generalScore: generalScore, generalComment: nil, magnaPrice: nil, premiumPrice: nil, dieselPrice: nil, serviceScore: nil, serviceComment: nil, timeScore: nil, timeComment: nil, gasScore: nil, gasComment: nil)
    }
    
    func getAsJSONParams() -> [String : String] {
        var jsonDic = [
            "byUser": String(byUser),
            "forGasStation" : String(forGasStation),
            "date" : date.toString(),
            "generalScore" : String(generalScore)
        ];

        if (generalComment != nil) {
            jsonDic["generalComment"] = String(generalComment!);
        }
        if (magnaPrice != nil) {
            jsonDic["magnaPrice"] = String(magnaPrice!);
        }
        if (premiumPrice != nil) {
            jsonDic["premiumPrice"] = String(premiumPrice!);
        }
        if (dieselPrice != nil) {
            jsonDic["dieselPrice"] = String(dieselPrice!);
        }

        if (serviceScore != nil) {
            jsonDic["serviceScore"] = String(serviceScore!);
        }
        if (serviceComment != nil) {
            jsonDic["serviceComment"] = String(serviceComment!);
        }
        if (timeScore != nil) {
            jsonDic["timeScore"] = String(timeScore!);
        }
        if (timeComment != nil) {
            jsonDic["timeComment"] = String(timeComment!);
        }
        if (gasScore != nil) {
            jsonDic["gasScore"] = String(gasScore!);
        }
        if (gasComment != nil) {
            jsonDic["gasComment"] = String(gasComment!)
        }
        
        return jsonDic;
    }

    static func sendReview(_ review: Review) {
        HTTPHandler.makeHTTPPostRequest(route: Review.ROUTE, parameters: review.getAsJSONParams())
    }
    
    static func getReviews(fromUserId id: Int, callback: @escaping(_ reviews: [Review]) -> Void = { _ in }) {

        returnedReviewsCallback = callback;
        HTTPHandler.makeHTTPGetRequest(route: Review.ROUTE + "?byUser=\(id)", httpBody: nil, callbackFunction: extractReviews)
    }
    
    static func getReviews(forGasStationId id: Int, callback: @escaping(_ reviews: [Review]) -> Void = { _ in }) {
        returnedReviewsCallback = callback;
        HTTPHandler.makeHTTPGetRequest(route: Review.ROUTE + "?forGasStation=\(id)", httpBody: nil, callbackFunction: extractReviews)
    }

    private static func extractReviews(_ data: Data?) {
        do {
            let reviews = try JSONDecoder().decode([Review].self, from: data!)
            returnedReviewsCallback(reviews);

            print ("\nDECODED REVIEWS: \(reviews)\n")
        }
        catch let jsonError {
            returnedReviewsCallback = returnedReviewsCallbackDefault
            print(jsonError);
        }
    }
}
