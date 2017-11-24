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
    
    func update(with dinner: Dinners ){
        // name
        nameLabel.text = dinner.name!
        let friendsArray = dinner.friends as! [String]
        let friends = friendsArray.joined(separator: "-")
        friendsLabel.text = friends
        // set date
        let dinnerDate = dinner.date as Date?
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateLabel.text = dateFormatter.string(from: dinnerDate!)
        // image
        dinnerImage.image = UIImage(data: dinner.picture! as Data)
    }
}
