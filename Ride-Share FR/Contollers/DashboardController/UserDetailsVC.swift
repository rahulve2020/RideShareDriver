//
//  UserDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/07/22.
//

import UIKit
import CoreLocation
import GooglePlaces
import GoogleMaps

protocol PopupDelegate {
    
    func rqstAcceptButtonAction(infoLocation:PickLocation, latDrop: Double, longDrop: Double)
    func rqstDeclineButtonAction()
    
}

@available(iOS 13.0, *)
class UserDetailsVC: UIViewController {
    
    var rqstDelegate:PopupDelegate?
    var locationStart = CLLocation()

    @IBOutlet weak var _view: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var dropLbl: UILabel!
    
    @IBOutlet weak var verifyView: UIView!
    @IBOutlet weak var customerImg: UIImageView!
    @IBOutlet weak var customerNameLbl: UILabel!
    @IBOutlet weak var pickLocLbl: UILabel!
    @IBOutlet weak var dropLocLbl: UILabel!
    
    var objResponse : Response?
    var lati : Double?
    var longi : Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        userImg.setImg()
        verifyView.isHidden = true
        
      //  self.customerNameLbl.text = objResponse?.userInfo?.name
        
        self.userNameLbl.text = objResponse?.userInfo?.name                                   // abhishek
        self.customerNameLbl.text = objResponse?.userInfo?.name
        getPickUpAddressFromLatLon()
        getDropUpAddressFromLatLon()
        userImg.sd_setImage(with: URL.init(string:  objResponse?.userInfo!.profile_pic ?? "" )) { (image, error, cache, urls) in
            if (error != nil) {
                self.userImg.image = UIImage(named: "provider_img")
            } else {
                self.userImg.image = image
            }
        }
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self._view.layer.cornerRadius = 12
        self._view.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    
    func getPickUpAddressFromLatLon() {                                             // abhishek
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = objResponse?.pickuplocation?.pickup_latitude ?? 0.0
            //21.228124
            let lon: Double = objResponse?.pickuplocation?.pickup_longitude ?? 0.0
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

                        self.pickUpLbl.text = addressString
                        self.pickLocLbl.text = addressString
                        print(addressString)
                  }
            })

        }
    

    func getDropUpAddressFromLatLon() {                                  // abhishek
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = objResponse?.dropLocation?.drop_latitude ?? 0.0
            //21.228124
            let lon: Double = objResponse?.dropLocation?.drop_longitude ?? 0.0
            //72.833770
           self.lati = objResponse?.dropLocation?.drop_latitude ?? 0.0
           self.longi = objResponse?.dropLocation?.drop_longitude ?? 0.0
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

                        self.dropLbl.text = addressString
                        self.dropLocLbl.text = addressString
                        print(addressString)
                  }
            })

        }
    
    
    
    
    
    func ignorBooking() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
      
        dicParam["orderId"] = objResponse?.orderId

        AppServices.shared.ignorBookingDetails(param: dicParam, success: { (data) in

            debugPrint("changePassword:-\(data!)")

            self.view.removeFromSuperview()


        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    func acceptBooking() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
  
       
        dicParam["orderId"] = objResponse?.orderId

        AppServices.shared.getAcceptBooking(param: dicParam, success: { [self] (data) in

            debugPrint("changePassword:-\(data!)")

            self._view.isHidden = true
            self.verifyView.isHidden = false
            self.rqstDelegate?.rqstAcceptButtonAction(infoLocation: (objResponse?.pickuplocation)!, latDrop: lati ?? 0.0, longDrop: longi ?? 0.0)

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    
    
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;

        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    

    @IBAction func ignoreBtn(_ sender: Any) {
        ignorBooking()
    }
    @IBAction func acceptBtn(_ sender: Any) {
        acceptBooking()
    }
    @IBAction func verifyPinBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserOtpVerificationVC") as! UserOtpVerificationVC
        
        vc.orderId = objResponse?.orderId
        vc.navLat = self.lati
        vc.navLong = self.longi
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func callBtn(_ sender: Any) {
        let phNUmber = objResponse?.userInfo?.mobile_number ?? "0000"
      //  let phNUmber =   "\(objResponse?.driverInfo?.country_code ?? "") - \(objResponse?.driverInfo?.mobile_number)"
       callNumber(phoneNumber: phNUmber)
    }
    @IBAction func messageBtn(_ sender: Any) {
    }
}
