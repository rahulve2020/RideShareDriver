//
//  WalletViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 01/07/22.
//

import UIKit
@available(iOS 13.0, *)
class WalletViewController: SidePanelBaseViewController {

    @IBOutlet weak var vV: UIView!
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
    
   
    
    @IBAction func updateAccountBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WalletAccountDetailsVC") as! WalletAccountDetailsVC
       self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

