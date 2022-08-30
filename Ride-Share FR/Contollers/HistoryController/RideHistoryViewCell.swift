//
//  RideHistoryViewCell.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 04/07/22.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class RideHistoryViewCell: UITableViewCell {
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var droplbl: UILabel!
    
    var gmsAddress: GMSAddress?
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var historyModel = [HistoryModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.setImg()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func getPickUpAddressFromLatLon(){
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = info?.pickUp_location?.coordinates![1] ?? 0.0
            //21.228124
        let lon: Double = info?.pickUp_location?.coordinates![0] ?? 0.0
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
        let lat: Double = info?.drop_location?.coordinates![1] ?? 0.0
            //21.228124
        let lon: Double = info?.drop_location?.coordinates![0] ?? 0.0
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

                        self.droplbl.text = addressString
                        print(addressString)
                  }
            })

        }
    
    var info : HistoryModel?   {
        didSet {
            self.NameLbl.text = self.info?.UserName
            self.distanceLbl.text = self.info?.total_distance
            getPickUpAddressFromLatLon()
          
            getDropUpAddressFromLatLon()
            
   
            userImg.sd_setImage(with: URL.init(string: info?.UserPic ?? "")) { (image, error, cache, urls) in

                if (error != nil) {

                }else {
                    self.userImg.image = image
                }
        }
    }


}
    
    
    

}
