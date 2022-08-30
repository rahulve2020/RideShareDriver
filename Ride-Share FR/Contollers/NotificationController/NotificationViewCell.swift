//
//  NotificationViewCell.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/06/22.
//

import UIKit

class NotificationViewCell: UITableViewCell {

    @IBOutlet weak var tittleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
