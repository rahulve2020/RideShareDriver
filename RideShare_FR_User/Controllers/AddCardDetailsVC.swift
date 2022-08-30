//
//  AddCardDetailsVC.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 04/07/22.
//

import UIKit

class AddCardDetailsVC: UIViewController {
    @IBOutlet weak var txtHolderName: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtCvvNo: UITextField!
    
    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var cvvView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        load()
        // Do any additional setup after loading the view.
    }
    
    
    func load() {
        nameView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        dateView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        cvvView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        nameView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        dateView.layer.borderWidth = 1
        cvvView.layer.borderWidth = 1
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

extension AddCardDetailsVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtHolderName){
            txtHolderName.resignFirstResponder()
            txtCardNumber.becomeFirstResponder()
            
        }
        else if (textField == txtCardNumber){
            txtCardNumber.resignFirstResponder()
            txtDate.becomeFirstResponder()
            
        }
        else if (textField == txtDate){
            txtDate.resignFirstResponder()
            txtCvvNo.becomeFirstResponder()
        }
        else if (textField == txtCvvNo){
            txtCvvNo.resignFirstResponder()
            
        }
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtHolderName {
            nameView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            nameView.layer.borderWidth = 1
        }
        else if textField == txtCardNumber {
            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            numberView.layer.borderWidth = 1
        }
        else if textField == txtDate {
            dateView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            dateView.layer.borderWidth = 1
        }
        else if textField == txtCvvNo {
            cvvView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            cvvView.layer.borderWidth = 1
        }
       
      
    }
}
