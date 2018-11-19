//
//  GasStation.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation
import MapKit

enum GasStationKeys: String, CodingKey {
    case id = "id";
    case lat = "lat";
    case lng = "lng";
    case name = "name";
    case address = "address"
}

class GasStation: NSObject, Codable, MKAnnotation
{
    static let ROUTE = "/gasStation";
    private static let returnedStationsCallbackDefault: (_ stations: [GasStation]) -> Void = { _ in }
    private static var returnedStationsCallback = returnedStationsCallbackDefault;
    var id: Int;
    var lat: Float;
    var lng: Float;
    var name: String;
    var address: String;
    
    var totalMagnaPrice: Float = 0.0;
    var totalPremiumPrice: Float = 0.0;
    var totalDieselPrice: Float = 0.0;
    var totalGeneralScore: Float = 0.0;
    var totalGasScore: Float = 0.0;
    var totalServiceScore: Float = 0.0;
    var totalTimeScore: Float = 0.0;
    
    var magnaPriceReviews: Int = 0;
    var premiumPriceReviews: Int = 0;
    var dieselPriceReviews: Int = 0;
    var generalScoreReviews: Int = 0;
    var gasScoreReviews: Int = 0;
    var serviceScoreReviews: Int = 0;
    var timeScoreReviews: Int = 0;

    
    //MARK: MKAnnotationProperties
    let coordinate: CLLocationCoordinate2D;
    var title: String? {
        return getMarkerSnippet();
    }
    var subtitle: String? {
        return "";
    }
    
    let mapIconName = "icon_gas_station";

    
    //Needed if coding a "complex" type (CLLocation) that does not conform to Codable
    required init(from decoder: Decoder) throws {        
        let container = try decoder.container(keyedBy: GasStationKeys.self);

        self.id = try container.decode(Int.self, forKey: .id);
        self.lat = try container.decode(Float.self, forKey: .lat);
        self.lng = try container.decode(Float.self, forKey: .lng);
        self.name = try container.decode(String.self, forKey: .name);
        self.address = try container.decode(String.self, forKey: .address);

        self.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat), longitude: Double(self.lng));
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GasStationKeys.self);

        try container.encode(id, forKey: .id);
        try container.encode(lat, forKey: .lat);
        try container.encode(lng, forKey: .lng);
        try container.encode(name, forKey: .name);
        try container.encode(address, forKey: .address);
    }
    
    init(id: Int, lat: Float, lng: Float, name: String, address: String) {

        self.id =  id;
		self.lat =  lat;
		self.lng =  lng;
		self.name =  name;
        self.address = address;

        //Initialize MKAnnotation properties
        coordinate = CLLocationCoordinate2D(latitude: Double(self.lat), longitude: Double(self.lng));
        
        super.init();
    }
    
    /**
    *  Function to create a snippet for the station's marker
    *
    *  @returns markerSnippet a string corresponding to the station's marker's snippet
    */
    func getMarkerSnippet() -> String {
        return name;
    }

	func getAvgMagnaPrice() -> Float {
        if (magnaPriceReviews == 0) {
            return 0;
        }
		return magnaPriceReviews == 0 ? 0 : totalMagnaPrice /  Float(magnaPriceReviews);
	}

	func getAvgPremiumPrice() -> Float {
        if (premiumPriceReviews == 0) {
            return 0;
        }
		return premiumPriceReviews == 0 ? 0 : totalPremiumPrice / Float(premiumPriceReviews);
	}

	func getAvgDieselPrice() -> Float {
        if (dieselPriceReviews == 0) {
            return 0;
        }
		return dieselPriceReviews == 0 ? 0 : totalDieselPrice / Float(dieselPriceReviews);
	}

	func getAvgGeneralScore() -> Float {
        if (generalScoreReviews == 0) {
            return 0;
        }
		return generalScoreReviews == 0 ? 0 : totalGeneralScore / Float(generalScoreReviews);
	}

	func getAvgGasScore() -> Float {
        if (gasScoreReviews == 0) {
            return 0;
        }
		return gasScoreReviews == 0 ? 0 : totalGasScore / Float(gasScoreReviews);
	}

	func getAvgServiceScore() -> Float {
        if (serviceScoreReviews == 0) {
            return 0;
        }
		return serviceScoreReviews == 0 ? 0 : totalServiceScore / Float(serviceScoreReviews);
	}

	func getAvgTimeScore() -> Float {
        if (timeScoreReviews == 0) {
            return 0;
        }
		return timeScoreReviews == 0 ? 0 : totalTimeScore / Float(timeScoreReviews);
	}

    func computeGasStationScoring(fromReviews reviews: [Review]) {
        for review in reviews {
            if (review.magnaPrice != nil){
                magnaPriceReviews += 1;
                totalMagnaPrice += review.magnaPrice!;
            }
            if (review.premiumPrice != nil){
                premiumPriceReviews += 1;
                totalPremiumPrice += review.premiumPrice!;
            }
            if (review.dieselPrice != nil){
                dieselPriceReviews += 1;
                totalDieselPrice += review.dieselPrice!;
            }

            generalScoreReviews += 1;
            totalGeneralScore += review.generalScore;
            
            if (review.serviceScore != nil){
                serviceScoreReviews += 1;
                totalServiceScore += review.serviceScore!;
            }
            if (review.timeScore != nil){
                timeScoreReviews += 1;
                totalTimeScore += review.timeScore!;
            }
            if (review.gasScore != nil){
                gasScoreReviews += 1;
                totalGasScore += review.gasScore!;
            }
        }
    }

    static func getExistingStations(callback: @escaping(_ reviews: [GasStation]) -> Void = { _ in }){
        returnedStationsCallback = callback;
        
        HTTPHandler.makeHTTPGetRequest(route: GasStation.ROUTE, httpBody: nil, callbackFunction: extractStations)
    }
    
    static func getStation(withId id: Int, callback: @escaping(_ reviews: [GasStation]) -> Void = { _ in }) {
        returnedStationsCallback = callback;
        HTTPHandler.makeHTTPGetRequest(route: GasStation.ROUTE + "/\(id)", httpBody: nil, callbackFunction: extractStation)
    }

    private static func extractStations(_ data: Data?) {
        do {
            let stations = try JSONDecoder().decode([GasStation].self, from: data!)

            returnedStationsCallback(stations);
            print ("\nDECODED GAS STATIONS: \(stations)\n")
        }
        catch let jsonError {
            returnedStationsCallback = returnedStationsCallbackDefault;
            print(jsonError);
        }
    }
    private static func extractStation(_ data: Data?) {
        do {
            let station = try JSONDecoder().decode(GasStation.self, from: data!)

            returnedStationsCallback([station]);

            print ("\nDECODED GAS STATION: \(station)\n")
        }
        catch let jsonError {
            returnedStationsCallback = returnedStationsCallbackDefault;
            print(jsonError);
        }
    }
}
