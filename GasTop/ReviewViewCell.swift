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
        let user: User = User.getUser(fromId: review!.byUser)!;
        usernameLabel.text = user.username;
        
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yy"
        dateLabel.text = formater.string(from: review!.date)
        
        generalCommentLabel.text = review!.generalComment;
        
        generalScore.rating = Double(review!.generalScore);
    }

}
