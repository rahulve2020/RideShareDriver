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
    
    var objBankDetails : BankDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        self.txtRoutingNo.text  = self.objBankDetails?.routing_number
        self.txtAccountNo.text = "xxxxxxxxxxxx" + (objBankDetails?.last4 ?? "")
        self.txtHolderName.text = self.objBankDetails?.account_holder_name
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
    func upadteAccount() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["account_holder_name"] = self.txtHolderName.text
        dicParam["routing_number"] = self.txtRoutingNo.text
        dicParam["account_number"] = self.txtAccountNo.text
        

        AppServices.shared.getUpdateAccount(param: dicParam, success: { (data) in

            debugPrint("contactDetails:-\(data!)")
            let dataObj = data as! [String : Any]

            self.showOkAlertWithHandler(dataObj["message"] as! String) {
                self.navigationController?.popViewController(animated: true)
            }

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
        upadteAccount()
    }
}
