//
//  DismissAlert.swift
//  Workcocoon
//
//  Created by Sierra 3 on 05/07/17.
//  Copyright © 2017 CB Neophyte. All rights reserved.
//

import Foundation
import UIKit

enum SwiftAlertType: Int {
    case error
    case info
    case success
    case otp
}

enum DismissAlert : String{
    case success = "Success"
    case oops = "Oops"
    case login = "Login Successfull"
    case locationPermission = "Location Permissions"
    case ok = "Ok"
    case cancel = "Cancel"
    case error = "Error"
    case info = "Warning"
    case confirmation = "Confirmation"

    func showWithType(type : DismissAlert? = .info, message : String) {
        alertMessase(message: message) {}
    }
}
