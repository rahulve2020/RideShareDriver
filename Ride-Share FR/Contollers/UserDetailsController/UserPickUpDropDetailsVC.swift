//
//  UserPickUpDropDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/07/22.
//

import UIKit

@available(iOS 13.0, *)
class UserPickUpDropDetailsVC: UIViewController {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var dropLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var notesLbl: UILabel!
    @IBOutlet weak var totalPay: UILabel!
    
  //  var objResponse : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func callBtn(_ sender: Any) {
        
    }
    @IBAction func msgBtn(_ sender: Any) {
    }
    @IBAction func cancelBtn(_ sender: Any) {
    }
    @IBAction func goPickUpBtn(_ sender: Any) {
    }
}
