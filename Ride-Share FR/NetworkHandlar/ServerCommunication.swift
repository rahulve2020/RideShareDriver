////
////  ServerCommunication.swift
////  CherryAds
////
////  Created by Sandeep on 4/16/18.
////  Copyright © 2018 Shashi Saini. All rights reserved.

import UIKit

import Alamofire

class ServerCommunication: NSObject {
    
    private static func requestHeader() ->  HTTPHeaders{
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        headers["APP-VERSION"] = (version == nil) ? "1.0" : version!
        headers["DEVICE-TOKEN"] = SSCacheUtils.getDeviceToken()
        headers["DEVICE-ID"] = SSCacheUtils.getDeviceID()
        headers["PLATFORM"] = "ios"
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["USER-TYPE"] = "app_user"
        if let objUserCredentials = SSCacheUtils.getCredentials(){
         headers["AUTHORIZATION"] = "Bearer \(objUserCredentials.access_token)"
        }
        return headers
    }
    
    private static func requestWith(urlString : String, method : HTTPMethod,parameter : Parameters?, success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
       
        addLoadIndicator()
        var urlComplete : String!
        if(urlString.contains("https://maps.googleapis.com")){
            urlComplete = urlString
        }
        else {
        urlComplete = KAPI.appBaseURL + urlString
        }
        let requestHeader = ServerCommunication.requestHeader()
        let urlRequest =  Alamofire.request(urlComplete!, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: requestHeader)
        
        urlRequest.responseJSON { (response:DataResponse<Any>) in
            removeLoadIndicator()
            switch (response.result){
            case .success(_):
                print("******************success******************")
                guard let json = response.result.value as? NSDictionary else
                {
                    print("Error: \(String(describing: response.result.error))")
                    removeLoadIndicator()
                    DispatchQueue.main.async {
                        failure()
                    }
                    return
                }
                DispatchQueue.main.async {
                    //For Google And APi response
                    if let statusCodeString = json["status"] as? NSString {
                        if  statusCodeString == "OK" {
                            print("Success Positive Response: \(json)")
                            success(json as NSDictionary)
                        }else{
                            print("Success Negative Response: \(statusCodeString)")
//                            alertMessase(message: statusCodeString as String, okAction: {
//                                failure()
//                            })
                             failure()
                        }
                    }
                    else if  let statusCodeInt = json["status"] as? Int {
                        if statusCodeInt == 1 {
                            print("Success Positive Response: \(json)")
                            success(json as NSDictionary)
                        }else{
                            print("Success Negative Response: \(json)")
                            let strMessage = json["message"] as! String
                            alertMessase(message: strMessage, okAction: {
                                failure()
                            })
                        }
                    }else{
                        print("Invalid Response")
                        failure()
                    }
                }
                removeLoadIndicator()
            case .failure(_):
                
                removeLoadIndicator()
                print("******************failure******************")
                print(response.result.error!.localizedDescription)
                alertMessase(message: response.result.error!.localizedDescription, okAction: {})
            }
        }
    }
    
    private static func requestWithArray(urlString : String, method : HTTPMethod, parameter : Array<Any>, success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        
        addLoadIndicator()
        var urlComplete : String!
        if(urlString.contains("https://maps.googleapis.com")){
            urlComplete = urlString
        }
        else {
            urlComplete = KAPI.appBaseURL + urlString
        }
        let requestHeader = ServerCommunication.requestHeader()
        let urlRequest =  Alamofire.request(urlComplete!, method: method, parameters: parameter.asParameters(), encoding:  ArrayEncoding(), headers: requestHeader)
        
        urlRequest.responseJSON { (response:DataResponse<Any>) in
            removeLoadIndicator()
            switch (response.result){
            case .success(_):
                print("******************success******************")
                guard let json = response.result.value as? NSDictionary else
                {
                    print("Error: \(String(describing: response.result.error))")
                    removeLoadIndicator()
                    DispatchQueue.main.async {
                        failure()
                    }
                    return
                }
                DispatchQueue.main.async {
                    //For Google And APi response
                    if let statusCodeString = json["status"] as? NSString {
                        if  statusCodeString == "OK" {
                            print("Success Positive Response: \(json)")
                            success(json as NSDictionary)
                        }else{
                            print("Success Negative Response: \(statusCodeString)")
                            alertMessase(message: statusCodeString as String, okAction: {
                                failure()
                            })
                        }
                    }
                    else if  let statusCodeInt = json["status"] as? Int {
                        if statusCodeInt == 1 {
                            print("Success Positive Response: \(json)")
                            success(json as NSDictionary)
                        }else{
                            print("Success Negative Response: \(json)")
                            let strMessage = json["message"] as! String
                            alertMessase(message: strMessage, okAction: {
                                failure()
                            })
                        }
                    }else{
                        print("Invalid Response")
                        failure()
                    }
                }
                removeLoadIndicator()
            case .failure(_):
                
                removeLoadIndicator()
                print("******************failure******************")
                print(response.result.error!.localizedDescription)
                alertMessase(message: response.result.error!.localizedDescription, okAction: {})
            }
        }
    }
    
    static func getRequest(url : String, parameter : Parameters?,success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        requestWith(urlString: url, method: .get, parameter: parameter, success: { (dictSuccess) in
            success(dictSuccess)
        }) {failure()}
    }
    
    static func postRequest(url : String, parameter : Parameters?,success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        requestWith(urlString: url, method: .post, parameter: parameter, success: { (dictSuccess) in
            success(dictSuccess)
        }) {failure()}
    }
    
    static func putRequest(url : String, parameter : Parameters?,success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        requestWith(urlString: url, method: .put, parameter: parameter, success: { (dictSuccess) in
            success(dictSuccess)
        }) {failure()}
    }
    
    static func deleteRequest(url : String, parameter : Parameters?,success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        requestWith(urlString: url, method: .delete, parameter: parameter, success: { (dictSuccess) in
            success(dictSuccess)
        }) {failure()}
    }
    
    static func postRequestWithArray(url : String, parameter : Array<Any>,success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        requestWithArray(urlString: url, method: .post, parameter: parameter, success: { (dictSuccess) in
            success(dictSuccess)
        }) {failure()}
    }
    
//    static func putMultipartRequest(url : String, objProfile : UserProfile, success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
//
//        addLoadIndicator()
//        var urlComplete : String!
//        urlComplete = KAPI.appBaseURL + url
//
//        let requestHeader = ServerCommunication.requestHeader()
//
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//
//
//
//                multipartFormData.append((objProfile.name.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "name")
//                 multipartFormData.append((objProfile.email.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "email")
//                 multipartFormData.append((objProfile.dob.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "date_of_birth")
//                 multipartFormData.append((objProfile.gender.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "gender")
//                 multipartFormData.append((objProfile.city.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "city")
//                 multipartFormData.append((objProfile.state.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "state")
//              //  multipartFormData.append(objProfile.data!, withName: "profile_img")
//                multipartFormData.append(objProfile.data!, withName: "profile_img", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
//
//        },
//            to: urlComplete, method: .put, headers : requestHeader,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
//                        removeLoadIndicator()
//                        switch (response.result){
//                        case .success(_):
//                            print("******************success******************")
//                            guard let json = response.result.value as? NSDictionary else
//                            {
//                                print("Error: \(String(describing: response.result.error))")
//                                removeLoadIndicator()
//                                DispatchQueue.main.async {
//                                    failure()
//                                }
//                                return
//                            }
//                            DispatchQueue.main.async {
//                                //For Google And APi response
//                                if let statusCodeString = json["status"] as? NSString {
//                                    if  statusCodeString == "OK" {
//                                        print("Success Positive Response: \(json)")
//                                        success(json as NSDictionary)
//                                    }else{
//                                        print("Success Negative Response: \(statusCodeString)")
//                                        alertMessase(message: statusCodeString as String, okAction: {
//                                            failure()
//                                        })
//                                    }
//                                }
//                                else if  let statusCodeInt = json["status"] as? Int {
//                                    if statusCodeInt == 1 {
//                                        print("Success Positive Response: \(json)")
//                                        success(json as NSDictionary)
//                                    }else{
//                                        print("Success Negative Response: \(json)")
//                                        let strMessage = json["message"] as! String
//                                        alertMessase(message: strMessage, okAction: {
//                                            failure()
//                                        })
//                                    }
//                                }else{
//                                    print("Invalid Response")
//                                    failure()
//                                }
//                            }
//                            removeLoadIndicator()
//                        case .failure(_):
//
//                            removeLoadIndicator()
//                            print("******************failure******************")
//                            print(response.result.error!.localizedDescription)
//                            alertMessase(message: response.result.error!.localizedDescription, okAction: {})
//                        }
//                    })
//
//                case .failure(let encodingError):
//                   failure()
//                }
//        }
//        )
//
//    }
    
    static func postMultipartRequest(url : String, barID : String,arrPhotos : [UIImage], success : @escaping (NSDictionary)->(), failure : @escaping ()->()){
        
        addLoadIndicator()
        var urlComplete : String!
        urlComplete = KAPI.appBaseURL + url
        
        let requestHeader = ServerCommunication.requestHeader()
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                
                
                multipartFormData.append((barID.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "beer_id")
                multipartFormData.append(("false".data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "check_out_status")
                
                
                for img in arrPhotos {
                    if let dataImage = img.jpegData(compressionQuality: 0.5){
                        multipartFormData.append(dataImage, withName: "images", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                    }
                    
                }
                
                
                
        },
            to: urlComplete, method: .post, headers : requestHeader,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
                        removeLoadIndicator()
                        switch (response.result){
                        case .success(_):
                            print("******************success******************")
                            guard let json = response.result.value as? NSDictionary else
                            {
                                print("Error: \(String(describing: response.result.error))")
                                removeLoadIndicator()
                                DispatchQueue.main.async {
                                    failure()
                                }
                                return
                            }
                            DispatchQueue.main.async {
                                //For Google And APi response
                                if let statusCodeString = json["status"] as? NSString {
                                    if  statusCodeString == "OK" {
                                        print("Success Positive Response: \(json)")
                                        success(json as NSDictionary)
                                    }else{
                                        print("Success Negative Response: \(statusCodeString)")
                                        alertMessase(message: statusCodeString as String, okAction: {
                                            failure()
                                        })
                                    }
                                }
                                else if  let statusCodeInt = json["status"] as? Int {
                                    if statusCodeInt == 1 {
                                        print("Success Positive Response: \(json)")
                                        success(json as NSDictionary)
                                    }else{
                                        print("Success Negative Response: \(json)")
                                        let strMessage = json["message"] as! String
                                        alertMessase(message: strMessage, okAction: {
                                            failure()
                                        })
                                    }
                                }else{
                                    print("Invalid Response")
                                    failure()
                                }
                            }
                            removeLoadIndicator()
                        case .failure(_):
                            
                            removeLoadIndicator()
                            print("******************failure******************")
                            print(response.result.error!.localizedDescription)
                            alertMessase(message: response.result.error!.localizedDescription, okAction: {})
                        }
                    })
                    
                case .failure(let encodingError):
                    failure()
                }
        }
        )
        
    }
    

}





private let arrayParametersKey = "arrayParametersKey"

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object.
    func asParameters() -> Parameters {
        return [arrayParametersKey: self]
    }
}


/// Convert the parameters into a json array, and it is added as the request body.
/// The array must be sent as parameters using its `asParameters` method.
public struct ArrayEncoding: ParameterEncoding {
    
    /// The options for writing the parameters as JSON data.
    public let options: JSONSerialization.WritingOptions
    
    
    /// Creates a new instance of the encoding using the given options
    ///
    /// - parameter options: The options used to encode the json. Default is `[]`
    ///
    /// - returns: The new instance
    public init(options: JSONSerialization.WritingOptions = []) {
        self.options = options
    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var urlRequest = try urlRequest.asURLRequest()
        
        guard let parameters = parameters,
            let array = parameters[arrayParametersKey] else {
                return urlRequest
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: array, options: options)
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            urlRequest.httpBody = data
            
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
        
        return urlRequest
    }
}
