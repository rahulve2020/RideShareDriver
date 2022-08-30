//
//  VehicleDocumentViewCell.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 24/06/22.
//

import UIKit

class VehicleDocumentViewCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var documentLbl: UILabel!
    @IBOutlet weak var updateBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
