//
//  ProfileModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 19/07/22.
//

import Foundation

class ProfileModel: NSObject {
    var company_name : String?
    var model_of_vehicle : String?
    var plate_number : String?
    var vehicle_color : String?
    var vehicleCategoryName : String?
    var vehicleSubCategoryName : String?
    
    var driving_licence : String?
    var vehicle_insurance : String?
    var credential : String?
    var qualification : String?
    
    var driving_licence_status : String?
    var vehicle_insurance_status : String?
    var credential_status : String?
    var qualification_status : String?
    
    init (data: [String:Any]){
        self.company_name = data["company_name"] as? String ?? ""
        self.model_of_vehicle = data["model_of_vehicle"] as? String ?? ""
        self.plate_number = data["plate_number"] as?  String ?? ""
        self.vehicle_color = data["vehicle_color"] as? String ?? ""
        self.vehicleCategoryName = data["vehicleCategoryName"] as?  String ?? ""
        self.vehicleSubCategoryName = data["vehicleSubCategoryName"] as? String ?? ""
    
        self.driving_licence_status = data["driving_licence_status"] as? String ?? ""
        self.vehicle_insurance_status = data["vehicle_insurance_status"] as?  String ?? ""
        self.credential_status = data["credential_status"] as? String ?? ""
        self.qualification_status = data["qualification_status"] as? String ?? ""
        
        self.driving_licence = data["driving_licence"] as? String ?? ""
        self.vehicle_insurance = data["vehicle_insurance"] as?  String ?? ""
        self.credential = data["credential"] as? String ?? ""
        self.qualification = data["qualification"] as? String ?? ""
        
       
    }
}
