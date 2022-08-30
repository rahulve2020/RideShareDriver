//
//  WalletViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 01/07/22.
//

import UIKit
@available(iOS 13.0, *)
class WalletViewController: SidePanelBaseViewController {

    @IBOutlet weak var vV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    
    @IBAction func updateAccountBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletAccountDetailsVC") as! WalletAccountDetailsVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
}

