//
//  TotalFareDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/08/22.
//

import UIKit
import CoreLocation
import GooglePlaces

@available(iOS 13.0, *)
class TotalFareDetailsVC: UIViewController {
    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var dropOffLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var orderId : String?
    var dropLat : Double?
    var dropLong : Double?
    
    var objResponse : Response?
    
    var totalFareDetails : TotalFareDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vV.shadow()
        
        orderComplete()
    //    getDropUpAddressFromLatLon()

        // Do any additional setup after loading the view.
    }
    
  
    func getDropUpAddressFromLatLon() {                                  // abhishek
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = self.dropLat ?? 0.0    //objResponse?.dropLocation?.drop_latitude ?? 0.0
            //21.228124
        let lon: Double = self.dropLong ?? 0.0    //objResponse?.dropLocation?.drop_longitude ?? 0.0
            //72.833770
        
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks! as [CLPlacemark]

                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country)
                        print(pm.locality)
                        print(pm.subLocality)
                        print(pm.thoroughfare)
                        print(pm.postalCode)
                        print(pm.subThoroughfare)
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                        }
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                        }

                        self.dropOffLbl.text = addressString
                       
                        print(addressString)
                  }
            })

        }
    
    
    func orderComplete() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["orderId"] = self.orderId
        dicParam["drop_latitude"] = dropLat
        dicParam["drop_longitude"] = dropLong

        AppServices.shared.oderCompleteByDriver(param: dicParam, success: { (data) in

            debugPrint("contactDetails:-\(data!)")
            let dataObj = data as! [String : Any]
            let dataArray = dataObj["data"] as? [String : Any]
            let modelObj = TotalFareDetails.init(data: dataArray!)
          
            self.totalFareDetails = modelObj
            self.getDropUpAddressFromLatLon()

            self.loadData()

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    func loadData()  {
        self.amountLbl.text = self.totalFareDetails?.total_Charge
        self.distanceLbl.text = self.totalFareDetails?.total_distance
      //  self.timeLbl.text = "\(self.totalFareDetails?.total_time)"
        if let totalTime = self.totalFareDetails?.total_time {
            self.timeLbl.text = "\(totalTime)"
        }
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
