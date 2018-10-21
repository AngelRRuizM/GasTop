//
//  RatingControl.swift
//  PassengerApp
//
//  Created by Comonfort on 4/23/18.
//  Copyright © 2018 Comonfort. All rights reserved.
//

import UIKit

@IBDesignable
class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0.0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    @IBInspectable public var editable: Bool = true
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
        setupButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton) {
        
        if (!editable) {
            return;
        }
        
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        // The possible rating from 1-5, depending on which button was touched
        let selectedRating = index + 1
        
        // If the selected star is full, susbtract half a star
        if selectedRating == Int(ceil(rating)) {
            rating -= 0.5
        }
        else
        {
            //else, the rating is to be set directly to that number of stars
            rating = Double(selectedRating)
        }
        print("rating: " + String(rating))
    }
    
    //MARK: Private Methods
    private func resetHighlightedImg(forButton button: UIButton)
    {
        button.adjustsImageWhenHighlighted = editable
        let highlightImg = UIImage(named: "icons_star_filled_highlighted")
        button.setImage(highlightImg, for: .highlighted)
        button.setImage(highlightImg, for: [.highlighted, .selected])
    }

    
    private func setupButtons() {
        
        // Clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            // Create the button
            let button = UIButton(type: .custom);
            
            // Set the button highlighted image
            resetHighlightedImg(forButton: button)
            
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            let height = self.frame.size.height - 2.0
            let width = self.frame.size.width/CGFloat(starCount)
            
            button.heightAnchor.constraint(equalToConstant: height).isActive = true
            button.widthAnchor.constraint(equalToConstant: width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the rating button array
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        
        //Local rating, in order to assign that amount to all buttons
        var localRating = rating
        
        //References to images
        let emptyStar = UIImage(named: "icon_star_empty" )
        let halfwayFilledStar = UIImage(named: "icon_star_half" )
        let filledStar = UIImage(named: "icon_star_filled" )
        
        //iterate buttons
        for (index, button) in ratingButtons.enumerated() {
            
            //If the rating is greater than 0, the button must be filled
            if localRating > 0.0 {
                
                //Fill completely if the rating allows if there is at least a value of 1
                if localRating >= 1.0
                {
                    button.setImage(filledStar, for: .normal)
                    localRating -= 1.0
                }
                else //else, fill halfway through with the remaining rating
                {
                    button.setImage(halfwayFilledStar, for: .normal)
                    localRating = 0.0
                }
            }
                //Leave the star empty
            else {
                button.setImage(emptyStar, for: .normal)
            }
            
            resetHighlightedImg(forButton: button)
        }
    }
    
}
