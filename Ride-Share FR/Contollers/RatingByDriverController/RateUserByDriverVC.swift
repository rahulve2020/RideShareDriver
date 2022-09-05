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
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

