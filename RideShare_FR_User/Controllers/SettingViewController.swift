//
//  SettingViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 27/06/22.
//

import UIKit

@available(iOS 13.0, *)
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
        
    @IBAction func tonggleBtn(_ sender: Any) {
    }
    @IBAction func profileBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
       self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func paymentMethodBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
       self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}
