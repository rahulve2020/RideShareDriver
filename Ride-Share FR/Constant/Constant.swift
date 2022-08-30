//
//  Constant.swift
//  ServiceHubConnect
//
//  Created by Imran on 31/01/2022.
//

import UIKit

let KScreenSize = UIScreen.main.bounds.size
@available(iOS 13.0, *)
let KAppDelegate = (UIApplication.shared.delegate as! AppDelegate)

//MARK: Constant String
struct KString {
    static let strAppHeader              = "Safe Ride !!"
    static let UnderDevelopment          = "Under Development"
    static let layerName                 = "GradientLayer"
    static let TryLater                  = "Try later"
    static let ok                        = "OK"
    static let cancel                    = "Cancel"
}

//MARK: Constant Color
struct KColor {
    static let hexStrAppTheme            = "E8206D"
    static let hexStrBorder              = "b7b7b7"
}

//MARK: Font
struct KFont {
    static let regular              = "Roboto-Regular"
    static let medium               = "Roboto-Medium"
    static let bold                 = "Roboto-Bold"
}


struct KSDKKeys {
    //"AIzaSyBALwdShhFbU0EwSx0Zu0UZPtukSK-T5WQ"
    static let googleAPI = "AIzaSyBALwdShhFbU0EwSx0Zu0UZPtukSK-T5WQ"
    //"AIzaSyAq8L4mpVsRU0XYfdm4njQJ_Ntpi-KOvyc"
        
}

struct KAlertMsg {
    static let otpMsg = "Enter all field"
}
struct  stripePublishableKey {
    static let publishKey = "pk_live_HCDXsOAEmsRJMJkM1ZMnTi6H"
        //"pk_test_T0oksOcX7GaY7ARtdUbdSUrP"

    
}

