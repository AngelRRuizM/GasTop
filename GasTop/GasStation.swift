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
    
    init() {

        self.id =  ;
		self.lat =  ;
		self.lng =  ;
		self.name =  ;
		
		self.totalMagnaPrice =  ;
		self.totalPremiumPrice =  ;
		self.totalDieselPrice =  ;
		self.totalGeneralScore =  ;
		self.totalGasScore =  ;
		self.totalServiceScore =  ;
		self.totalTimeScore =  ;
		
		self.magnaPriceReviews =  ;
		self.premiumPriceReviews =  ;
		self.dieselPriceReviews =  ;
		self.generalScoreReviews =  ;
		self.gasScoreReviews =  ;
		self.serviceScoreReviews =  ;
		self.timeScoreReviews =  ;

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
