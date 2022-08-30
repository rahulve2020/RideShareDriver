//
//  Common.swift
//  ServiceHubConnect
//
//  Created by Pervez Malik on 15/04/21.
//

import Foundation
import UIKit
import SystemConfiguration
import CoreLocation
import EventKit

final class Common {
    static var locManager = CLLocationManager()
        
    // MARK: - Singleton
    static let shared = Common()
    
    class public func currentLocation() -> CLLocation? {
        
              //let locManager = CLLocationManager()
              locManager.startUpdatingLocation()
              locManager.requestWhenInUseAuthorization()
              var currentLocation: CLLocation?
              
              if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                  CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                  currentLocation = locManager.location
              }else
              {
                  locManager.stopUpdatingLocation()
                  
              }
              
              return currentLocation
    }
}


