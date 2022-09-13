//
//  NotificationModel.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/07/22.
//
import Foundation     //abhishek

struct Response: Codable {
    let notification_type : String?
    let orderId: String?
    let userInfo : UserInfo?
    let pickuplocation : PickLocation?
    let dropLocation : DropLocation?

   // let driverInfo : DriverInfo?


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

struct UserInfo: Codable {
    let country_code: String
    let name: String
    let profile_pic: String
    let mobile_number: String                //abhishek
  //  let userid: String
}
struct PickLocation: Codable {
    let pickup_longitude: Double?
    let pickup_latitude: Double?

}
struct DropLocation: Codable {
    let drop_latitude: Double?
    let drop_longitude: Double?

}

//struct DriverInfo: Codable {
//
//}
