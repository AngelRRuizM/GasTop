//
//  ReviewViewController.swift
//  GasTop
//
//  Created by Alumno on 10/21/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController, RatingControlDelegate, UITextViewDelegate, UITextFieldDelegate
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
        
        generalScore.ratingControlDelegate = self;
        servicesScore.ratingControlDelegate = self;
        timeScore.ratingControlDelegate = self;
        gasScore.ratingControlDelegate = self;
        
        generalComments.delegate = self;
        servicesComments.delegate = self;
        timeComments.delegate = self;
        gasComments.delegate = self;
        
        magnaPriceText.delegate = self;
        premiumPriceText.delegate = self;
        dieselPriceText.delegate = self;
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(ReviewViewController.didTapView))
        self.view.addGestureRecognizer(tapRecognizer)
        
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
    
    @objc private func didTapView() {
        self.view.endEditing(true)
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
        
        Review.sendReview(review);
    }
    
    private func disableEditing() {
        generalScore.editable = false;
        servicesScore.editable = false;
        gasScore.editable = false;
        timeScore.editable = false;
        
        magnaPriceText.isUserInteractionEnabled = false;
        premiumPriceText.isUserInteractionEnabled = false;
        dieselPriceText.isUserInteractionEnabled = false;
        
        generalComments.isUserInteractionEnabled = false;
        servicesComments.isUserInteractionEnabled = false;
        timeComments.isUserInteractionEnabled = false;
        gasComments.isUserInteractionEnabled = false;

    }
    
    private func setOutletData() {
        generalScore.rating = Double(review!.generalScore);
        servicesScore.rating = review!.serviceScore != nil ? Double(review!.serviceScore!) : 0;
        gasScore.rating = review!.gasScore != nil ? Double(review!.gasScore!) : 0;
        timeScore.rating = review!.timeScore != nil ? Double(review!.timeScore!) : 0;
        
        magnaPriceText.text = review!.magnaPrice != nil ? "\(review!.magnaPrice!)" : nil;
        premiumPriceText.text = review!.premiumPrice != nil ? "\(review!.premiumPrice!)" : nil;
        dieselPriceText.text = review!.dieselPrice != nil ? "\(review!.dieselPrice!)" : nil;
        
        generalComments.text = review!.generalComment != nil ? "\(review!.generalComment!)" : nil;
        servicesComments.text = review!.serviceComment != nil ? "\(review!.serviceComment!)" : nil;
        timeComments.text = review!.timeComment != nil ? "\(review!.timeComment!)" : nil;
        gasComments.text = review!.gasComment != nil ? "\(review!.gasComment!)" : nil;
    }
    
    private func setSaveButtonEnabled(_ state: Bool) {
        saveButton.isEnabled = state;

    }
    
    //MARK: - UITextView Methods
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == PLACEHOLDER_TEXTFIELD_TEXT
        {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text == ""
        {
            textView.text = PLACEHOLDER_TEXTFIELD_TEXT
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: - UITextField functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Rating Control Delegate
    func ratingChanged(_ ratingControl: RatingControl, fromRating: Float, toRating: Float) {
        switch (ratingControl) {
            case generalScore:
                reviewedGeneral = true;
                setSaveButtonEnabled(true);
            case servicesScore:
                reviewedServices = true;
            case timeScore:
                reviewedTime = true;
            case gasScore :
                reviewedGas = true;
            default:
                print ("Unknown rating control in ReviewVC")
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
