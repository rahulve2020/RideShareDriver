//
//  MenuCell.swift
//  Banquet Gem
//
//  Created by Imran on 01/02/22.
//

import UIKit

class MenuCell: UITableViewCell {

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
   
    func populateData(data:arrMenu){
        imgView.image = UIImage(named: data.icon)
        nameLbl.text =  data.name
      
    }
    
}
