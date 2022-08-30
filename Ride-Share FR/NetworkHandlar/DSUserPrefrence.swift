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
    
    static var dropLatitude : String  {
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
    
    static var online_status  : Bool  {                    //abhishek
        set {
            UserDefaults.standard.set(newValue, forKey: "online_status")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "online_status") as? Bool ?? false
        }
    }
    
    static var endTrip  : Bool  {                    //abhishek
        set {
            UserDefaults.standard.set(newValue, forKey: "endTrip")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "endTrip") as? Bool ?? false
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
            UserDefaults.standard.set(newValue, forKey: "profilePicture")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "profilePicture") as? String ?? ""
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
    static var vehicle_category  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "vehicle_category")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "vehicle_category") as? String ?? ""
        }
    }
    static var vehicle_subCategoy  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "vehicle_subCategoy")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "vehicle_subCategoy") as? String ?? ""
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
   
    
    static var mobile_number  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "mobile_number")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "mobile_number") as? String ?? ""  //driver_employee_id
        }
    }
    static var company_name  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "company_name")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "company_name") as? String ?? ""  //driver_employee_id
        }
    }
    static var model_of_vehicle  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "model_of_vehicle")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "model_of_vehicle") as? String ?? ""  //driver_employee_id
        }
    }
    static var vehicle_color  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "vehicle_color")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "vehicle_color") as? String ?? ""  //driver_employee_id
        }
    }
    static var plate_number  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "plate_number")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "mobile_number") as? String ?? ""  //driver_employee_id
        }
    }
    static var driver_employee_id  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "driver_employee_id")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "driver_employee_id") as? String ?? ""  //driver_employee_id
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
    static var latitude  : Double  {
        set {
            UserDefaults.standard.set(newValue, forKey: "latitude")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "latitude") as? Double ?? 0.00
        }
    }
    
    static var longitude  : Double  {
        set {
            UserDefaults.standard.set(newValue, forKey: "longitude")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "longitude") as? Double ?? 0.00
        }
    }
    
    
    static var Token  : String  {
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.value(forKey: "token") as? String ?? ""
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
            UserDefaults.standard.set(newValue, forKey: "userType")
            UserDefaults.standard.synchronize()
        }
        get {
            return
                UserDefaults.standard.value(forKey: "userType") as? String ?? ""
        }
    }
    static var serviceArea  : String {
        set {
            UserDefaults.standard.set(newValue, forKey: "serviceArea")
            UserDefaults.standard.synchronize()
        }
        get {
            return  UserDefaults.standard.value(forKey: "serviceArea") as? String ?? ""
               
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
