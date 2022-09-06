//
//  ContactUsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 30/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ContactUsVC: SidePanelBaseViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var numberView: UIView!
    
    @IBOutlet weak var msgView: UITextView!
    @IBOutlet weak var txtView: UIView!
    
    var countryCodeSign = "+1"
    var placeholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        load()
        msgView.delegate = self
        placeholder = "Description...."
        msgView.text = placeholder
        msgView.textColor = UIColor.lightGray
        msgView.selectedTextRange = msgView.textRange(from: msgView.beginningOfDocument, to: msgView.beginningOfDocument)
        // Do any additional setup after loading the view.
    }
    func load() {
        nameView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        emailView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        txtView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
     
        nameView.layer.borderWidth = 1
        emailView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        txtView.layer.borderWidth = 1
     
    }

    func contactDetails() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["name"] = self.txtFullName.text
        dicParam["email"] = self.txtEmail.text
        dicParam["country_code"] = self.countryCodeSign
        dicParam["mobile_number"] = self.txtPhoneNumber.text
        dicParam["message"] = self.msgView.text

        AppServices.shared.getInTouch(param: dicParam, success: { (data) in

            debugPrint("contactDetails:-\(data!)")
            let dataObj = data as! [String : Any]

            self.showOkAlertWithHandler(dataObj["message"] as! String) {
              //  self.navigationController?.popViewController(animated: true)
            }

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        contactDetails()
    }
}

@available(iOS 13.0, *)
extension ContactUsVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtFullName){
            txtFullName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            
        }
        else if (textField == txtEmail){
            txtEmail.resignFirstResponder()
            txtPhoneNumber.becomeFirstResponder()
            
        }
        else if (textField == txtPhoneNumber){
            txtPhoneNumber.resignFirstResponder()
          //  msgView.becomeFirstResponder()
            
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtFullName {
            nameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            nameView.layer.borderWidth = 1
        }
        else if textField == txtEmail {
            emailView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            emailView.layer.borderWidth = 1
        }
        else if textField == txtPhoneNumber {
            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            numberView.layer.borderWidth = 1
        }
      
    }
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView == msgView {
//            txtView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
//            txtView.layer.borderWidth = 1
//        }
//
//    }
    
}
@available(iOS 13.0, *)
extension ContactUsVC : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }else {
            return true
        }
        return false
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGray {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == msgView {
            txtView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            txtView.layer.borderWidth = 1
        }
       
    }
}
