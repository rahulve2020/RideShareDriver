//
//  HistoryDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 14/09/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation


class HistoryDetailsVC: UIViewController {

    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var dropOffLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var tipLbl: UILabel!
    
    var gmsAddress: GMSAddress?
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var historyModel = [HistoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        loadData()
        // Do any additional setup after loading the view.
    }
    

    func loadData() {
        self.nameLbl.text = self.historyModel.first?.UserName
        self.distanceLbl.text = self.historyModel.first?.total_distance
        self.timeLbl.text = self.historyModel.first?.total_time
        self.totalAmountLbl.text = self.historyModel.first?.total_Charge
        self.amountLbl.text = self.historyModel.first?.total_Charge
        getPickUpAddressFromLatLon()
        getDropUpAddressFromLatLon()
        if let urlImage = URL(string: historyModel.first?.UserPic ?? "") {
            userImg.sd_setImage(with: urlImage, completed: nil)
        }
}
    
    func getPickUpAddressFromLatLon(){
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = historyModel.first?.pickUp_location?.coordinates![1] ?? 0.0
            //21.228124
        let lon: Double = historyModel.first?.pickUp_location?.coordinates![0] ?? 0.0
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon
        
        print("check3",lat)
              
        print("check4",lon)

            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)


            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    let pm = placemarks as? [CLPlacemark]

                if pm?.count ?? 0 > 0 {
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
                        print(addressString)
                  }
            })
        
        }
    
    
    func getDropUpAddressFromLatLon() {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = historyModel.first?.drop_location?.coordinates![1] ?? 0.0
            //21.228124
        let lon: Double = historyModel.first?.drop_location?.coordinates![0] ?? 0.0
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
                    let pm = placemarks as? [CLPlacemark]

                    if pm?.count ?? 0 > 0 {
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
    
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
