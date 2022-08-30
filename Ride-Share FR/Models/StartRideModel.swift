//
//  StartRideModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 26/08/22.
//

import Foundation

class StartRideModel : NSObject {
    
    var _id: String?
    var drop_location : DropRideLocation?


    init(data : [String : Any]) {
        self._id = data["_id"] as? String  ??  ""
        
   
        drop_location = DropRideLocation.init(model: data["drop_location"] as! [String: Any])
        
//        let arrCategory = data["subcategoryInfo"]  as? [[String:Any]]
//        for category in arrCategory ?? [] {
//            self.subcategoryInfo.append(SubCategory.init(model: category))
//        }
//
       
    }
    
    
}
class DropRideLocation {
    var coordinates : [Double]?
    var type : String?
    
        init (model: [String:Any]){
        coordinates = model["coordinates"] as? [Double]
        type = model["type"] as? String ?? ""
}
}
