//
//  DashboardViewController.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 27/06/22.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
import CoreLocation
import Alamofire
import SwiftyJSON
import MapKit


//protocol LocationControllerDelegate {
//    func locationData(addressString: GMSAddress?)
//}
@available(iOS 13.0, *)
class DashboardViewController: SidePanelBaseViewController, PopupDelegate {
    
    

    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var imgMarker: UIImageView!
    @IBOutlet weak var switchBtn: UISwitch!
    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var offlineView: UIView!
    @IBOutlet weak var trackBtn: UIButton!
    @IBOutlet weak var onlineLbl: UILabel!
    @IBOutlet weak var navBtn: UIButton!
    
    private var carAnimator: CarAnimator!
    private var stopped = false
    private var myLocationMarker: GMSMarker!
    
  //  var delegateLocation : LocationControllerDelegate?
    var coordinateLatitude: Double?
    var coordinateLongitude: Double?
    var thoroughfare: String?
    var locality: String?
    var subLocality: String?
    var administrativeArea: String?
    var postalCode: String?
    var country: String?
    var line: [String]?

    var pickLatitude : Double?
    var pickLongitude : Double?
    
    var locationStart = CLLocation()
    var currentLocation : CLLocation?
    var locationManager = CLLocationManager()
    var gmsAddress: GMSAddress?
    var polyline = GMSPolyline()
    var locationAddress1 = ""
    var add0 : String = ""
    
    var isCameFromPlaceOrder = false
    var onButton = false
    
    var objResponse : Response?
    var orderId: String?
    var startRideModel : StartRideModel?
    
    var latDrop : Double?
    var longDrop : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        offlineView.isHidden = false
        vV.shadow()
        print(objResponse?.dropLocation?.drop_latitude)
        configureGoogleMap()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
        
        if DSUserPrefrence.online_status == true{                        //abhishek
            self.onlineLbl.text = "Online"
            self.offlineView.isHidden = true
            switchBtn.setOn(true, animated: true)
        }else{
            self.onlineLbl.text = "Offline"
            self.offlineView.isHidden = false
            switchBtn.setOn(false, animated: false)
        }
        
        let name = Notification.Name("updateDriver")
        NotificationCenter.default.addObserver(self, selector: #selector(updateDrivers(_:)), name: name, object: nil)               //abhishek
        

        
        if onButton == true {
            self.trackBtn.isHidden = false
            self.navBtn.isHidden = false
        }else{
            self.trackBtn.isHidden = true
            self.navBtn.isHidden = true
        }
 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
      //  self.trackBtn.isHidden = false
        print("i am in view will apper")
    }
    
    override func viewDidLayoutSubviews() {
        if DSUserPrefrence.endTrip == true {
            DSUserPrefrence.endTrip = false
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EndTripDriverVC") as! EndTripDriverVC
            vc.orderId = orderId
            vc.dropLat = pickLatitude
            vc.dropLong = pickLongitude
            vc.objResponse = objResponse
        self.navigationController?.pushViewController(vc, animated: true)
        print("i am in layout sbview")
        } else {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
//
//        self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    @IBAction func navigationBtn(_ sender: Any) {
        let saddr = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"
         DSUserPrefrence.endTrip = true
        startOrder()
   //     self.openMapForPlace(strLatFrom: latDrop ?? 0.00, strlongFrom: longDrop ?? 0.00)
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.openURL(URL(string:"comgooglemaps://?saddr=\(saddr)&daddr=\(self.latDrop ?? 0.0),\(self.longDrop ?? 0.0)&directionsmode=driving&zoom=14&views=traffic")!)
        } else {
        print("Can't use comgooglemaps://");
        }
        
    }
    @IBAction func trackBtn(_ sender: Any) {
        startOrder()
        
        let origin = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"

        let destination = "\(self.latDrop ?? 0.0),\(self.longDrop ?? 0.0)"
       
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
           
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .black
                polyline.strokeWidth = 4.0
                polyline.map = self.vwMap
                
            }
                self.configureMapStyle()
                self.vwMap.drawPath(GMSMapView.pathString)
              //  self.addButtons()
                LocationTracker.shared.locateMeOnLocationChange { [weak self]  _  in
                self?.moveCarMarker()
                        }
            }catch let error{
                print(error.localizedDescription)
            }
        }
        
    }

        func startOrder(){
            var dicParam : Dictionary<String,Any> = Dictionary()

            dicParam["orderId"] = self.orderId
            AppServices.shared.startRideUpdate(param: dicParam, success: { [self] (data) in
                print("datadatadata:-",data)


            }, failure: {errorMsg in })
        }

    func rqstAcceptButtonAction(infoLocation: PickLocation, latDrop: Double, longDrop: Double)  {
     //   self.latDrop = latDrop
     //   self.longDrop = longDrop
        
        let origin = "\(locationStart.coordinate.latitude),\(locationStart.coordinate.longitude)"

        let lat = infoLocation.pickup_latitude ?? 0.0
        let long = infoLocation.pickup_longitude ?? 0.0
        let destination = "\(lat),\(long)"
     
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
           
                let polyline = GMSPolyline(path: path)
                polyline.strokeColor = .black
                polyline.strokeWidth = 4.0
                polyline.map = self.vwMap
                
            }
                self.configureMapStyle()
                self.vwMap.drawPath(GMSMapView.pathString)
                self.addButtons()
                LocationTracker.shared.locateMeOnLocationChange { [weak self]  _  in
                self?.moveCarMarker()
                        }
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func rqstDeclineButtonAction() {
        print("location")
    }
    func moveCarMarker() {
        if let myLocation = LocationTracker.shared.lastLocation,
            myLocationMarker == nil {
            myLocationMarker = GMSMarker(position: myLocation.coordinate)
            myLocationMarker.icon = UIImage(named: "car")
            myLocationMarker.map = self.vwMap
            carAnimator = CarAnimator(carMarker: myLocationMarker, mapView: vwMap)
            self.vwMap.updateMap(toLocation: myLocation, zoomLevel: 16)
        } else if let myLocation = LocationTracker.shared.lastLocation?.coordinate, let myLastLocation = LocationTracker.shared.previousLocation?.coordinate {
            if !stopped {
                carAnimator.animate(from: myLastLocation, to: myLocation)
            }
        }
    }

    // MARK: UI Configuration

    private func configureMapStyle() {
        vwMap.mapStyle = mapStyle(traitCollection.userInterfaceStyle)
    }
    
    private func addButtons() {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        vwMap.addSubview(playButton)
        playButton.addTarget(self, action: #selector(resumeMarker), for: .touchUpInside)
        
        let pauseButton = UIButton()
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        vwMap.addSubview(pauseButton)
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
            
            playButton.bottomAnchor.constraint(equalTo: vwMap.bottomAnchor, constant: -20),
            pauseButton.bottomAnchor.constraint(equalTo: vwMap.bottomAnchor, constant: -20),
            
            playButton.centerXAnchor.constraint(equalTo: vwMap.centerXAnchor, constant: -40),
            pauseButton.centerXAnchor.constraint(equalTo: vwMap.centerXAnchor, constant: 40),
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
    
    @objc func updateDrivers(_ notification:Notification) {                    //abhishek
        
        
        if let notification = notification.userInfo?["gcm.notification.aps"] as? String, let jsonData = notification.data(using: .utf8)
        {
            
            let objDriver = Response.objUserCredentials(fromDict: jsonData)
           // print(objDriver?.dropLocation?.drop_latitude)
            self.orderId = objDriver?.orderId
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC
        
            self.addChild(vc)
            vc.objResponse = objDriver
            vc.view.frame = self.view.frame
            vc.rqstDelegate = self
            self.view.addSubview(vc.view)
            vc.didMove(toParent: self)
        
     }
        
    }
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
  
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
    
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        self.polyline.map = nil
        //self.googleMaps.clear()
  
        
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
                self.polyline.map = self.vwMap
            }
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }

    func configureGoogleMap() {
        imgMarker.image = #imageLiteral(resourceName: "drop_off_ic")
        vwMap.settings.myLocationButton = true;
        vwMap.isMyLocationEnabled = true
        vwMap.delegate = self
        
        if CLLocationManager.locationServicesEnabled(){
                locationManager.delegate = self

                locationManager.startUpdatingLocation()
          }
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
         //   self.addressTF.text = strAddress           //abhishek
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
    //abhishek
    func driverStatus() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
      
        dicParam["longitude"] = self.coordinateLongitude
        dicParam["latitude"] = self.coordinateLatitude
        dicParam["serviceArea"] = (gmsAddress?.lines?.joined(separator: "/n"))
    
        AppServices.shared.updateOnlineStatus(param: dicParam, success: { (data) in

            debugPrint("changePassword:-\(data!)")
            guard let resultNew = data as? [String:Any] else{return}

             let email = resultNew["online_status"]  as? Bool ?? false
            
            DSUserPrefrence.online_status = email
            if DSUserPrefrence.online_status == true{
                self.onlineLbl.text = "Online"
                self.offlineView.isHidden = true
                self.switchBtn.setOn(true, animated: true)
            }else{
                self.onlineLbl.text = "Offline"
                self.offlineView.isHidden = false
                self.switchBtn.setOn(false, animated: false)
            }
            
            

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
   
    @IBAction func onlineOflineBtn(_ sender: Any) {
        driverStatus()
    }
    
}
@available(iOS 13.0, *)
extension DashboardViewController : GMSMapViewDelegate {
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
extension DashboardViewController : UITextFieldDelegate, GMSAutocompleteViewControllerDelegate {
    
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
       // if textField == addressTF{
          //  isPickUp = true
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            self.present(autocompleteController, animated: true, completion: nil)
      //  }
}


}

@available(iOS 13.0, *)    //abhishek
extension DashboardViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let newLocation = locations.last // find your device location
        vwMap.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 14.0) // show your device location on map
        vwMap.settings.myLocationButton = true // show current location button
        locationStart = CLLocation(latitude: (newLocation!.coordinate.latitude) , longitude: (newLocation!.coordinate.longitude))
//         var lat = (newLocation?.coordinate.latitude)! // get current location latitude
//         var long = (newLocation?.coordinate.longitude)! //get current location longitude
        self.pickLatitude = (newLocation!.coordinate.latitude) // get current location latitude
        self.pickLongitude = (newLocation!.coordinate.longitude) //get current location longitude
        locationStart = CLLocation(latitude: pickLatitude ?? 0.0, longitude: pickLongitude ?? 0.0)
        
        //abhishek
//        if let currentLocation = manager.location?.coordinate {
//            print(currentLocation)
//            
//            let coordinates = ["latitude" : currentLocation.latitude, "longitude" : currentLocation.longitude]
//            
//            self.dbRef?.child("ios_driver_points").setValue(coordinates)
//        }

    }
}



//MARK:- Apple map
@available(iOS 13.0, *)
extension DashboardViewController{
    
    func openMapForPlace(strLatFrom: Double, strlongFrom: Double) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(strLatFrom, strlongFrom)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Abhishek"
        mapItem.openInMaps(launchOptions: options)
        
    }
}
