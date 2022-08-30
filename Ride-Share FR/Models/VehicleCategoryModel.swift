//
//  VehicleCategoryModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 19/07/22.
//

import Foundation

class VehicleCategoryModel: NSObject {
    var __v : Int?
    var _id : String?
    var category_name : String?
    var is_delete : Bool?
    
    init (data: [String:Any]){
        self.__v = data["__v"] as? Int ?? 0
        self._id = data["_id"] as? String ?? ""
        self.is_delete = data["is_delete"] as?  Bool ?? false
        self.category_name = data["category_name"] as? String ?? ""
    

        
       
    }
}

class VehicleSubCategoryModel: NSObject {
    var __v : Int?
    var _id : String?
    var vehicle_subcategory_name : String?
    var is_delete : Bool?
    
    init (data: [String:Any]){
        self.__v = data["__v"] as? Int ?? 0
        self._id = data["_id"] as? String ?? ""
        self.is_delete = data["is_delete"] as?  Bool ?? false
        self.vehicle_subcategory_name = data["vehicle_subcategory_name"] as? String ?? ""
    

        
       
    }
}
