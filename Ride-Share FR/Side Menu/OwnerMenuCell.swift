//
//  OwnerMenuCell.swift
//  Banquet Gem
//
//  Created by Priya Rastogi on 02/03/22.
//

import UIKit

class OwnerMenuCell: UITableViewCell {

    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var _view: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
   
    func populateData(data:arrOwnerMenu){
        imgView.image = UIImage(named: data.icon)
        nameLbl.text =  data.name
      
    }
    
}
