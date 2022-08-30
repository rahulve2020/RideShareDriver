//
//  ConfirmRideViewCell.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 15/07/22.
//

import UIKit
import SOPullUpView

class ConfirmRideViewCell: UITableViewCell {
    @IBOutlet weak var taxiImg: UIImageView!
    @IBOutlet weak var taxiName: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var seatAvailiblityLbl: UILabel!
    
    var updatedDate: String = String()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        taxiImg.setImg()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    var info : VehicleCategoryList?   {
//        didSet {
//
//            self.taxiName.text = self.info?.subcategoryInfo.vehicle_subcategory_name
//            self.timeLbl.text = self.info?.subcategoryInfo.Description
//            self.priceLbl.text = "\((self.info?.subcategoryInfo.totalCharge)!)"
//
//            if let urlImage = URL(string: info?.subcategoryInfo.vehicle_subcategory_picture ?? "") {
//                taxiImg.sd_setImage(with: urlImage, completed: nil)
//            }
//
//    }
//
//
//}
}
