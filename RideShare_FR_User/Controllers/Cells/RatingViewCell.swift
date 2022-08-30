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
    
    var updatedDate: String = String()
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

    
    var info : RatingListModel?   {
        didSet {
            self.tittleLbl.text = self.info?.ratedUser_name
            self.txtLbl.text = self.info?.comment

    //        self.lblDate.text = self.info?.createdAt
        //    self.ratingView.text = "\(self.info?.rating)"
            ratingView.rating =  Double(self.info?.rating ?? 0)
            let model = (self.info?.createdAt)!
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0) as TimeZone
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"//"yyyy-MM-dd HH:mm:ss"
            let valideDate = dateFormatter.date(from: model)
            dateFormatter.date(from: "at")
            dateFormatter.dateFormat = "dd MMM yyyy" //MMM dd, yyyy 'at' h:mm a"
            updatedDate = dateFormatter.string(from: valideDate ?? Date())
            self.dateLbl.text = updatedDate

            img.sd_setImage(with: URL.init(string: info?.ratedUser_profile_pic ?? "")) { (image, error, cache, urls) in

                if (error != nil) {

                }else {
                    self.img.image = image
                }
        }
    }


}
}
