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
    @IBOutlet weak var vV: UIView!
    
    var userProfile = [UserProfile]()
    
    var name : String?
    var email : String?
    var profile : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        img.setImg()
        vV.shadow()
       
       // getProfile()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setvalue()
    }

    func setvalue(){
        
        self.firstNameLbl.text = DSUserPrefrence.FullName
      //  self.lastNameLbl.text = DSUserPrefrence.FullName
        self.numberLbl.text = "\(DSUserPrefrence.country_code) - \(DSUserPrefrence.mobile_number)"
        self.emailLbl.text = DSUserPrefrence.email_address
        if let urlImage = URL(string: DSUserPrefrence.profilePicture) {
            img.sd_setImage(with: urlImage, completed: nil)
        }
//        img.sd_setImage(with: URL.init(string:  DSUserPrefrence.profilePicture )) { (image, error, cache, urls) in
//            if (error != nil) {
//                self.img.image = UIImage(named: "")
//            } else {
//                self.img.image = image
//            }
//        }
        
    }
    
    
//    func getProfile() -> Void {
//        AppServices.shared.getProfileDetails(success: { (data) in
//
//            print("datadatadatadata",data)
//
//            let dataObj = data as! [String : Any]
//            let dataArray = dataObj["data"] as? [String : Any]
//            let modelObj = UserProfile.init(model: dataArray!)
//            self.userProfile.append(modelObj)
//
//            debugPrint("details jobs array",self.userProfile.count)
//            self.loadData()
////
//        }, failure: {errorMsg in })
//    }
    
//    func loadData () {
//        self.firstNameLbl.text = self.userProfile.first?.name
//      //  self.lastNameLbl.text = self.userProfile.first?.last
//        self.emailLbl.text = self.userProfile.first?.email
//    
//        self.numberLbl.text = "\(self.userProfile.first?.mobile_number)"
//      //  self.numberLbl.text = String(describing: self.userProfile.first!.mobile_number)
//      //  self.numberLbl.text = self.userProfile.mobile_number
//
//        img.sd_setImage(with: URL.init(string:  userProfile.first!.profile_pic )) { (image, error, cache, urls) in
//            if (error != nil) {
//                self.img.image = UIImage(named: "")
//            } else {
//                self.img.image = image
//            }
//        }
//        
//    }
    
    
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func updateProfileBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfileVC") as! UpdateProfileVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
//getProfileDetails
