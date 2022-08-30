//
//  vehicleCategoryList.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 25/07/22.
//

import Foundation


class VehicleCategoryList : NSObject {
    
    var _id: String?
    var category_name: String?
    var subcategoryInfo = [SubCategory]()
  //  var subcategoryInfo : SubCategory?

    init(data : [String : Any]) {
        self._id = data["_id"] as? String  ??  ""
        self.category_name = data["category_name"] as? String  ??  ""
        let arrCategory = data["subcategoryInfo"]  as? [[String:Any]]
        for category in arrCategory ?? [] {
            self.subcategoryInfo.append(SubCategory.init(model: category))
        }
     //   self.subcategoryInfo.append(SubCategory.init(model: category))
        
        
      //  subcategoryInfo = SubCategory.init(model: data["subcategoryInfo"] as! [String: Any])
       
    }
    
    
}
class SubCategory: NSObject {
        var _id: String?
        var vehicle_subcategory_name: String?
        var vehicle_subcategory_picture: String?
        var Description: String?
        var vehicle_seat_availability: Int?
        var per_mile_charge: Int?
        var vehicle_category: String?
        var totalCharge: String?
        var totalTime: Int?
  
    
    init (model: [String:Any]){
        _id = model["_id"] as? String
        vehicle_subcategory_name = model["vehicle_subcategory_name"] as? String ?? ""
        vehicle_subcategory_picture = model["vehicle_subcategory_picture"] as? String ?? ""
        vehicle_seat_availability = model["vehicle_seat_availability"] as? Int ?? 0
        Description = model["description"] as? String ?? ""
        per_mile_charge = model["per_mile_charge"] as? Int ?? 0
        totalCharge = model["totalCharge"] as? String ?? ""
        totalTime = model["totalTime"] as? Int ?? 0
        vehicle_category = model["vehicle_category"] as? String ?? ""

        
       
    }
}
