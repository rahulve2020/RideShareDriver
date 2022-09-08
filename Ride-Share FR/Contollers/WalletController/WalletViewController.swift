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

    @IBOutlet weak var vV: UIView!
    
    var selectedIndex: Int?
    var isCameFromProfile = false
   // weak var delegate: CardListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBankDetails()
        vV.shadow()
        // Do any additional setup after loading the view.
    }
    

    func getBankDetails() -> Void {
        
    AppServices.shared.getBankingDetails(success: { (data) in
            print("getFaqDataFromServer\(data!)")

        let datDict = data as? [String : Any]
//        if datDict?["data"] is [[String : Any]] {
//            let dataArray = datDict?["data"] as? [[String : Any]]
//
//            for item in dataArray! {
//                let modelObj = HistoryModel.init(data: item)
//                self.historyModel.append(modelObj)
//            }
//        }
//        self.loadData()
//        self.tableView.reloadData()
        
            
    }, failure: {errorMsg in
        self.showOkAlert(errorMsg)
    })
        
    }
    func addNewBankDetails(cardToken: String){
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["tokenId"] = cardToken
        
        AppServices.shared.getAddBankDetails(param: dicParam, success: { (data) in
           // self.getCardList()
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
   
    
    @IBAction func updateAccountBtn(_ sender: Any) {
        let addCardViewController = STPAddCardViewController()                                                //abhishek
        addCardViewController.delegate = self
        let navigationControler = UINavigationController(rootViewController: addCardViewController)
        self.present(navigationControler, animated: true, completion: nil)
     //   let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletAccountDetailsVC") as! WalletAccountDetailsVC
      // self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

@available(iOS 13.0, *)
extension WalletViewController: STPAddCardViewControllerDelegate{
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        //navigationController?.popViewController(animated: true)
        self.dismiss(animated: false, completion: nil)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        print("card token",token)
        self.dismiss(animated: false, completion: nil)
        self.addNewBankDetails(cardToken: token.tokenId)
    }
}
//@available(iOS 13.0, *)
//extension WalletViewController : STPBankAccountHolderType {
//
//}
