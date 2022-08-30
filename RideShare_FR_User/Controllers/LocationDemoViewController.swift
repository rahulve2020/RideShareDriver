//
//  LocationDemoViewController.swift
//  Haute Delivery
//
//  Created by Preeti malik on 04/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import SwiftyJSON
import Alamofire
import SidebarOverlay
import SOPullUpView
import MapKit
import Firebase




enum Location1 {
    case startLocation
    case destinationLocation
}
@available(iOS 13.0, *)
class LocationDemoViewController: SidePanelBaseViewController,SOPullUpViewDataSource {
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var destinationLocation: UITextField!
    @IBOutlet weak var imgMarker: UIImageView!
    
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var destinationBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    //car animation
    private var myLocationMarker: GMSMarker!
    private var carAnimator: CarAnimator!
    private var stopped = false
    
    var locationManager = CLLocationManager()
    var locationSelected = Location1.startLocation
    var polyline = GMSPolyline()
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    var driveLocLat : Double?
    var driveLocLong : Double?
    
    
    var isPickUp: Bool = false
    var add1 : String = ""
    var add0 : String = ""
    var gmsAddress: GMSAddress?
    var gmsAddress1: GMSAddress?
    var locationAddress1 = ""
    var locationAddress4 = ""
    var currentLocation : CLLocation?
    var currentLocation1: CLLocationCoordinate2D?
   
    
    var pickLatitude : Double?
    var pickLongitude : Double?
    var dropLatitude : Double?
    var dropLongitude : Double?
    
   // var dbRef : DatabaseReference?
//    var driverAnnotation : MKPointAnnotation?
    
    let pullUpController = SOPullUpControl()
    
    var objResponse : Response?                          //abhishek
    //var driverLoc = objResponse?.driverInfo?.driverLocation?.coordinates![0]

        var bottomPadding: CGFloat {
            let window = UIApplication.shared.keyWindow
            return window?.safeAreaInsets.top ?? 0.0
        }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        let name = Notification.Name("updateDriver")
        NotificationCenter.default.addObserver(self, selector: #selector(updateDrivers(_:)), name: name, object: nil)
 
        loadUI()
       // configureMapStyle()
       // googleMaps.drawPath(GMSMapView.pathString)
      //  addButtons()
     //   LocationTracker.shared.locateMeOnLocationChange { [weak self]  _  in
       //     self?.moveCarMarker()
     //   }
        
    }
    func moveCarMarker() {
        if let myLocation = LocationTracker.shared.lastLocation,
            myLocationMarker == nil {
            myLocationMarker = GMSMarker(position: myLocation.coordinate)
            myLocationMarker.icon = UIImage(named: "car")
            myLocationMarker.map = self.googleMaps
            carAnimator = CarAnimator(carMarker: myLocationMarker, mapView: googleMaps)
            self.googleMaps.updateMap(toLocation: myLocation, zoomLevel: 16)
        } else if let myLocation = LocationTracker.shared.lastLocation?.coordinate, let myLastLocation = LocationTracker.shared.previousLocation?.coordinate {
            if !stopped {
                carAnimator.animate(from: myLastLocation, to: myLocation)
            }
        }
    }
    // MARK: UI Configuration

    private func configureMapStyle() {
        googleMaps.mapStyle = mapStyle(traitCollection.userInterfaceStyle)
    }
    private func addButtons() {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        googleMaps.addSubview(playButton)
        playButton.addTarget(self, action: #selector(resumeMarker), for: .touchUpInside)
        
        let pauseButton = UIButton()
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        googleMaps.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(pauseMarker), for: .touchUpInside)
        
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .black, scale: .large)
            playButton.setImage(UIImage(systemName: "play.circle.fill",withConfiguration: config), for: .normal)
            pauseButton.setImage(UIImage(systemName: "pause.circle.fill",withConfiguration: config), for: .normal)
            playButton.tintColor = .routeColor
            pauseButton.tintColor = .routeColor
        } else {
            playButton.setImage(UIImage(named: "playIcon"), for: .normal)
            pauseButton.setImage(UIImage(named: "pauseIcon"), for: .normal)
        }
        
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            pauseButton.heightAnchor.constraint(equalToConstant: 60),
            pauseButton.widthAnchor.constraint(equalToConstant: 60),
            
            playButton.bottomAnchor.constraint(equalTo: googleMaps.bottomAnchor, constant: -20),
            pauseButton.bottomAnchor.constraint(equalTo: googleMaps.bottomAnchor, constant: -20),
            
            playButton.centerXAnchor.constraint(equalTo: googleMaps.centerXAnchor, constant: -40),
            pauseButton.centerXAnchor.constraint(equalTo: googleMaps.centerXAnchor, constant: 40),
        ])
    }
    // MARK: Helpers

    private func mapStyle(_ style: UIUserInterfaceStyle) -> GMSMapStyle? {
        let styleResourceName = "mapStyle\(style.rawValue)"
        guard let styleURL = Bundle.main.url(forResource: styleResourceName, withExtension: "json") else { return nil }
        let mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        return mapStyle
    }
    //MARK: Selectors
    
    @objc func resumeMarker() {
        guard let markerLayer = carAnimator?.carMarker.layer else { return }
        stopped = false
        carAnimator.resumeLayer(layer: markerLayer)
    }
    @objc func pauseMarker() {
        guard let markerLayer = carAnimator?.carMarker.layer else { return }
        stopped = true
        carAnimator.pauseLayer(layer: markerLayer)
    }
    
    

    override func viewWillAppear(_ animated: Bool) {

      //  configureGoogleMap()
        
    }
    @objc func updateDrivers(_ notification:Notification) {
        
        
        if let notification = notification.userInfo?["gcm.notification.aps"] as? String, let jsonData = notification.data(using: .utf8)
        {
            
            let objUser = Response.objUserCredentials(fromDict: jsonData)
             configureMapStyle()
             googleMaps.drawPath(GMSMapView.pathString)
            // addButtons()
             LocationTracker.shared.locateMeOnLocationChange { [weak self]  _  in
                 self?.moveCarMarker()
             }
           // drawPathDriver(obj: objUser!)
            
         //   print(objUser!.driverInfo!.driverLocation!.coordinates![1], objUser!.driverInfo!.driverLocation!.coordinates![0], self.locationStart.coordinate.latitude, self.locationStart.coordinate.longitude)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CabDetailsViewController") as! CabDetailsViewController
        
            self.addChild(vc)
            vc.objResponse = objUser
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
            drawPathDriver(obj: objUser!)
         //   self.drawPath(startLocation: locationStart, endLocation: locationEnd)
        
    //    let obj = Response.objUserCredentials(fromDict: notification.userInfo)
      //  print(objUser?.orderId)
     }
        
    }
//    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
//                UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(strLat),\(strLong)&daddr=\(strLat1),\(strLong2)&directionsmode=driving&zoom=14&views=traffic")!)
//            }
//            else {
//                print("Can't use comgooglemaps://");
//            }
    
    func configureGoogleMap() {
        imgMarker.image = #imageLiteral(resourceName: "droff_ic")
        googleMaps.delegate = self
        googleMaps.settings.myLocationButton = true;
        googleMaps.isMyLocationEnabled = true
        
    
        if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self

                locationManager.startUpdatingLocation()
          }
        if let myLocation = currentLocation{
            setMapWith(thisCoordinate: myLocation.coordinate)
        }
    }
    
    
    // MARK: function for create a marker pin on map
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.isDraggable=true
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        marker.map = googleMaps
    }
    
  
    

    
    
    
    //MARK: - this is function for create direction path, from start location to desination location
    
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        
        
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
    
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
      //  self.polyline.map = nil
        self.googleMaps.clear()
        createMarker(titleMarker: "Current Location", iconMarker: #imageLiteral(resourceName: "ic_map_pin"), latitude: startLocation.coordinate.latitude, longitude: startLocation.coordinate.longitude)
        createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "ic_map_pin"), latitude: endLocation.coordinate.latitude, longitude: endLocation.coordinate.longitude)
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y"
        
        AF.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            do{
            let json = try JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            // print route using Polyline
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let legs = route["legs"].arrayValue
                
                for objLegs in legs {
                let dictDistance = objLegs["distance"].dictionary
                    print(dictDistance!["text"]?.stringValue)
                let dictDuration = objLegs["duration"].dictionary
                    print(dictDuration!["text"]?.stringValue)
                    
                let dictEndLocation = objLegs["end_location"].dictionary    //  abhishek
                        print(dictEndLocation!["lat"]?.stringValue)
                        print(dictEndLocation!["lng"]?.stringValue)
                    
                let dictStartLocation = objLegs["start_location"].dictionary
                        print(dictStartLocation!["lat"]?.stringValue)
                        print(dictStartLocation!["lng"]?.stringValue)
                    
                let end_address = objLegs["end_address"].stringValue
                let start_address = objLegs["start_address"].stringValue               // abhishek
                    
                }
                self.polyline = GMSPolyline.init(path: path)
                self.polyline.strokeWidth = 4
                self.polyline.strokeColor = UIColor.black
                self.polyline.map = self.googleMaps
            }
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    
//    func drawPathDriver(obj: Response)
//    {
//
//        let driverLat: Double = obj.driverInfo!.driverLocation!.coordinates![1] ?? 0.0
//        let driverLon: Double = obj.driverInfo!.driverLocation!.coordinates![0] ?? 0.0
//
//        let origin = "\(driverLat),\(driverLon)"
//
//     //   let origin = "\(driverLat),\(driverLon)"
//        let destination = "\(self.locationStart.coordinate.latitude),\(self.locationStart.coordinate.longitude)"
//
//        self.polyline.map = nil
//        //self.googleMaps.clear()
//     //   let url = "https://maps.googleapis.com/maps/api/directions/json?origin=28.891555664569626,78.47138989716768&destination=28.89512634277343,78.48155212402341&mode=driving&key=AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y"
//               //  https://maps.googleapis.com/maps/api/directions/json?origin=28.89512634277343,78.48155212402341&destination=28.8386481,78.7733286&mode=driving&key=AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y
//
//        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y"
    
//
//        AF.request(url).responseJSON { response in
//
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // HTTP URL response
//            print(response.data as Any)     // server data
//            print(response.result as Any)   // result of response serialization
//            do{
//            let json = try JSON(data: response.data!)
//            let routes = json["routes"].arrayValue
//
//            // print route using Polyline
//            for route in routes
//            {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let legs = route["legs"].arrayValue
//
//                for objLegs in legs {
//                let dictDistance = objLegs["distance"].dictionary
//                    print(dictDistance!["text"]?.stringValue)
//                let dictDuration = objLegs["duration"].dictionary
//                    print(dictDuration!["text"]?.stringValue)
//
//                let dictEndLocation = objLegs["end_location"].dictionary    //  abhishek
//                        print(dictEndLocation!["lat"]?.stringValue)
//                        print(dictEndLocation!["lng"]?.stringValue)
//
//                let dictStartLocation = objLegs["start_location"].dictionary
//                        print(dictStartLocation!["lat"]?.stringValue)
//                        print(dictStartLocation!["lng"]?.stringValue)
//
//                let end_address = objLegs["end_address"].stringValue
//                let start_address = objLegs["start_address"].stringValue               // abhishek obj: Response
//
//                }
//                self.polyline = GMSPolyline.init(path: path)
//                self.polyline.strokeWidth = 4
//                self.polyline.strokeColor = UIColor.black
//                self.polyline.map = self.googleMaps
//            }
//            }catch let error{
//                print(error.localizedDescription)
//            }
//        }
//
//    }
    func drawPathDriver(obj: Response) {
                let driverLat: Double = obj.driverInfo!.driverLocation!.coordinates![1] ?? 0.0
                let driverLon: Double = obj.driverInfo!.driverLocation!.coordinates![0] ?? 0.0
        
                let origin = "\(driverLat),\(driverLon)"
        
             //   let origin = "\(driverLat),\(driverLon)"
            let destination = "\(self.locationStart.coordinate.latitude),\(self.locationStart.coordinate.longitude)"
        
            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyDOAIDFY9jhsFrZXDynm7-C4D6T_lxe52Y"
        
            // MARK: Request for response from the google
            AF.request(url).responseJSON { (reseponse) in
                guard let data = reseponse.data else {
                    return
                }
               // self.polyline.map = nil
                do {
                    let jsonData = try JSON(data: data)
                    let routes = jsonData["routes"].arrayValue
                    for route in routes {
                        let overview_polyline = route["overview_polyline"].dictionary
                        let points = overview_polyline?["points"]?.string
                        let path = GMSPath.init(fromEncodedPath: points ?? "")
                        self.polyline = GMSPolyline.init(path: path)
                        self.polyline.strokeColor = .black
                        self.polyline.strokeWidth = 5
                        self.polyline.map = self.googleMaps
                    }
                
                  //  self.setUpdateMaker()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    
    
    
    
    // MARK: when start location tap, this will open the search location
    @IBAction func openStartLocation(_ sender: UIButton) {
        
      //  add0 = ""
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .startLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    // MARK: when destination location tap, this will open the search location
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        
     //   add0 = ""
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        // selected location
        locationSelected = .destinationLocation
        
        // Change text color
        UISearchBar.appearance().setTextColor(color: UIColor.black)
        self.locationManager.stopUpdatingLocation()
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: SHOW DIRECTION WITH BUTTON
    @IBAction func showDirection(_ sender: UIButton) {
        // when button direction tapped, must call drawpath func
      //  self.drawPath(startLocation: locationStart, endLocation: locationEnd)
        if validation() {
        self.drawPath(startLocation: locationStart, endLocation: locationEnd)
        pullUpController.dataSource = self
        pullUpController.setupCard(from: view)
            pullUpController.expanded()
            startLocation.isHidden = true
            destinationLocation.isHidden = true
            startBtn.isHidden = true
            destinationBtn.isHidden = true
            confirmBtn.isHidden = true
       // self.vV.isHidden = true
    }
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
                self.destinationLocation.text = strAddress
                self.gmsAddress1 = address
             //   self.locationAddress4 = placeName

            }else{
                self.add0 = strAddress
                self.startLocation.text = strAddress
                self.gmsAddress = address
                self.locationAddress1 = placeName

            }
        }
    }
    
    
    func setMapWith(thisCoordinate : CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude:thisCoordinate.latitude,longitude: thisCoordinate.longitude,zoom: 17.5,bearing: 30,viewingAngle: 40)
        googleMaps.camera = camera
    }
    
    func loadUI() {
        configureGoogleMap()
    }

   
    func pullUpViewCollapsedViewHeight() -> CGFloat {
            return bottomPadding + 10
       }
       
       func pullUpViewController() -> UIViewController {
       
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmRideVC") as! ConfirmRideVC
           vc.pickUpLat = pickLatitude
           print(vc.pickUpLat)
           vc.pickUpLong = pickLongitude
           vc.delegate = self
           print(vc.pickUpLong)
           vc.dropLat = dropLatitude
           print(vc.dropLat)
           vc.dropLong = dropLongitude
           print(vc.dropLong)
           vc.pullUpControl = self.pullUpController
          // self.navigationController?.pushViewController(vc, animated: true)
           return vc
         }

       func pullUpViewExpandedViewHeight() -> CGFloat {
           return self.view.frame.size.height - 80
       }
    
    

}


@available(iOS 13.0, *)
extension LocationDemoViewController : UpdateView {
    func updatePopUp(vehicleId: String?, totalCharge: String?, totalTime: Int?, pickupLat: Double?, pickupLong: Double, dropLat: Double, dropLong: Double) {
     
        let vc = storyboardMain().instantiateViewController(withIdentifier: "DriverDetailsVC") as! DriverDetailsVC

        vc.vehicleId = vehicleId!
        vc.totalCharge = totalCharge!
        vc.totalTime = totalTime!
        vc.pickUpLat = pickupLat
        vc.pickUpLong = pickupLong
        vc.dropLat = dropLat
        vc.dropLong = dropLong
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
    }
    
    
    
}

// MARK: - GMS Auto Complete Delegate, for autocomplete search location
@available(iOS 13.0, *)
extension LocationDemoViewController: UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error \(error)")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        setMapWith(thisCoordinate: place.coordinate)
        googleMaps.clear()
        let latitude = place.coordinate.latitude
         let longitude = place.coordinate.longitude
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 14.0)
        
 
        if locationSelected == .startLocation {
            self.isPickUp = false
            self.pickLatitude = latitude
            self.pickLongitude = longitude
            reverseGeocodeCoordinate(place.coordinate, placeName: place.name ?? "")
          //  startLocation.text = place.name
            
         //   startLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
          //  createMarker(titleMarker: "Location Start", iconMarker: #imageLiteral(resourceName: "ic_map_pin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        } else {
            self.isPickUp = true
            self.dropLatitude = latitude
            self.dropLongitude = longitude
            reverseGeocodeCoordinate(place.coordinate, placeName: place.name ?? "")
          //  destinationLocation.text = "\(place.coordinate.latitude), \(place.coordinate.longitude)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
         //   createMarker(titleMarker: "Location End", iconMarker: #imageLiteral(resourceName: "ic_map_pin"), latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
        
        self.googleMaps.camera = camera
        self.dismiss(animated: true, completion: nil)
        
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == startLocation{
//          //  isPickUp = true
//            let autocompleteController = GMSAutocompleteViewController()
//            autocompleteController.delegate = self
//            self.present(autocompleteController, animated: true, completion: nil)
//        }
//        if textField == destinationLocation {
//            isPickUp = true
//            let autocompleteController = GMSAutocompleteViewController()
//            autocompleteController.delegate = self
//            self.present(autocompleteController, animated: true, completion: nil)
//        }
//}
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

@available(iOS 13.0, *)
extension LocationDemoViewController : GMSMapViewDelegate {
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
    //MARK: - Marker Delegate
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        
        
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        self.googleMaps.reloadInputViews()
        
        //self.polyline.map = nil;
        print("marker dragged to location: \(marker.position.latitude),\(marker.position.longitude)")
        let locationMobi = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        self.drawPath(startLocation: locationMobi, endLocation: locationEnd)
        
    }
    
    
}




@available(iOS 13.0, *)
extension LocationDemoViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
        googleMaps.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
        googleMaps.settings.myLocationButton = true // show current location button
        self.pickLatitude = (newLocation!.coordinate.latitude) // get current location latitude
        self.pickLongitude = (newLocation!.coordinate.longitude) //get current location longitude
        locationStart = CLLocation(latitude: pickLatitude ?? 0.0, longitude: pickLongitude ?? 0.0)
        
       //                                                                                                                                                                                             let driverLine = locations.last
//        let driverLat: Double = objResponse?.driverInfo?.driverLocation?.coordinates![1] ?? 0.0
//        let driverLon: Double = objResponse?.driverInfo?.driverLocation?.coordinates![0] ?? 0.0
//
//        self.driveLocLat = (driverLat) // get current location latitude
//        self.driveLocLong = (driverLon) //get current location longitude
//        locationStart = CLLocation(latitude: driveLocLat ?? 0.0, longitude: driveLocLong ?? 0.0)
        
        

    }
}

public extension UISearchBar {
    
     func setTextColor(color: UIColor) {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return }
        tf.textColor = color
    }
    
    
}
@available(iOS 13.0, *)
extension LocationDemoViewController {
    func validation() -> Bool
    {
        if (startLocation.text?.isEmpty)!
        {
            self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requirePickUpLocation) {
            }
            return false
        }
        else if (destinationLocation.text?.isEmpty)!
        {
           self.showOkAlertWithHandler(Apphelper.Constants.MessageConstant.requireDropOffLocation) {
            }
            return false
            
        
            
        }
        return true
        
    }
}
//@available(iOS 13.0, *)
//extension LocationDemoViewController : MKMapViewDelegate {
//    func mapView(_mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//        let annotationIdentifier = "AnnotationIndetifier"
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
//
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            annotationView!.canShowCallout = true
//        }
//        else {
//            annotationView!.annotation = annotation
//        }
//        let pinImage = UIImage(named: "black_car")
//        annotationView!.image = pinImage
//        return annotation as! MKAnnotationView
//    }
//}
