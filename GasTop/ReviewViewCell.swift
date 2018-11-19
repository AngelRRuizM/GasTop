//
//  ReviewViewCell.swift
//  GasTop
//
//  Created by Alumno on 11/17/18.
//  Copyright © 2018 Gekko. All rights reserved.
//

import UIKit

class ReviewViewCell: UITableViewCell {

    var review: Review?;
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var generalCommentLabel: UILabel!
    @IBOutlet weak var generalScore: RatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData() {
        User.getUser(fromId: review!.byUser, callback: updateDataAux);
        
    }
    
    private func updateDataAux(_ user: User?) {
        usernameLabel.text = user!.username;
                
        dateLabel.text = review!.date.toString();
        
        generalCommentLabel.text = review!.generalComment;
        
        generalScore.rating = Double(review!.generalScore);
    }

}
