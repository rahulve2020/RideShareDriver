//
//  BankDetails.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 12/09/22.
//

import Foundation

class BankDetails: NSObject {
    var id : String = ""
    var account_holder_name : String = ""
    var last4 : String = ""
    var routing_number : String = ""
   
    init (data: [String:Any]){
        self.id = data["id"] as? String ?? ""
        self.account_holder_name = data["account_holder_name"] as? String ?? ""
        self.last4 = data["last4"] as? String ?? ""
        self.routing_number = data["routing_number"] as? String ?? ""
      
    }
}
