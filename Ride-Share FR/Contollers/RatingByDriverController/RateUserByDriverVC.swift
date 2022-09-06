//
//  RateUserByDriverVC.swift
//  Ride-Share FR
//
//  Created by aditya on 02/09/22.
//

import UIKit
import Cosmos

@available(iOS 13.0, *)
class RateUserByDriverVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var imgDriver: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var txtCommentView: UITextView!
    
    var ratedId : String?
    var placeholder: String?
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCommentView.delegate = self
        placeholder = "Additional Comments...."
        txtCommentView.text = placeholder
        txtCommentView.textColor = UIColor.lightGray
        txtCommentView.selectedTextRange = txtCommentView.textRange(from: txtCommentView.beginningOfDocument, to: txtCommentView.beginningOfDocument)
        lblDriverName.set(text: "4.5", leftIcon: nil, rightIcon: UIImage(named: "star_on_ic"))
    }
    
    
    //MARK:- Action
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        ratingByDriver()
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- API
    
    func ratingByDriver() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["ratedTo_id"] = ratedId
        dicParam["rating"] = self.vwRating.rating
        dicParam["comment"] = self.txtCommentView.text

        AppServices.shared.driverPostRating(param: dicParam, success: { (data) in

            debugPrint("driverRating:-\(data!)")
            let dataObj = data as! [String : Any]
            let dataArray = dataObj["data"] as? [String : Any]
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
           
            self.navigationController?.pushViewController(vc, animated: true)
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
}

@available(iOS 13.0, *)
extension RateUserByDriverVC : UITextViewDelegate {
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
}
