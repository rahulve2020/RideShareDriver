//
//  LocationController.swift
//  CherryServices
//
//  Created by Ashish Gupta on 4/26/18.
//  Copyright © 2018 Shashi Saini. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces


protocol LocationControllerDelegate {
    func locationData(addressString: GMSAddress?)
}
@available(iOS 13.0, *)
class LocationController: UIViewController {
    
    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var imgMarker: UIImageView!
    
    @IBOutlet weak var textFieldContainer: UIView!               //abhishek
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    
    var delegateLocation : LocationControllerDelegate?
    var coordinateLatitude: Double?
    var coordinateLongitude: Double?
    var thoroughfare: String?
    var locality: String?
    var subLocality: String?
    var administrativeArea: String?
    var postalCode: String?
    var country: String?
    var line: [String]?
    var currentLocation : CLLocation?
    var gmsAddress: GMSAddress?
    
    var locationAddress1 = ""
    var add0 : String = ""
    
    var isCameFromPlaceOrder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        
        addressTF.delegate = self                            //abhishek
        textFieldContainer.layer.borderWidth = 1.5
        textFieldContainer.layer.cornerRadius = 5.0
        textFieldContainer.clipsToBounds = true
        cancelButton.layer.cornerRadius = cancelButton.bounds.width/2
        cancelButton.clipsToBounds = true                            //abhishek

    }
    override func viewWillLayoutSubviews() {
      //  btnConfirm.gradientBlueColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      //  self.navigationController?.isNavigationBarHidden = false
        
        if isCameFromPlaceOrder{                                          //abhishek
            addressTF.isUserInteractionEnabled = true
            addressTF.isEnabled = true
                addressTF.placeholder = "Select your address"
                cancelButton.isHidden = false
             
                textFieldContainer.layer.borderColor = UIColor.lightGray.cgColor
//        addressTF.isUserInteractionEnabled = false
//        addressTF.isEnabled = false
//            addressTF.placeholder = "Select your address"
//            cancelButton.isHidden = true
//            btnBackS.isHidden = false
//            textFieldContainer.layer.borderColor = UIColor.white.cgColor
        }else{
             textFieldContainer.layer.borderColor = UIColor.lightGray.cgColor
        }
    }                                                    //abhishek
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      //  self.navigationController?.isNavigationBarHidden = true
    }
    
    func configureGoogleMap() {
        imgMarker.image = #imageLiteral(resourceName: "drop_off_ic")
        vwMap.settings.myLocationButton = true;
        vwMap.isMyLocationEnabled = true
        vwMap.delegate = self
        if let myLocation = currentLocation{
            setMapWith(thisCoordinate: myLocation.coordinate)
        }
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let strAddress = lines.joined(separator: "\n")
            self.title = strAddress
            self.addressTF.text = strAddress           //abhishek
            self.coordinateLatitude =  address.coordinate.latitude
            self.coordinateLongitude = address.coordinate.longitude
            self.thoroughfare = address.thoroughfare
            self.locality = address.locality
            self.subLocality = address.subLocality
            self.administrativeArea = address.administrativeArea
            self.postalCode = address.postalCode
            self.country = address.country
            self.line  = address.lines
            self.gmsAddress = address
        }
    }
    
    func setMapWith(thisCoordinate : CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude:thisCoordinate.latitude,longitude: thisCoordinate.longitude,zoom: 17.5,bearing: 30,viewingAngle: 40)
        vwMap.camera = camera
    }
    
    func loadUI() {
        configureGoogleMap()
        btnConfirm.layer.cornerRadius = 4
        btnConfirm.layer.masksToBounds = true
        
    }
    override func viewDidLayoutSubviews() {
      //  btnConfirm.gradientBlueColor()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionConfirm(_ sender: UIButton) {
        if let objDelegateLocation = delegateLocation {
            objDelegateLocation.locationData(addressString: gmsAddress)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    //abhishek
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        addressTF.text = ""
//        addressLocationView.isHidden = true
//        addressView?.isHidden = true
//        self.addressTableView.isScrollEnabled = true
    }
}
@available(iOS 13.0, *)
extension LocationController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if (gesture) {
            debugPrint("Map will move")
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("didTapMyLocationButton")
        return false
    }
}
@available(iOS 13.0, *)
extension LocationController : UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(String(describing: place.name))")
        print("Place address: \(String(describing: place.formattedAddress))")
        setMapWith(thisCoordinate: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    //MARK: User canceled the operation.
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
        if textField == addressTF{
          //  isPickUp = true
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            self.present(autocompleteController, animated: true, completion: nil)
        }
}


}
