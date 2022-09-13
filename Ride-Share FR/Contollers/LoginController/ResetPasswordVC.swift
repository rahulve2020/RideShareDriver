//
//  ResetPasswordVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 23/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ResetPasswordVC: UIViewController {

    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var showPasswordBtn: UIButton!
    @IBOutlet weak var showConfirmPasswordBtn: UIButton!
    
    var email = String()
    var mobile = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        showPasswordBtn.isSelected = true
        txtPassword.isSecureTextEntry = true
        showConfirmPasswordBtn.isSelected = true
        txtConfirmPassword.isSecureTextEntry = true
        
        confirmView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        passwordView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        passwordView.layer.borderWidth = 1
        confirmView.layer.borderWidth = 1
        // Do any additional setup after loading the view.
    }
    

    func passwordReset () {
    if validation(){
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["email"] = self.email
       // dicParam["mobile"] = self.mobile
        dicParam["newPassword"] = self.txtPassword.text
        dicParam["newPassword"] = self.txtConfirmPassword.text
        
        AppServices.shared.resetPassword(param: dicParam, success: { (data) in
        print("datadatadata:-",data)
        let alert = UIAlertController(title: "", message: (data as? Dictionary<String,Any>)? ["message"] as? String, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
            action in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    }
    
    @IBAction func btnShowPasswordTapped(_ sender: Any) {
        showPasswordBtn.isSelected = !showPasswordBtn.isSelected
        if showPasswordBtn.isSelected {
            txtPassword.isSecureTextEntry = true
            showPasswordBtn.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtPassword.isSecureTextEntry = false
            showPasswordBtn.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    @IBAction func btnShowConfirmPasswordTapped(_ sender: Any) {
        showConfirmPasswordBtn.isSelected = !showConfirmPasswordBtn.isSelected
             if showConfirmPasswordBtn.isSelected {
                 txtConfirmPassword.isSecureTextEntry = true
                 showConfirmPasswordBtn.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
             }else{
                 txtConfirmPassword.isSecureTextEntry = false
                 showConfirmPasswordBtn.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
       passwordReset()
    }
}


@available(iOS 13.0, *)
extension ResetPasswordVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtPassword){
            txtPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
            
        }
        else if (textField == txtConfirmPassword){
            txtConfirmPassword.resignFirstResponder()
            
        }

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtPassword {
            passwordView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            passwordView.layer.borderWidth = 1
        }
        else if textField == txtConfirmPassword {
            confirmView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            confirmView.layer.borderWidth = 1
        }
        else if textField == txtPassword {
        //    vV3.layer.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
         //   vV3.layer.borderWidth = 2
        }
      
    }
}
@available(iOS 13.0, *)
extension ResetPasswordVC {
    func validation() -> Bool
    {
        if (txtPassword.text?.isEmpty)!
        {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirenewPassword) {
            }
            return false
        }
        else if (txtConfirmPassword.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirereEnterPassword) {
            }
            return false
            
        
            
        }
        return true
        
    }
}
