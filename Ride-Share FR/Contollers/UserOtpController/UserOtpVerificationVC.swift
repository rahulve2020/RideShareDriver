//
//  UserOtpVerificationVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 10/08/22.
//

import UIKit
import PinCodeTextField
import GoogleMaps
import GooglePlaces
import CoreLocation


@available(iOS 13.0, *)

class UserOtpVerificationVC: UIViewController {
    @IBOutlet weak var pinCodeTxt: PinCodeTextField!
    
    @IBOutlet weak var startRide: UIButton!
    var orderId : String?
    var objResponse : Response?
    
    var navLat : Double?
    var navLong : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    

    
    
    func verifyUserOtpApi(){
        var dicParam : Dictionary<String,Any> = Dictionary()
        
        dicParam["otp"] = pinCodeTxt.text
        dicParam["orderId"] = self.orderId
        AppServices.shared.userOTP(param: dicParam, success: { (data) in
            print("datadatadata:-",data)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
            vc.onButton = true
            vc.objResponse = self.objResponse
            vc.orderId = self.orderId
            vc.latDrop = self.navLat
            vc.longDrop = self.navLong
            self.navigationController?.pushViewController(vc, animated: true)
         
        //    self.startRide.isHidden = false
        
        }, failure: {errorMsg in })
    }
    

    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func verifyOtpBtn(_ sender: Any) {
        verifyUserOtpApi()
        

}
    @IBAction func startRideTapped(_ sender: Any) {
      //  startOrder()
//        let strLat = "28.887211"
//        let strLong = "78.471977"
//        let strLat1 = "28.838648"
//        let strLong2 = "78.773331"
//        let saddr = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"
//        let infoLocation = "\(objResponse?.dropLocation?.drop_latitude),\(objResponse?.dropLocation?.drop_longitude)"
//        
//            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//                UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(saddr)&daddr=\(infoLocation)&directionsmode=driving&zoom=14&views=traffic")!)
//                }
//                else {
//                print("Can't use comgooglemaps://");
//                    }
}
    
    
    
    
    
}
