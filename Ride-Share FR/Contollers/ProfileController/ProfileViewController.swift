//
//  ProfileViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ProfileViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var empIdLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var vV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        img.setImg()
        vV.shadow()
       // setvalue()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setvalue()
    }

    func setvalue(){
        
        self.firstNameLbl.text = DSUserPrefrence.FullName
        self.empIdLbl.text = DSUserPrefrence.driver_employee_id
        self.numberLbl.text = "\(DSUserPrefrence.country_code) - \(DSUserPrefrence.mobile_number)"
        self.emailLbl.text = DSUserPrefrence.email_address
     
        self.addressLbl.text = DSUserPrefrence.serviceArea
        img.sd_setImage(with: URL.init(string:  DSUserPrefrence.profilePicture )) { (image, error, cache, urls) in
            if (error != nil) {
                self.img.image = UIImage(named: "")
            } else {
                self.img.image = image
            }
        }
        
    }


    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func updateProfileBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
