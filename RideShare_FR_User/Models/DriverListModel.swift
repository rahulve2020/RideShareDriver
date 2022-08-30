//
//  DriverListModel.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 15/07/22.
//

import Foundation


class DriverListModel : NSObject {
    
    var _id: String?
    var name: String?
    var email: String?
    var profile_pic: String?
   
    var dist: Int?
    

    init(data : [String : Any]) {
        self._id = data["_id"]as? String  ??  ""
        self.name = data["name"]as? String  ??  ""
        self.email = data["email"]as? String  ??  ""
        self.profile_pic = data["profile_pic"]as? String  ??  ""
       
        self.dist = data["rating"]as? Int  ??  0
       
    }
    
    
}
