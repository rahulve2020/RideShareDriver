//
//  UserProfile.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 08/07/22.
//

import Foundation

class UserProfile: NSObject {
    var _id : Int = 0
    var name : String = ""
    var email : String = ""
    var profile_pic : String = ""
    var country_code: String = ""
    var mobile_number : Int = 0
    
    
    init (model: [String:Any]){
        self._id = model["_id"] as? Int ?? 0
        self.name = model["name"] as? String ?? ""
        self.email = model["email"] as? String ?? ""
        self.profile_pic = model["profile_pic"] as? String ?? ""
        self.country_code = model["country_code"] as? String ?? ""
      
        self.mobile_number = model["mobile_number"] as? Int ?? 0
    

        
       
    }
}
