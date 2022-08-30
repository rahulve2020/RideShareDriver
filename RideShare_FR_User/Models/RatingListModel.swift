//
//  RatingListModel.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 12/07/22.
//

import Foundation


class RatingListModel : NSObject {
    
    var _id: String?
    var comment: String?
    var createdAt: String?
    var ratedUser_name: String?
    var ratedUser_profile_pic: String?
    var rating: Int?
    

    init(data : [String : Any]) {
        self._id = data["_id"]as? String  ??  ""
        self.comment = data["comment"]as? String  ??  ""
        self.createdAt = data["createdAt"]as? String  ??  ""
        self.ratedUser_name = data["ratedUser_name"]as? String  ??  ""
        self.ratedUser_profile_pic = data["ratedUser_profile_pic"]as? String  ??  ""
        self.rating = data["rating"]as? Int  ??  0
       
    }
    
    
}
