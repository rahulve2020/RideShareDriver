//
//  DriverDetailNotification.swift
//  RideShare_FR_User
//
//  Created by Aditya Gupta on 05/08/22.
//

import Foundation


struct Response: Codable {
    let orderId: String?
    let otp: Int?
    let driverInfo : DriverInfo?


    static func objUserCredentials(fromDict : Data)-> Response?{
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let response = try decoder.decode(Response.self, from: fromDict)
            return response //Get the value of price here..
        } catch {
            print(error)
        }
            return nil
        }
}


struct DriverInfo: Codable {
//    let country_code: String
    let mobile_number: String
    let name: String
    let profile_pic: String
    let vehicle_subcategory_name: String
    let vehicle_subcategory_picture: String
    let plate_number: String
    let driverLocation : DriverLocation?           //abhishek


}
struct DriverLocation: Codable {        //abhishek
    let coordinates: [Double]?
}
