//
//  SettingViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 27/06/22.
//

import UIKit
@available(iOS 13.0, *)
class SettingViewController: SidePanelBaseViewController {

    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var vV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        vV.shadow()
  
    }

    

    func deleteAccountDriver() -> Void {
        
    AppServices.shared.getDeleteAccount(success: { (data) in
            print("getFaqDataFromServer\(data!)")

        let datDict = data as? [String : Any]
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
        
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }, failure: {errorMsg in
        self.showOkAlert(errorMsg)
    })
        
    }
    
    
    
    
    @IBAction func menuBtnTapped(_ sender: Any) {
       
          
          let viewMenu = MenuView.fromNib(xibName: "MenuView") as! MenuView
          viewMenu.frame = self.view.frame
          viewMenu.showMenu()
     //     viewMenu.delegate = self
         // viewMenu.newDelegate = self
          self.view.addSubview(viewMenu)
      }
    
    @IBAction func tonggleBtn(_ sender: Any) {
    }
    @IBAction func profileBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
       self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func vehicleManageBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ManageVehicleVC") as! ManageVehicleVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func documentBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateDocumentVC") as! UpdateDocumentVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func deleteAccountBtn(_ sender: Any) {
        var refreshAlert = UIAlertController(title: "Account Detele", message: "Are you sure want to delete your account permanently?.", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.deleteAccountDriver()
          print("Handle Ok logic here")
          }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
          print("Handle Cancel Logic here")
          }))

        present(refreshAlert, animated: true, completion: nil)
    }
    }

