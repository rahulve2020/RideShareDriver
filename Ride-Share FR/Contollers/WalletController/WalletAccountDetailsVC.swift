//
//  WalletAccountDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 04/07/22.
//

import UIKit
@available(iOS 13.0, *)
class WalletAccountDetailsVC: UIViewController {

    @IBOutlet weak var txtRoutingNo: UITextField!
    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtAccountNo: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var routingView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func load() {
        nameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        routingView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
      
        nameView.layer.borderWidth = 1
       
        numberView.layer.borderWidth = 1
        routingView.layer.borderWidth = 1
       
     
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
    }
}
