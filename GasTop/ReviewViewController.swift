//
//  ReviewViewController.swift
//  GasTop
//
//  Created by Alumno on 10/21/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController
{

    var sceneMode: ESceneMode = .NA;
    var byUserId: Int?;
    var forStationId: Int?;
    var review: Review?;
    
    var reviewedGeneral: Bool = false;
    var reviewedGas: Bool = false;
    var reviewedTime: Bool = false;
    var reviewedServices: Bool = false;
    
    private let PLACEHOLDER_TEXTFIELD_TEXT = "Comentarios...";

    //Outlets
    
    @IBOutlet weak var generalScore: RatingControl!
    @IBOutlet weak var generalComments: UITextView!
    
    @IBOutlet weak var magnaPriceText: UITextField!
    @IBOutlet weak var premiumPriceText: UITextField!
    @IBOutlet weak var dieselPriceText: UITextField!
    
    @IBOutlet weak var servicesScore: RatingControl!
    @IBOutlet weak var servicesComments: UITextView!
    
    @IBOutlet weak var gasScore: RatingControl!
    @IBOutlet weak var gasComments: UITextView!
    
    @IBOutlet weak var timeScore: RatingControl!
    @IBOutlet weak var timeComments: UITextView!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSaveButtonEnabled(false);
        
        switch sceneMode {
            case .Create:
                print("Creating new review");
            case .View:
                setOutletData();
                disableEditing();
            
            default:
                fatalError("Review Scene Mode Not Valid \(sceneMode)");
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    @IBAction func save(_ sender: Any) {
        
        switch sceneMode {
            case .Create:
                createAndSaveReview();
                cancel(sender);

            default:
                fatalError("Review Scene Mode Not Valid \(sceneMode)");
        }
        
    }
    
    private func createAndSaveReview() {
        let gralScore = generalScore.rating;
        let gralComment = generalComments.text == PLACEHOLDER_TEXTFIELD_TEXT ? nil : generalComments.text;
        
        let mPrice: Float? = magnaPriceText.text == nil ? nil : Float(magnaPriceText.text!);
        let pPrice: Float? = premiumPriceText.text == nil ? nil : Float(premiumPriceText.text!);
        let dPrice: Float? = dieselPriceText.text == nil ? nil : Float(dieselPriceText.text!);
        
        
        let tScore = reviewedTime ? Float(timeScore.rating) : nil;
        let tComments = timeComments.text == PLACEHOLDER_TEXTFIELD_TEXT ?  nil : timeComments.text;
        
        let gScore = reviewedGas ? Float(gasScore.rating) : nil;
        let gComments = gasComments.text == PLACEHOLDER_TEXTFIELD_TEXT ?  nil : gasComments.text;
        
        let sScore = reviewedServices ? Float(servicesScore.rating) : nil;
        let sComments = servicesComments.text == PLACEHOLDER_TEXTFIELD_TEXT ?  nil : servicesComments.text;
        
        let review = Review(byUser: byUserId!, forGasStation: forStationId!, date: Date(), generalScore: Float(gralScore), generalComment: gralComment, magnaPrice: mPrice,premiumPrice: pPrice, dieselPrice: dPrice, serviceScore: sScore, serviceComment: sComments, timeScore: tScore, timeComment: tComments, gasScore: gScore, gasComment: gComments);
        
        Review.createReview(review);
    }
    
    private func disableEditing() {
        
    }
    
    private func setOutletData() {
        
    }
    
    private func setSaveButtonEnabled(_ state: Bool) {
        saveButton.isEnabled = state;
    }
    
    
    @IBAction func tappedRatingControl(_ sender: Any) {
        
        if let ratingControlTapped = sender as? UIView {
            switch ratingControlTapped.tag {
                case 0:
                    reviewedGeneral = true;
                    setSaveButtonEnabled(true);
                case 1:
                    reviewedServices = true;
                case 2:
                    reviewedTime = true;
                case 3:
                    reviewedGas = true;
            
                default:
                    print ("Unknown tag tapped in gesture recognition");
            }
        }
        else {
            print("Tap Gesture recognizer ttriggered for unknown view")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
