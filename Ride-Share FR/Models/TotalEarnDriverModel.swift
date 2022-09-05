//
//  TotalEarnDriverModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 31/08/22.
//

import Foundation

class TotalEarnDriverModel: NSObject {
   // var userId : String = ""
    var totalAmount : String = ""
    var tipAmount : String = ""
    
    
    init (data: [String:Any]){
      //  self.userId = data["userId"] as? String ?? ""
        self.totalAmount = data["totalAmount"] as? String ?? ""
        self.tipAmount = data["tipAmount"] as? String ?? ""
    }
}
