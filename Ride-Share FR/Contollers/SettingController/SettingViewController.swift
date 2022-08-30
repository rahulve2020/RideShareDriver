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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func menuBtnTapped(_ sender: Any) {
       
          
          let viewMenu = MenuView.fromNib(xibName: "MenuView") as! MenuView
          viewMenu.frame = self.view.frame
          viewMenu.showMenu()
          viewMenu.delegate = self
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
}
@available(iOS 13.0, *)
extension SettingViewController: MoveToPreviousViewDelegate {
    func getTapOnHeaderClick() {
        print("")
    }
    
    func moveToPreviousView(selected: Int) {
        if selected == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
           self.navigationController?.pushViewController(vc, animated: true)
           
    //            let appointment = self.storyboard?.instantiateViewController(withIdentifier: "HomeContainerVC")
    //            self.navigationController?.pushViewController(appointment!, animated: true)
        }
        if selected == 1 {
         //   let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
         //   activityVC.popoverPresentationController?.sourceView = self.view
        //    self.present(activityVC, animated: true, completion: nil)
        }
        if selected == 2 {
        //    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyBookingVC") as! //MyBookingVC
         //   self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
           self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 4 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 5{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 6{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RatingVC") as! RatingVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 7{
            
        }
        if selected == 8{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 9{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 10{
        //    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
          //  self.navigationController?.pushViewController(vc, animated: true)
        }
        if selected == 11{
        //    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
          //  self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
