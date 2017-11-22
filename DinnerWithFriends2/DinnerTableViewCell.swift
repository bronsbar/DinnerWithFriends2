//
//  DinnerTableViewCell.swift
//  DinnerWithFriends
//
//  Created by Bart Bronselaer on 7/11/17.
//  Copyright © 2017 Bart Bronselaer. All rights reserved.
//

import UIKit

class DinnerTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
// Outlets
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var friendsLabel: UITextField!
    @IBOutlet weak var dateLabel: UITextField!
    @IBOutlet weak var dinnerImage: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with dinner: DinnerModel ){
        nameLabel.text = dinner.dinnerName
        var friendsGroup: String = ""
        for dinnerFriend in dinner.dinnerFriends {
                friendsGroup.append("\(dinnerFriend) ")
            }
        friendsLabel.text = friendsGroup
        dateLabel.text = dinner.dinnerDate.description
        dinnerImage.image = dinner.dinnerPicture
    }
}
