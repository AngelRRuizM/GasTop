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
    
    case totalMagnaPrice = "totalMagnaPrice";
    case totalPremiumPrice = "totalPremiumPrice";
    case totalDieselPrice = "totalDieselPrice";
    case totalGeneralScore = "totalGeneralScore";
    case totalGasScore = "totalGasScore";
    case totalServiceScore = "totalServiceScore";
    case totalTimeScore = "totalTimeScore";
    
    case magnaPriceReviews = "magnaPriceReviews";
    case premiumPriceReviews = "premiumPriceReviews";
    case dieselPriceReviews = "dieselPriceReviews";
    case generalScoreReviews = "generalScoreReviews";
    case gasScoreReviews = "gasScoreReviews";
    case serviceScoreReviews = "serviceScoreReviews";
    case timeScoreReviews = "timeScoreReviews";
}

class GasStation: NSObject, Codable, MKAnnotation
{
    var id: Int;
    var lat: Float;
    var lng: Float;
    var name: String;
    var address: String;
    
    var totalMagnaPrice: Float;
    var totalPremiumPrice: Float;
    var totalDieselPrice: Float;
    var totalGeneralScore: Float;
    var totalGasScore: Float;
    var totalServiceScore: Float;
    var totalTimeScore: Float;
    
    var magnaPriceReviews: Int;
    var premiumPriceReviews: Int;
    var dieselPriceReviews: Int;
    var generalScoreReviews: Int;
    var gasScoreReviews: Int;
    var serviceScoreReviews: Int;
    var timeScoreReviews: Int;

    
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
        
        self.totalMagnaPrice = try container.decode(Float.self, forKey: .totalMagnaPrice);
        self.totalPremiumPrice = try container.decode(Float.self, forKey: .totalPremiumPrice);
        self.totalDieselPrice = try container.decode(Float.self, forKey: .totalDieselPrice);
        self.totalGeneralScore = try container.decode(Float.self, forKey: .totalGeneralScore);
        self.totalGasScore = try container.decode(Float.self, forKey: .totalGasScore);
        self.totalServiceScore = try container.decode(Float.self, forKey: .totalServiceScore);
        self.totalTimeScore = try container.decode(Float.self, forKey: .totalTimeScore);
        
        self.magnaPriceReviews = try container.decode(Int.self, forKey: .magnaPriceReviews);
        self.premiumPriceReviews = try container.decode(Int.self, forKey: .premiumPriceReviews);
        self.dieselPriceReviews = try container.decode(Int.self, forKey: .dieselPriceReviews);
        self.generalScoreReviews = try container.decode(Int.self, forKey: .generalScoreReviews);
        self.gasScoreReviews = try container.decode(Int.self, forKey: .gasScoreReviews);
        self.serviceScoreReviews = try container.decode(Int.self, forKey: .serviceScoreReviews);
        self.timeScoreReviews = try container.decode(Int.self, forKey: .timeScoreReviews);

        self.coordinate = CLLocationCoordinate2D(latitude: Double(self.lat), longitude: Double(self.lng));
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GasStationKeys.self);

        try container.encode(id, forKey: .id);
        try container.encode(lat, forKey: .lat);
        try container.encode(lng, forKey: .lng);
        try container.encode(name, forKey: .name);
        try container.encode(address, forKey: .address);
        
        try container.encode(totalMagnaPrice, forKey: .totalMagnaPrice);
        try container.encode(totalPremiumPrice, forKey: .totalPremiumPrice);
        try container.encode(totalDieselPrice, forKey: .totalDieselPrice);
        try container.encode(totalGeneralScore, forKey: .totalGeneralScore);
        try container.encode(totalGasScore, forKey: .totalGasScore);
        try container.encode(totalServiceScore, forKey: .totalServiceScore);
        try container.encode(totalTimeScore, forKey: .totalTimeScore);
        
        try container.encode(magnaPriceReviews, forKey: .magnaPriceReviews);
        try container.encode(premiumPriceReviews, forKey: .premiumPriceReviews);
        try container.encode(dieselPriceReviews, forKey: .dieselPriceReviews);
        try container.encode(generalScoreReviews, forKey: .generalScoreReviews);
        try container.encode(gasScoreReviews, forKey: .gasScoreReviews);
        try container.encode(serviceScoreReviews, forKey: .serviceScoreReviews);
        try container.encode(timeScoreReviews, forKey: .timeScoreReviews);
    }
    
    
    init(id: Int, lat: Float, lng: Float, name: String, address: String, totalMagnaPrice: Float, totalPremiumPrice: Float, totalDieselPrice: Float, totalGeneralScore: Float, totalGasScore: Float, totalServiceScore: Float, totalTimeScore: Float, magnaPriceReviews: Int, premiumPriceReviews: Int, dieselPriceReviews: Int, generalScoreReviews: Int, gasScoreReviews: Int, serviceScoreReviews: Int, timeScoreReviews: Int) {

        self.id =  id;
		self.lat =  lat;
		self.lng =  lng;
		self.name =  name;
        self.address = address;
		
		self.totalMagnaPrice =  totalMagnaPrice;
		self.totalPremiumPrice = totalPremiumPrice;
		self.totalDieselPrice =  totalDieselPrice;
		self.totalGeneralScore =  totalGeneralScore;
		self.totalGasScore =  totalGasScore;
		self.totalServiceScore =  totalServiceScore;
		self.totalTimeScore =  totalTimeScore;
		
		self.magnaPriceReviews =  magnaPriceReviews;
		self.premiumPriceReviews =  premiumPriceReviews;
		self.dieselPriceReviews =  dieselPriceReviews;
		self.generalScoreReviews =  generalScoreReviews;
		self.gasScoreReviews =  gasScoreReviews;
		self.serviceScoreReviews = serviceScoreReviews;
		self.timeScoreReviews =  timeScoreReviews;
        
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
		return magnaPriceReviews == 0 ? 0 : totalMagnaPrice /  Float(magnaPriceReviews);
	}

	func getAvgPremiumPrice() -> Float {
		return premiumPriceReviews == 0 ? 0 : totalPremiumPrice / Float(premiumPriceReviews);
	}

	func getAvgDieselPrice() -> Float {
		return dieselPriceReviews == 0 ? 0 : totalDieselPrice / Float(dieselPriceReviews);
	}

	func getAvgGeneralScore() -> Float {
		return generalScoreReviews == 0 ? 0 : totalGeneralScore / Float(generalScoreReviews);
	}

	func getAvgGasScore() -> Float {
		return gasScoreReviews == 0 ? 0 : totalGasScore / Float(gasScoreReviews);
	}

	func getAvgServiceScore() -> Float {
		return serviceScoreReviews == 0 ? 0 : totalServiceScore / Float(serviceScoreReviews);
	}

	func getAvgTimeScore() -> Float {
		return timeScoreReviews == 0 ? 0 : totalTimeScore / Float(timeScoreReviews);
	}

    static func getExistingStations() -> [GasStation] {
        
        let station = GasStation(id: 1, lat: 19.021575, lng: -98.243071, name: "Combustibles Cúmulo de Virgo, S.A. de C.V.", address: "1909, Atlixcáyotl, Reserva Territorial Atlixcáyotl, Corredor Comercial Desarrollo Atlixcayotl, 72830 Puebla, Pue.",totalMagnaPrice: 45, totalPremiumPrice: 30, totalDieselPrice: 49, totalGeneralScore: 9, totalGasScore: 10, totalServiceScore: 8, totalTimeScore: 8.5, magnaPriceReviews: 2, premiumPriceReviews: 2, dieselPriceReviews: 2, generalScoreReviews: 2, gasScoreReviews: 2, serviceScoreReviews: 2, timeScoreReviews: 2);
        
        return [station];
    }
    
    static func getStation(withId id: Int) -> GasStation? {
        return GasStation(id: 1, lat: 19.021575, lng: -98.243071, name: "Combustibles Cúmulo de Virgo, S.A. de C.V.", address: "1909, Atlixcáyotl, Reserva Territorial Atlixcáyotl, Corredor Comercial Desarrollo Atlixcayotl, 72830 Puebla, Pue.",totalMagnaPrice: 45, totalPremiumPrice: 30, totalDieselPrice: 49, totalGeneralScore: 9, totalGasScore: 10, totalServiceScore: 8, totalTimeScore: 8.5, magnaPriceReviews: 2, premiumPriceReviews: 2, dieselPriceReviews: 2, generalScoreReviews: 2, gasScoreReviews: 2, serviceScoreReviews: 2, timeScoreReviews: 2);
    }
}
