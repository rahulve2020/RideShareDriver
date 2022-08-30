//
//  LoginModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 19/07/22.
//

import Foundation

class LoginModel: NSObject {
    var _id : String = ""
    //var vehicle_category : String = ""
    var vehicle_subCategoy : String = ""
  //
    
    init (model: [String:Any]){
        self._id = model["_id"] as? String ?? ""
       // self.vehicle_category = model["vehicle_category"] as? String ?? ""
      
        //self.vehicle_subCategoy = model["vehicle_subCategoy"] as? String ?? ""
    

        
       
    }
}
