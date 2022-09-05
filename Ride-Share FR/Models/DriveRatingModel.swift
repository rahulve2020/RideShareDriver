//
//  DriveRatingModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 05/09/22.
//

import Foundation

class DriverRatingModel: NSObject {
    var _id : String = ""
    var rating : Int = 0
    var comment : String = ""
    var createdAt : String = ""
    var ratedUser_name : String = ""
    var ratedUser_profile_pic : String = ""
    
    init (data: [String:Any]){
        self._id = data["_id"] as? String ?? ""
        self.rating = data["rating"] as? Int ?? 0
        self.comment = data["comment"] as? String ?? ""
        self.comment = data["createdAt"] as? String ?? ""
        self.ratedUser_name = data["ratedUser_name"] as? String ?? ""
        self.ratedUser_profile_pic = data["ratedUser_profile_pic"] as? String ?? ""
    }
}
