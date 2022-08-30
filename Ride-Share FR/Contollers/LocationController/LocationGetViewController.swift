//
//  LocationGetViewController.swift
//  Haute Delivery
//
//  Created by Preeti malik on 06/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
protocol LocationGetControllerDelegate {
    
    func locationGetData(addressString: GMSAddress?)
    
}
@available(iOS 13.0, *)
class LocationGetViewController: UIViewController {
    
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var imgMarker: UIImageView!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    var gmsAddress: GMSAddress?
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
     var delegateLocation : LocationGetControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    func configureGoogleMap() {
        imgMarker.image = #imageLiteral(resourceName: "drop_off_ic")
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
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        self.present(autocompleteController, animated: true, completion: nil)
    }
    
    @IBAction func btnActionConfirm(_ sender: UIButton) {
        if let objDelegateLocation = delegateLocation {
            objDelegateLocation.locationGetData(addressString: gmsAddress)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let strAddress = lines.joined(separator: "\n")
            //  self.title = strAddress
            self.lblLocation.text = strAddress
            self.gmsAddress = address
            print(strAddress)
        }
    }
    
    func setMapWith(thisCoordinate : CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude:thisCoordinate.latitude,longitude: thisCoordinate.longitude,zoom: 17.5,bearing: 30,viewingAngle: 40)
        vwMap.camera = camera
    }
    
    func loadUI() {
        configureGoogleMap()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
@available(iOS 13.0, *)
extension LocationGetViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
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
extension LocationGetViewController : GMSAutocompleteViewControllerDelegate {
    
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
@available(iOS 13.0, *)
extension LocationGetViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
        vwMap.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
        vwMap.settings.myLocationButton = true // show current location button
//         var lat = (newLocation?.coordinate.latitude)! // get current location latitude
//         var long = (newLocation?.coordinate.longitude)! //get current location longitude

    }
}


