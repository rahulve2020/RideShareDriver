//
//  DashboardViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 27/06/22.
//

import UIKit
import MapKit
//import SideMenu
import GooglePlaces
import GoogleMaps
import CoreLocation
import SidebarOverlay
import SOPullUpView
import SwiftyJSON
import Alamofire

//enum Location1 {
//    case startLocation
//    case destinationLocation
//}

protocol LocationGetControllerDelegate {
    
    func locationGetData(addressString: GMSAddress?)
    
}

var locationAddress1 = ""
@available(iOS 13.0, *)
class DashboardViewController: SidePanelBaseViewController ,SOPullUpViewDataSource{
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var imgMarker: UIImageView!
    @IBOutlet weak var pickUpLbl: UILabel!
    @IBOutlet weak var dropLbl: UILabel!
    
    @IBOutlet weak var txtPickUp: UITextField!
    @IBOutlet weak var txtDropOff: UITextField!
    @IBOutlet weak var vV: UIView!
    
    var gmsAddress: GMSAddress?
    var gmsAddress1: GMSAddress?
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    var delegateLocation : LocationGetControllerDelegate?
    var polyline = GMSPolyline()
    
    var isPickUp: Bool = false
    var add1 : String = ""
    var add0 : String = ""
    
    let pullUpController = SOPullUpControl()

        var bottomPadding: CGFloat {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickUpLbl.isHidden = true
        dropLbl.isHidden = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
        
        configureGoogleMap()
                
//                pullUpController.dataSource = self
//                pullUpController.setupCard(from: view)
              //  showLocations()
        // Do any additional setup after loading the view.
    }
    
    }
//
        
    
    
    func pullUpViewCollapsedViewHeight() -> CGFloat {
            return bottomPadding + 40
       }
       
       func pullUpViewController() -> UIViewController {
        //    guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ConfirmRideVC else {return UIViewController()}
        //    vc.pullUpControl = self.pullUpController
         //   return vc
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmRideVC") as! ConfirmRideVC
           vc.pullUpControl = self.pullUpController
          // self.navigationController?.pushViewController(vc, animated: true)
           return vc
         }

       func pullUpViewExpandedViewHeight() -> CGFloat {
           return 360
       }
    
    
    func configureGoogleMap() {
        imgMarker.image = #imageLiteral(resourceName: "navigation_ic-1")
        vwMap.settings.myLocationButton = true;
        vwMap.isMyLocationEnabled = true
        vwMap.delegate = self
        if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self
//                locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
//                locationManager.distanceFilter = 500
//                locationManager.requestWhenInUseAuthorization()
//                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
          }
        if let myLocation = currentLocation {
            setMapWith(thisCoordinate: myLocation.coordinate)
        }
//        setMapWith(thisCoordinate: currentLocation1!)
    }
    @IBAction func btnActionAutoComplete(_ sender: UIButton) {
            debugPrint(sender.tag)
            if sender.tag == 0{
                add0 = ""
            }else if sender.tag == 1{
                add1 = ""
            }
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            self.present(autocompleteController, animated: true, completion: nil)
        }
    @IBAction func searchNearbyBtn(_ sender: Any) {
        if validation() {
        pullUpController.dataSource = self
        pullUpController.setupCard(from: view)
        self.vV.isHidden = true
        }
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmRideVC") as! ConfirmRideVC
      //  self.navigationController?.pushViewController(vc, animated: true)
//        if validation() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverDetailsVC") as! DriverDetailsVC
//        self.addChild(vc)
//        vc.view.frame = self.view.frame
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, placeName : String) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let strAddress = lines.joined(separator: "\n")
            //  self.title = strAddress
//            self.txtPickUp.text = strAddress
//            self.txtDropOff.text = strAddress
//            self.gmsAddress = address
//            print(strAddress)
            
            
            if self.isPickUp{
                self.add1 = strAddress
                self.txtDropOff.text = strAddress
                self.isPickUp = false
                self.gmsAddress1 = address
               // locationAddress4 = placeName

            }else{
                self.add0 = strAddress
                self.txtPickUp.text = strAddress
                self.gmsAddress = address
                locationAddress1 = placeName

            }
        }
    }
    func setMapWith(thisCoordinate : CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude:thisCoordinate.latitude,longitude: thisCoordinate.longitude,zoom: 17.5,bearing: 30,viewingAngle: 40)
        vwMap.camera = camera
    }
    
    func loadUI() {
        configureGoogleMap()
    }

}

@available(iOS 13.0, *)
extension DashboardViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target, placeName: "")
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
extension DashboardViewController : UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        setMapWith(thisCoordinate: place.coordinate)
        reverseGeocodeCoordinate(place.coordinate, placeName: place.name ?? "")
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtPickUp{
          //  isPickUp = true
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            self.present(autocompleteController, animated: true, completion: nil)
        }
        if textField == txtDropOff {
            isPickUp = true
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            self.present(autocompleteController, animated: true, completion: nil)
        }
}
    
}
@available(iOS 13.0, *)
extension DashboardViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
        vwMap.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
        vwMap.settings.myLocationButton = true // show current location button
//         var lat = (newLocation?.coordinate.latitude)! // get current location latitude
//         var long = (newLocation?.coordinate.longitude)! //get current location longitude

    }
}

@available(iOS 13.0, *)
extension DashboardViewController {
    func validation() -> Bool
    {
        if (txtPickUp.text?.isEmpty)!
        {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirePickUpLocation) {
            }
            return false
        }
        else if (txtDropOff.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireDropOffLocation) {
            }
            return false
            
        
            
        }
        return true
        
    }
}
