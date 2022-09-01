//
//  UserPickUopDropOffDetailsVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 30/08/22.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

@available(iOS 13.0, *)
class UserPickUopDropOffDetailsVC: UIViewController {
    @IBOutlet weak var userLocationLbl: UILabel!
    
    @IBOutlet weak var pickupLbl: UILabel!
    @IBOutlet weak var dropLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    var locationStart = CLLocation()
    var gmsAddress: GMSAddress?
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var objResponse : Response?
    
    var pickLat : Double?
    var pickLong : Double?
    override func viewDidLoad() {
        super.viewDidLoad()

        getPickUpAddressFromLatLon()
        getDropUpAddressFromLatLon()
        self.nameLbl.text = objResponse?.userInfo?.name
        userImg.sd_setImage(with: URL.init(string:  objResponse?.userInfo!.profile_pic ?? "" )) { (image, error, cache, urls) in
            if (error != nil) {
                self.userImg.image = UIImage(named: "provider_img")
            } else {
                self.userImg.image = image
            }
        }
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
    if let myLocation = currentLocation {
    setMapWith(thisCoordinate: myLocation.coordinate)
        }
          
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("show view")
    }

    override func viewDidLayoutSubviews() {
        if DSUserPrefrence.UserPickUp == true {
            DSUserPrefrence.UserPickUp = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC

            self.addChild(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            print("i am in layout sbview")
        } else {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//
//        self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    func getPickUpAddressFromLatLon() {                                             // abhishek
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = objResponse?.pickuplocation?.pickup_latitude ?? 0.0
            //21.228124
            let lon: Double = objResponse?.pickuplocation?.pickup_longitude ?? 0.0
            //72.833770
        
      //  self.pickLat = objResponse?.pickuplocation?.pickup_latitude ?? 0.0
     //   self.pickLong = objResponse?.pickuplocation?.pickup_longitude ?? 0.0
        
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

                        self.pickupLbl.text = addressString
                       
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
          // self.lati = objResponse?.dropLocation?.drop_latitude ?? 0.0
         //  self.longi = objResponse?.dropLocation?.drop_longitude ?? 0.0
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
                      
                        print(addressString)
                  }
            })

        }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setMapWith(thisCoordinate : CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude:thisCoordinate.latitude,longitude: thisCoordinate.longitude,zoom: 17.5,bearing: 30,viewingAngle: 40)
        
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
    
    @IBAction func callingBtn(_ sender: Any) {
        let phNUmber = objResponse?.userInfo?.mobile_number ?? "0000"
      //  let phNUmber =   "\(objResponse?.driverInfo?.country_code ?? "") - \(objResponse?.driverInfo?.mobile_number)"
       callNumber(phoneNumber: phNUmber)
    }
    @IBAction func msgBtn(_ sender: Any) {
        
    }
    @IBAction func pickUpLocationBtn(_ sender: Any) {
        let saddr = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"
        let destination = "\(self.pickLat ?? 0.0),\(self.pickLong ?? 0.0)"
      
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(saddr)&daddr=\(destination)&directionsmode=driving&zoom=14&views=traffic")!)
        } else {
        print("Can't use comgooglemaps://");
        }
}
}
@available(iOS 13.0, *)
extension UserPickUopDropOffDetailsVC : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      //  reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if (gesture) {
            print("Map will move")
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("didTapMyLocationButton")
        return false
    }
    
}
@available(iOS 13.0, *)
extension UserPickUopDropOffDetailsVC : GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        setMapWith(thisCoordinate: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
@available(iOS 13.0, *)    //abhishek
extension UserPickUopDropOffDetailsVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
      //  vwMap.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
     //   vwMap.settings.myLocationButton = true // show current location button
        locationStart = CLLocation(latitude: (newLocation!.coordinate.latitude) , longitude: (newLocation!.coordinate.longitude))
    }
}

//MARK:- Apple map
//@available(iOS 13.0, *)
//extension UserPickUopDropOffDetailsVC{
//
//    func openMapForPlace(strLatFrom: Double, strlongFrom: Double) {
//        let regionDistance:CLLocationDistance = 10000
//        let coordinates = CLLocationCoordinate2DMake(strLatFrom, strlongFrom)
//        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = "Abhishek"
//        mapItem.openInMaps(launchOptions: options)
//
//    }
//}
