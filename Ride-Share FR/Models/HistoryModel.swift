//
//  HistoryModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 17/08/22.
//

import Foundation

class HistoryModel : NSObject {
    
    var _id: String?
    var UserName: String?
    var total_time: String?
    var total_Charge: String?
    var UserPic: String?
    var total_distance: String?
//    var subcategoryInfo = [SubCategory]()
    var pickUp_location : PickUpLocation?
    var drop_location : DropOffLocation?

    init(data : [String : Any]) {
        self._id = data["_id"] as? String  ??  ""
        self.UserName = data["UserName"] as? String  ??  ""
        self.total_time = data["total_time"] as? String  ??  ""
        self.total_Charge = data["total_Charge"] as? String  ??  ""
        self.UserPic = data["UserPic"] as? String  ??  ""
        self.total_distance = data["total_distance"] as? String  ??  ""
        pickUp_location = PickUpLocation.init(model: data["pickUp_location"] as! [String: Any])
        drop_location = DropOffLocation.init(model: data["drop_location"] as! [String: Any])
        
//        let arrCategory = data["subcategoryInfo"]  as? [[String:Any]]
//        for category in arrCategory ?? [] {
//            self.subcategoryInfo.append(SubCategory.init(model: category))
//        }
//
       
    }
    
    
}
class PickUpLocation: NSObject {
        var coordinates: [Double]?
        var type: String?
       
    
    init (model: [String:Any]){
        coordinates = model["coordinates"] as? [Double]
        type = model["type"] as? String ?? ""
 
    }
}

class DropOffLocation: NSObject {
        var coordinates: [Double]?
        var type: String?
       
    
    init (model: [String:Any]){
        coordinates = model["coordinates"] as? [Double]
        type = model["type"] as? String ?? ""
 
    }
}
