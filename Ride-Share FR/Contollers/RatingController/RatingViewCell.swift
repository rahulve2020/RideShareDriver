//
//  RatingViewCell.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 30/06/22.
//

import UIKit
import Cosmos

class RatingViewCell: UITableViewCell {

    @IBOutlet weak var tittleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var dateLbl: UILabel!
    
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
