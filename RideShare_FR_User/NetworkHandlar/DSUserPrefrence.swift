//
//  DSUserPrefrence.swift
//  Dental Security
//
//  Created by Vivek singh on 02/01/20.
//  Copyright © 2020 Vivek singh. All rights reserved.
//

import UIKit

struct DSUserPrefrence {
    
    static var device_token  : String  {
         set {
             UserDefaults.standard.set(newValue, forKey: "device_token")
             UserDefaults.standard.synchronize()
         }
         get {
             return UserDefaults.standard.value(forKey: "device_token") as? String ?? ""
         }
     }
    
    static var device_id  : String  {
         set {
             UserDefaults.standard.set(newValue, forKey: "device_id")
             UserDefaults.standard.synchronize()
         }
         get {
             return UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
         }
     }
//    static var pickUpLatitude  :   {
//         set {
//             UserDefaults.standard.set(newValue, forKey: "device_id")
//             UserDefaults.standard.synchronize()
//         }
//         get {
//             return UserDefaults.standard.value(forKey: "device_id") as? String ?? ""
//         }
//     }
    
    
    static var linkedIn_id  : String  {
         set {
             UserDefaults.standard.set(newValue, forKey: "linkedIn_id")
             UserDefaults.standard.synchronize()
         }
         get {
             return UserDefaults.standard.value(forKey: "linkedIn_id") as? String ?? ""
         }
     }
    static var FullName  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "first_name")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "first_name") as? String ?? ""
        }
    }
    
    
    static var profilePicture  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "profile_pic")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "profile_pic") as? String ?? ""
        }
    }
    
    static var user_ID  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "user_ID")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "user_ID") as? String ?? ""
        }
    }
    
   
    
    static var mobile_number  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "mobile_number")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "mobile_number") as? String ?? ""
        }
    }
    static var driving_licence_status  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "driving_licence_status")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "driving_licence_status") as? String ?? ""
        }
    }
    static var vehicle_insurance_status  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "vehicle_insurance_status")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "vehicle_insurance_status") as? String ?? ""
        }
    }
    static var credential_status  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "credential_status")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "credential_status") as? String ?? ""
        }
    }
    static var qualification_status  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "qualification_status")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "qualification_status") as? String ?? ""
        }
    }
    static var Token  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "Token")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "Token") as? String ?? ""
        }
    }
    
    
    static var email_address  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "email") as? String ?? ""
        }
    }
    static var country_code  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "country_code")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "country_code") as? String ?? ""
        }
    }
    

    
    static var access_token  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "access_token")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "access_token") as? String ?? ""
        }
    }
    
    static var chatToken  : String  {
          set {
              UserDefaults.standard.set(newValue, forKey: "chatToken")
              UserDefaults.standard.synchronize()
          }
          get {
              return UserDefaults.standard.value(forKey: "chatToken") as? String ?? ""
          }
      }
  
    static var userType  : String {
        set {
            UserDefaults.standard.set(newValue, forKey: "user_type")
            UserDefaults.standard.synchronize()
        }
        get {
            return
                UserDefaults.standard.value(forKey: "user_type") as? String ?? ""
            
        }
    }
    
    static var VATNumber  : String {
        set {
            UserDefaults.standard.set(newValue, forKey: "VATNumber")
            UserDefaults.standard.synchronize()
        }
        get {
            return  UserDefaults.standard.value(forKey: "VATNumber") as? String ?? ""
               
        }
    }
    
    static var project_availiablity  : Int  {
        set {
            UserDefaults.standard.set(newValue, forKey: "project_availiablity")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "project_availiablity") as? Int ?? 0
        }
    }
    
    static var view  : Int  {
        set {
            UserDefaults.standard.set(newValue, forKey: "view")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "view") as? Int ?? 0
        }
    }
    
    var isLoggedIn : Bool? {
        get {
            var isLogg: Bool?
            let defaults = UserDefaults.standard
            if (defaults.value(forKey: "isLoggedIn")) != nil{
                isLogg = defaults.value(forKey: "isLoggedIn") as? Bool
            }
            return isLogg
        }
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "isLoggedIn")
            defaults.synchronize()
        }
    }
    
    var isUser : Bool? {
        get {
            var isUser : Bool?
            let defaults = UserDefaults.standard
            if (defaults.value(forKey: "isUser")) != nil {
                isUser = defaults.value(forKey: "isUser") as? Bool
            }
            return isUser
        }
        set {
            let defaults = UserDefaults.standard
            defaults.setValue(newValue, forKey: "isUser")
            defaults.synchronize()
        }
    }
}
