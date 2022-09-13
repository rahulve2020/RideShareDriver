//
//  AccountDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/06/22.
//

import UIKit
@available(iOS 13.0, *)
class AccountDetailsVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtRoutingNo: UITextField!
    @IBOutlet weak var txtAccountNo: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var routingView: UIView!
    @IBOutlet weak var numberView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        routingView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        nameView.layer.borderWidth = 1
        routingView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        // Do any additional setup after lo
        // Do any additional setup after loading the view.
    }
    

    func addBAnkDetails() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
  
       
        dicParam["account_holder_name"] = self.txtName.text
        dicParam["routing_number"] = self.txtRoutingNo.text
        dicParam["account_number"] = self.txtAccountNo.text

        AppServices.shared.getAddBankDetails(param: dicParam, success: { [self] (data) in

            debugPrint("changePassword:-\(data!)")
            let dictdata = data as! [String : Any]
            let dataObj = dictdata["data"] as! [String : Any]
            DSUserPrefrence.Token = dataObj["token"] as? String ?? ""
            self.navigationController?.popViewController(animated: true)
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           // self.navigationController?.pushViewController(vc, animated: true)
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addaccountBtn(_ sender: Any) {
        addBAnkDetails()
    }
}
@available(iOS 13.0, *)
extension AccountDetailsVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtName){
            txtName.resignFirstResponder()
            txtRoutingNo.becomeFirstResponder()
            
        }
        else if (textField == txtRoutingNo){
            txtRoutingNo.resignFirstResponder()
            txtAccountNo.becomeFirstResponder()
            
        }
        else if (textField == txtAccountNo){
            txtAccountNo.resignFirstResponder()
          
            
        }

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtName {
            nameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            nameView.layer.borderWidth = 1
        }
        else if textField == txtRoutingNo {
            routingView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            routingView.layer.borderWidth = 1
        }
        else if textField == txtAccountNo {
            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            numberView.layer.borderWidth = 1
        }
      
    }
}

