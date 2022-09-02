//
//  RateUserByDriverVC.swift
//  Ride-Share FR
//
//  Created by aditya on 02/09/22.
//

import UIKit
import Cosmos

class RateUserByDriverVC: UIViewController {

    //MARK:- IBOutlet
    @IBOutlet weak var imgDriver: UIImageView!
    @IBOutlet weak var lblDriverName: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    @IBOutlet weak var txtCommentView: UITextView!
    

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Action
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- API
}

