//
//  TotalFareDetails.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/08/22.
//

import Foundation

class TotalFareDetails: NSObject {
    var total_Charge : String = ""
    var total_time : Int = 0
    var total_distance : String = ""
    
    
    init (data: [String:Any]){
        self.total_Charge = data["total_Charge"] as? String ?? ""
        self.total_time = data["total_time"] as? Int ?? 0
      
        self.total_distance = data["total_distance"] as? String ?? ""
    

        
       
    }
}
