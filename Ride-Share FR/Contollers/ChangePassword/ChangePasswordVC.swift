//
//  ChangePasswordVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 30/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ChangePasswordVC: SidePanelBaseViewController {
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var showOldPassword: UIButton!
    @IBOutlet weak var showNewPassword: UIButton!
    @IBOutlet weak var showConfirmPassword: UIButton!
    
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var oldView: UIView!
    @IBOutlet weak var vV: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        load()
        showOldPassword.isSelected = true
        txtOldPassword.isSecureTextEntry = true
        showNewPassword.isSelected = true
        txtNewPassword.isSecureTextEntry = true
        showConfirmPassword.isSelected = true
        txtConfirmPassword.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    
    func load() {
        oldView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        newView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        confirmView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
     
        oldView.layer.borderWidth = 1
        newView.layer.borderWidth = 1
        confirmView.layer.borderWidth = 1
     
    }

    func changePasword() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
       // dicParam["email"] = DSUserPrefrence.email_address
       // dicParam["mobile"] = DSUserPrefrence.contact_number
        dicParam["oldPassword"] = txtOldPassword.text
        dicParam["newPassword"] = txtNewPassword.text
    //    dicParam["password"] = txtConfirmPassword.text

        AppServices.shared.changePassword(param: dicParam, success: { (data) in

            debugPrint("changePassword:-\(data!)")
            let dataObj = data as! [String : Any]

            self.showOkAlertWithHandler(dataObj["message"] as! String) {
                self.navigationController?.popViewController(animated: true)
            }


        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    @IBAction func oldPasswordTapped(_ sender: Any) {
        showOldPassword.isSelected = !showOldPassword.isSelected
        if showOldPassword.isSelected {
            txtOldPassword.isSecureTextEntry = true
            showOldPassword.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtOldPassword.isSecureTextEntry = false
            showOldPassword.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    @IBAction func newPasswordTapped(_ sender: Any) {
        showNewPassword.isSelected = !showNewPassword.isSelected
        if showNewPassword.isSelected {
            txtNewPassword.isSecureTextEntry = true
            showNewPassword.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtNewPassword.isSecureTextEntry = false
            showNewPassword.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    @IBAction func confirmPasswordTapped(_ sender: Any) {
        showConfirmPassword.isSelected = !showConfirmPassword.isSelected
        if showConfirmPassword.isSelected {
            txtConfirmPassword.isSecureTextEntry = true
            showConfirmPassword.setImage(#imageLiteral(resourceName: "eye_off_ic"), for: .normal)
        }else{
            txtConfirmPassword.isSecureTextEntry = false
            showConfirmPassword.setImage(#imageLiteral(resourceName: "eye_on_ic"), for: .normal)
        }
    }
    
    
    
    @IBAction func saveBtn(_ sender: Any) {
        changePasword()
    }
}
@available(iOS 13.0, *)
extension ChangePasswordVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtOldPassword){
            txtOldPassword.resignFirstResponder()
            txtNewPassword.becomeFirstResponder()
            
        }
        else if (textField == txtNewPassword){
            txtNewPassword.resignFirstResponder()
            txtConfirmPassword.becomeFirstResponder()
            
        }
        else if (textField == txtConfirmPassword){
            txtConfirmPassword.resignFirstResponder()
           
            
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtOldPassword {
            oldView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            oldView.layer.borderWidth = 1
        }
        else if textField == txtNewPassword {
            newView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            newView.layer.borderWidth = 1
        }
        else if textField == txtConfirmPassword {
            confirmView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            confirmView.layer.borderWidth = 1
        }
        
      
    }
}
