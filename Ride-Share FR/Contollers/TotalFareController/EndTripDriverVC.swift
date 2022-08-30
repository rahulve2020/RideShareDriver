//
//  EndTripDriverVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/08/22.
//

import UIKit

@available(iOS 13.0, *)
class EndTripDriverVC: UIViewController {

    @IBOutlet weak var tripView: UIView!
    
    var orderId : String?
    var dropLat : Double?
    var dropLong : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripView.shadow()

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
    @IBAction func endTripBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TotalFareDetailsVC") as! TotalFareDetailsVC
        vc.orderId = orderId
        vc.dropLat = dropLat
        vc.dropLong = dropLong
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
