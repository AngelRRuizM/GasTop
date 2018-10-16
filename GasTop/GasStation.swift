//
//  GasStation.swift
//  GasTop
//
//  Created by Alumno on 06/10/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import Foundation

class GasStation: Codable
{
    var id: Int;
    var lat: Float;
    var lng: Float;
    var name: String;
    
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
    
    init(id: Int, lat: Float, lng: Float, name: String, totalMagnaPrice: Float, totalPremiumPrice: Float, totalDieselPrice: Float, totalGeneralScore: Float, totalGasScore: Float, totalServiceScore: Float, totalTimeScore: Float, magnaPriceReviews: Int, premiumPriceReviews: Int, dieselPriceReviews: Int, generalScoreReviews: Int, gasScoreReviews: Int, serviceScoreReviews: Int, timeScoreReviews: Int) {

        self.id =  id;
		self.lat =  lat;
		self.lng =  lng;
		self.name =  name;
		
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
		self.serviceScoreReviews = serviceScoreReviews ;
		self.timeScoreReviews =  timeScoreReviews;
    }
    
    /**
    *  Function to create a snippet for the station's marker
    *
    *  @returns markerSnippet a string corresponding to the station's marker's snippet
    */
    func getMarkerSnippet() -> String {
        return name
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

	
}
