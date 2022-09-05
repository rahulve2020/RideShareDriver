//
//  SideMenuController.swift
//  Haute Delivery
//
//  Created by Preeti malik on 31/05/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//

import UIKit
import AlamofireImage
//import SDWebImage

@available(iOS 13.0, *)
class SideMenuController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var empId: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    
    
    
    
    var identifier : String?
    var arrSideMenu = ["Home","Wallet","History","Setting","Notification","Change Password","Rating","Share","Contact Us","About Us"]
    var arrImage : [UIImage?] = [ UIImage(named: "home_ic"),UIImage(named: "wallet_ic"),UIImage(named: "history_ic"),UIImage(named: "settings_ic"),UIImage(named: "notification_ic"),UIImage(named: "change_password_ic"),UIImage(named: "rating_ic"),UIImage(named: "share_ic"),UIImage(named: "contact_us_ic"),UIImage(named: "about_us_ic")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imgProfile.setImg()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imgProfileActionTapped(sender:)))
        imgProfile.addGestureRecognizer(tapGesture)
     //   loaduiData()
      //  NotificationCenter.default.addObserver(self, selector: #selector(loadUi(notification:)), name: .isProfileUpdate, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        setvalue()
    }
    
    @objc func loadUi(notification: NSNotification){
      //  loaduiData()
    }
    
    func setvalue(){
        
        self.nameLbl.text = DSUserPrefrence.FullName
       self.empId.text = DSUserPrefrence.driver_employee_id
      //  self.numberLbl.text = "\(DSUserPrefrence.country_code) - \(DSUserPrefrence.mobile_number)"
       // self.emailLbl.text = DSUserPrefrence.email_address
        imgProfile.sd_setImage(with: URL.init(string:  DSUserPrefrence.profilePicture )) { (image, error, cache, urls) in
            if (error != nil) {
                self.imgProfile.image = UIImage(named: "")
            } else {
                self.imgProfile.image = image
            }
        }
        
    }
    
//    func loaduiData(){
//        if let objUserDetail = SSAppCacheManager.getCredentials(){
//            imgProfile.layer.cornerRadius = imgProfile.frame.width/2
//            imgProfile.borderWidth = 1
//            imgProfile.borderColor = UIColor.lightGray
//            imgProfile.layer.masksToBounds = true
//            if objUserDetail.restaurants?.images.count > 0 {
//                let image = /(objUserDetail.restaurants?.images[0])
//                if image != "" {
//                    if let urlimage = URL(string: image)  {
//                        imgProfile.af_setImage(withURL:urlimage)
//                    }
//                }
//            }
//            lblFullName.text = /(objUserDetail.restaurants?.name)
//            if !objUserDetail.restaurants!.is_online {
//                btnSwitch.isSelected = false
//                btnSwitch.setImage(#imageLiteral(resourceName: "ic_offline_toggle-1"), for: .normal)
//                lblStatus.text = "Offline"
//                lblStatus.textColor = UIColor.KColorMenuL
//            }else{
//                btnSwitch.setImage(#imageLiteral(resourceName: "ic_online_toggle"), for: .normal)
//                lblStatus.text = "Online"
//                btnSwitch.isSelected = true
//                lblStatus.textColor = UIColor.KColorMenuD
//            }
//        }
//    }
//
   // @IBAction func btnActonSwitch(_ sender: UIButton) {
//        btnSwitch.isSelected = !btnSwitch.isSelected
//        let objUserDetail = SSAppCacheManager.getCredentials()
//        if btnSwitch.isSelected {
//            btnSwitch.setImage(#imageLiteral(resourceName: "ic_online_toggle"), for: .normal)
//            lblStatus.text = "Online"
//            lblStatus.textColor = UIColor.green
//            lblStatus.textColor = UIColor.KColorMenuD
//            objUserDetail?.restaurants?.is_online = true
//        }else{
//            btnSwitch.setImage(#imageLiteral(resourceName: "ic_offline_toggle-1"), for: .normal)
//            lblStatus.text = "Offline"
//            lblStatus.textColor = UIColor.black
//            lblStatus.textColor = UIColor.KColorMenuL
//            objUserDetail?.restaurants?.is_online = false
//        }
//        SSAppCacheManager.setCredentials(obj: objUserDetail!)
//        updateStatus(status: sender.isSelected, restaurantID: /(objUserDetail?.restaurants?._id))
 //   }
    
//    func updateStatus(status : Bool, restaurantID: String?){
//        let dictParametr = ["restaurantId":restaurantID!, "status" : status] as [String : Any]
//        ApiManager.updateStatus(parameter: dictParametr, success: { (dictSuccess) in
//            print(dictSuccess)
//        }, failure: {})
//    }
    
    //MARK: Logout api
//    func logoutGetRequest(){
//        alertMessase(message: "Do you want to logout") {
//            APILoginManager.logOutGetRequest(success: { (dicSuccess) in
//                SSAppCacheManager.removeCredentials()
//                UserSingleton.shared.accessToken = nil
//                let navigationStack = self.navigationController?.viewControllers
//                navigationStack?.forEach({ (controller) in
//                    //                        if controller.isKind(of: LoginViewController.classForCoder()){
//                    //
//                    //                            self.navigationController?.popToViewController(controller, animated: true)
//                    //    }
//                })
//            }, failure: {
//                SSAppCacheManager.removeCredentials()
//                UserSingleton.shared.accessToken = nil
//                let navigationStack = self.navigationController?.viewControllers
//                navigationStack?.forEach({ (controller) in
//                    //                    if controller.isKind(of: LoginViewController.classForCoder()){
//                    //
//                    //                        self.navigationController?.popToViewController(controller, animated: true)
//                    // }
//                })
//            })
//        }
//
//    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        Facade.shared.isLogin = false
        DSUserPrefrence.FullName = ""
        DSUserPrefrence.profilePicture = ""
        DSUserPrefrence.email_address = ""
        DSUserPrefrence.user_ID = ""
        DSUserPrefrence.device_id = ""
        DSUserPrefrence.country_code = ""
        DSUserPrefrence.mobile_number = ""
        DSUserPrefrence.userType = ""
        DSUserPrefrence.Token = ""
        DSUserPrefrence.driver_employee_id = ""
        DSUserPrefrence.latitude = 0.0
        DSUserPrefrence.longitude = 0.0
        DSUserPrefrence.company_name = ""
        DSUserPrefrence.model_of_vehicle = ""
        DSUserPrefrence.vehicle_color = ""
        DSUserPrefrence.plate_number = ""
        DSUserPrefrence.serviceArea = ""
        
        UserDefaults.standard.removeObject(forKey: "password")
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()

        
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func imgProfileActionTapped(sender : UITapGestureRecognizer){
        self.dismissSidePanel()
        //        let profileViewController =  storyboardMain().instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        //        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
   // @IBAction func btnActionLogOut(_ sender: UIButton) {
     //   logoutGetRequest()
 //   }
    
}
@available(iOS 13.0, *)


extension SideMenuController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSideMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        cell.lblName?.text = "   \(arrSideMenu[indexPath.row])"
        cell.imgLeft.image  = arrImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0:
            identifier = "DashboardViewController"
            break
        case 1:
            identifier = "WalletViewController"
            break
        case 2:
            identifier = "RideHistoryVC"
            break
        case 3:
            identifier = "SettingViewController"
            break
        case 4:
            identifier = "NotificationVC"
            break
        case 5:
            identifier = "ChangePasswordVC"
            break
        case 6:
            identifier = "RatingVC"
            break
        case 7:
            identifier = ""
            if let name = URL(string: "https://itunes.apple.com/us/app/myapp/idxxxxxxxx?ls=1&mt=8"), !name.absoluteString.isEmpty {
              let objectsToShare = [name]
              let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
              self.present(activityVC, animated: true, completion: nil)
            } else {
              // show alert for not available
            }
            break
        case 8:
            identifier = "ContactUsVC"
            break
        
        default:
            identifier = "AboutUsVC"
            break
        }
        self.dismissSidePanel()
        if identifier == "AboutUsVC" {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier!) as! AboutUsVC
            
            //vc.isCameFromSideMenu = true
           self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        if identifier != "" {
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dismissSidePanel(){
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
        
    }
    
    
}
