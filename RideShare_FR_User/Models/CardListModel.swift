//
//  CardListModel.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 18/07/22.
//

import Foundation

class CardListModel: NSObject {

    var _id: String?
    var userId: String?
    var customer_id: String?
    var card_source: String?
    var is_deleted: Bool?
    var createdAt: String?
    var __v: String?
    var cardDetails : CardDetails?
    
    
    init(dict: [String:Any]) {
        _id = dict["_id"] as? String
        userId = dict["userId"] as? String
        customer_id = dict["customer_id"] as? String
        card_source = dict["card_source"] as? String
        is_deleted = dict["is_deleted"] as? Bool
        createdAt = dict["createdAt"] as? String
        __v = dict["__v"] as? String
        cardDetails = CardDetails.init(model: dict["cardDetails"] as! [String: Any])
        
    }
}
  


class CardDetails: NSObject {
        var brand: String?
        var exp_month: Int?
        var exp_year: Int?
        var last4: String?
  
    
    init (model: [String:Any]){
        brand = model["brand"] as? String
        exp_month = model["exp_month"] as? Int
        exp_year = model["exp_year"] as? Int
        last4 = model["last4"] as? String

        
       
    }
}
