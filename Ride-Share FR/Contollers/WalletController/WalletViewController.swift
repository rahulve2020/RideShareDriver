//
//  WalletViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 01/07/22.
//

import UIKit
import Stripe
import Alamofire
//import StripeCore

//protocol CardListDelegate: class {
//
//    func didSelectCreditCard(model: CardListModel?)
//}

@available(iOS 13.0, *)

class WalletViewController: SidePanelBaseViewController {

    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var lblAccountHolderName: UILabel!
    
    @IBOutlet weak var lblRoutingNumber: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
  
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var addAccount: UIButton!
    @IBOutlet weak var bankImg: UIImageView!
    
    var selectedIndex: Int?
    var isCameFromProfile = false
    var objBankDetails : BankDetails?
   // weak var delegate: CardListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // getBankDetails()
        vV.shadow()
      //  setvalue()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBankDetails()
    }
    func getBankDetails() -> Void {
        
    AppServices.shared.getBankingDetails(success: { (data) in
            print("getFaqDataFromServer\(data!)")

            let dataObj = data as! [String : Any]
            let dataArray = dataObj["driverBankDetail"] as? [String : Any]
            let modelObj = BankDetails.init(driverBankDetail: dataArray!)
        
            self.objBankDetails = modelObj
        
        if dataArray == nil {
            let label = UILabel()
            label.frame = CGRect(x: 140, y: 200, width: 200, height: 50)
            label.text = "No data found"
            self.lblAccountHolderName.isHidden = true
            self.lblRoutingNumber.isHidden = true
            self.lblAccountNumber.isHidden = true
        }
                   
            self.loadData()

    }, failure: {errorMsg in
        self.accountView.isHidden = true
        self.addAccount.isHidden = false
        self.updateBtn.isHidden = true
        self.bankImg.isHidden = false
        self.showOkAlert(errorMsg)
    })
        
    }
    
    func loadData(){
        self.lblAccountNumber.text = "xxxxxxxxxxxx" + (objBankDetails?.last4 ?? "")
        self.lblAccountHolderName.text = objBankDetails?.account_holder_name
        self.lblRoutingNumber.text = objBankDetails?.routing_number
    }

    @IBAction func updateAccountBtn(_ sender: Any) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletAccountDetailsVC") as! WalletAccountDetailsVC
        vc.objBankDetails = objBankDetails
       self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func addAccountBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailsVC") as! AccountDetailsVC
       self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//@available(iOS 13.0, *)
//extension WalletViewController: STPAddCardViewControllerDelegate{
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//        //navigationController?.popViewController(animated: true)
//        self.dismiss(animated: false, completion: nil)
//    }
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
//        print("card token",token)
//        self.dismiss(animated: false, completion: nil)
//        self.addNewBankDetails(cardToken: token.tokenId)
//    }
//}
//@available(iOS 13.0, *)
//extension WalletViewController : STPBankAccountHolderType {
//
//}
//abhishek
