//
//  GasSationViewController.swift
//  GasTop
//
//  Created by Alumno on 11/11/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class GasSationViewController: UIViewController {

    var sceneMode: ESceneMode = .NA;
    var gasStationId: Int?;
    private var gasStation: GasStation?;
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var magnaPriceText: UITextField!
    @IBOutlet weak var premiumPriceText: UITextField!
    @IBOutlet weak var dieselPriceText: UITextField!
    
    @IBOutlet weak var generalScore: RatingControl!
    @IBOutlet weak var gasScore: RatingControl!
    @IBOutlet weak var servicesScore: RatingControl!
    @IBOutlet weak var timeScore: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gasStation = GasStation.getStation(withId: gasStationId!);
        
        if gasStation != nil {
            navigationItem.title = gasStation!.name;
            
            assignValuesToOutlets();
        }
        else {
            print("Could not load gas station with id \(gasStationId!)");
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if let targetVC = segue.destination as? ReviewViewController {
            
            targetVC.byUserId = User.getLoggedUserId();
            targetVC.forStationId = gasStationId;
            
            targetVC.sceneMode = .Create;
        }
    }
    
    private func assignValuesToOutlets() {
        distanceLabel.text = "768m"
        addressLabel.text = gasStation!.address;
        
        magnaPriceText.text = String(gasStation!.getAvgMagnaPrice());
        premiumPriceText.text = String(gasStation!.getAvgPremiumPrice());
        dieselPriceText.text = String(gasStation!.getAvgDieselPrice());
        magnaPriceText.isUserInteractionEnabled = false;
        premiumPriceText.isUserInteractionEnabled = false;
        dieselPriceText.isUserInteractionEnabled = false;
        
        generalScore.rating = Double(gasStation!.getAvgGeneralScore());
        gasScore.rating = Double(gasStation!.getAvgGasScore());
        servicesScore.rating = Double(gasStation!.getAvgServiceScore());
        timeScore.rating = Double(gasStation!.getAvgTimeScore());
        generalScore.editable = false;
        gasScore.editable = false;
        servicesScore.editable = false;
        timeScore.editable = false;
    }

}

enum ESceneMode {
    case Create;
    case View;
    case Update;
    case NA;
}
