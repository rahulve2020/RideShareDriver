//
//  ForgetPasswordVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 23/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var numberView: UIView!
    
    @IBOutlet weak var txtNumber: UITextField!
    
    var isComing = "forget"
    var strMobile = String()
    var strEmail = String()
    var countryCodeSign = "+1"
    override func viewDidLoad() {
        super.viewDidLoad()

        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderWidth = 1
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

    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendOtpBtn(_ sender: Any) {
        self.view.endEditing(true)
        if checkTextFieldValidationMethod() {
            var dicParam : Dictionary<String,Any> = Dictionary()
            
            dicParam["mobile_number"] = self.txtNumber.text!
            dicParam["country_code"] = countryCodeSign
            
            AppServices.shared.forgotPassword(param: dicParam, success: { (data) in
                print("datadatadata:-",data)
                let dictdata = data as! [String : Any]
                let dataObj = dictdata["data"] as! [String : Any]
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVerificationVC") as! OtpVerificationVC
                vc.type = "forget"
                vc.isOTPForgot = true
                vc.mobileNumber = self.txtNumber.text!//self.strMobile
                vc.strCountryCode = self.countryCodeSign
                vc.email = dataObj["email"] as! String
                print(dataObj["email"] as! String)
                self.navigationController?.pushViewController(vc, animated: true)
            }, failure: {errorMsg in
                self.showOkAlert(errorMsg)
            })
        }

    }
}

@available(iOS 13.0, *)
extension ForgetPasswordVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        numberView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        numberView.layer.borderWidth = 1
        
      
    }
}
@available(iOS 13.0, *)
extension ForgetPasswordVC {
    // MARK: - Check Validation Method
    func checkTextFieldValidationMethod() ->Bool {
        if (txtNumber.text?.isEmpty)!
        {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireMobile) {
            }
            return false
        }
        
        return true
        
    }
}
