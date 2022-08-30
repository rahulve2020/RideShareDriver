//
//  AddCardViewCell.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 18/07/22.
//

import UIKit

class AddCardViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var btnRemoveCard: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
