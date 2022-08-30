//
//  ServicesClass.swift
//  Freeluancer
//
//  Created by Imran malik on 17/03/20.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
//import SwiftyJSON

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class ServicesClass_New : NSObject
{
   static let shared : ServicesClass_New = ServicesClass_New.init()
   //    var urlSession : URLSession?
   
   var urlSession : URLSession?
   var isSessionConfigured : Bool = false
   typealias CompletionBlock = (_ result : Dictionary<String, Any>?, _ error : Error?) -> Void
   typealias CompletionDataBlock = (_ result : Data?) -> Void
   typealias ProgressBlock = (_ progressData : Progress) -> Void
   
   //To support Background task.
   //let alamofire = Alamofire.SessionManager.init(configuration: URLSessionConfiguration.background(withIdentifier: "com.example.app.background"))
   
   static func getDataFromURlWith(url:String,parameters:Dictionary<String, Any>?,completionBlock : @escaping CompletionBlock) {
      
       print("API URL-----> ", url)
    
       
       let header: HTTPHeaders =  ["Authorization" : Facade.shared.authToken ?? "","Content-Type": "application/json"]
        print("HEADER:::::*******  \(Facade.shared.authToken ?? "")")
    
    
       AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
           print("response----->",response)
           switch(response.result) {
            
           case .success(_):
               if let data = response.value   {
                   var dic : Dictionary<String,Any> = Dictionary()
                   
                   if data as? Array<Dictionary<String,Any>> != nil   {
                       dic["data"] = data as? Array<Dictionary<String,Any>>
                       completionBlock(dic,nil)
                   }  else  {
                       completionBlock(data as? Dictionary<String,Any>,nil)
                   }
               }
               break
           case .failure(_):
            print(response.error)
               completionBlock(nil ,response.error!)
               break
           }
       }
       
   }
    
    
    
    
    
    




    
    
//    static func uploadDataInMutipart(url:String,parameters:Dictionary<String, Any>,imagedata: Data?,completionBlock : @escaping CompletionBlock) {
//
//        print("API URL-----> ", url)
//
//
//        let header: HTTPHeaders =  ["Authorization" : Facade.shared.authToken ?? "","Content-Type": "application/json"]
//        let url = Apphelper.Constants.API.updateProfile
//         print("HEADER:::::*******  \(Facade.shared.authToken ?? "")")
//       AF.upload(multipartFormData: { (multipartFormData) in
//        for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//
//            if let data = imagedata{
//                multipartFormData.append(data, withName: "imagename", fileName: "imagename.jpg", mimeType: "image/jpeg")
//            }
//
//       },to: url, method: .post , headers: header)
//                   .response { resp in
//                       print("sdsdsd",resp.data)
//                          print(resp.value)
//
//                          switch resp.result {
//                          case .success:
//                              if let dict = resp.value
//                              {
//                                  do {
//                                      let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//          //                            print(hobbysDict)
//                                      completionBlock(hobbysDict, nil)
//
//                                      //                        let data = dict as! Dictionary<String,Any>
//                                  } catch {
//                                      completionBlock(nil, resp.error)
//                                      //                          failure()
//                                  }
//                                  print(resp.value!)
//                                  //                        print(data)
//                                  //                       completionBlock(data,nil)
//                              }
//
//
//                          case .failure(let error): break
//                          print((error as NSError).localizedDescription)
//                          completionBlock(nil ,resp.error)
//                          print("\(error.localizedDescription)")
//                          }
//                  }
//    }
    
    
    static func getDataFromURlWithForUserDeatil(url:String,parameters:Dictionary<String, Any>?,completionBlock : @escaping CompletionBlock) {
       
        print("API URL-----> ", url)
        
        let header: HTTPHeaders =  ["Authorization" : Facade.shared.authToken ?? ""]
         print("HEADER:::::*******  \(Facade.shared.authToken ?? "")")
     
     
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            print("response----->",response)
            switch(response.result) {
             
            case .success(_):
                if let data = response.value   {
                    var dic : Dictionary<String,Any> = Dictionary()
                    
                    if data as? Array<Dictionary<String,Any>> != nil   {
                        dic["data"] = data as? Array<Dictionary<String,Any>>
                        completionBlock(dic,nil)
                    }  else  {
                        completionBlock(data as? Dictionary<String,Any>,nil)
                    }
                }
                break
            case .failure(_):
             print(response.error)
                completionBlock(nil ,response.error!)
                break
            }
        }
        
    }
    
    static func getDataFromURlWithForUserDeatil1(url:String,parameters:Dictionary<String, Any>?,completionBlock : @escaping CompletionBlock) {
       
        print("API URL-----> ", url)
        
        let header: HTTPHeaders =  ["Authorization" : Facade.shared.authToken ?? ""]
         print("HEADER:::::*******  \(Facade.shared.authToken ?? "")")
     
     
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            print("response----->",response)
            switch(response.result) {
             
            case .success(_):
                if let data = response.value   {
                    var dic : Dictionary<String,Any> = Dictionary()
                    
                    if data as? Array<Dictionary<String,Any>> != nil   {
                        dic["data"] = data as? Array<Dictionary<String,Any>>
                        completionBlock(dic,nil)
                    }  else  {
                        completionBlock(data as? Dictionary<String,Any>,nil)
                    }
                }
                break
            case .failure(_):
             print(response.error)
                completionBlock(nil ,response.error!)
                break
            }
        }
        
    }
   
    
    static func getDataFromURlWithForUserCall(url:String,parameters:Dictionary<String, Any>?,completionBlock : @escaping CompletionBlock) {
       
        print("API URL-----> ", url)
        
        let header: HTTPHeaders =  ["Authorization" : Facade.shared.authToken ?? ""]
         print("HEADER:::::*******  \(Facade.shared.authToken ?? "")")
     
     
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            print("response----->",response)
            switch(response.result) {
             
            case .success(_):
                if let data = response.value   {
                    var dic : Dictionary<String,Any> = Dictionary()
                    
                    if data as? Array<Dictionary<String,Any>> != nil   {
                        dic["data"] = data as? Array<Dictionary<String,Any>>
                        completionBlock(dic,nil)
                    }  else  {
                        completionBlock(data as? Dictionary<String,Any>,nil)
                    }
                }
                break
            case .failure(_):
             print(response.error)
                completionBlock(nil ,response.error!)
                break
            }
        }
        
    }
    
   static func postDataFromURL(url:String,parameters:Dictionary<String, Any>?, requestName:String,completionBlock : @escaping CompletionBlock)
   {
       print("API URL-----> ", url)
       print("API parameters-----> ", parameters)
       
        let hders: HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
       
       AF.session.configuration.timeoutIntervalForResource = 3600
       AF.session.configuration.timeoutIntervalForRequest = 3600
       
       var encodingParam : ParameterEncoding = JSONEncoding.default
       
       if url == Apphelper.Constants.API.signUp
       {
           encodingParam = URLEncoding.default
       }
       
       // Initial : Alamofire

    AF.request(url, method: .post, parameters: parameters, encoding: encodingParam, headers: hders).responseJSON() { response in
           print("response----->",response)

           switch(response.result) {
              
           case .success(_):
            
               if let dict = response.value
               {

                let data = dict as? Dictionary<String,Any>

                   //print(response.result.value!)
                    print(data)
                completionBlock((data ?? [:]) as Dictionary,nil)
               }

               break
               
           case .failure(let error):
               print((error as NSError).localizedDescription)
               completionBlock(nil ,response.error)
               print("\(error.localizedDescription)")
               
               break
               
           }
       }
   }
    
    
     static func postDataFromURL1(url:String,parameters:Int, requestName:String,completionBlock : @escaping CompletionBlock)
       {
           print("API URL-----> ", url)
           print("API parameters-----> ", parameters)
        
        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\n    \"post_id\":\(parameters)\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://freeluancer.com/api/hidePost")!,timeoutInterval: Double.infinity)
        request.addValue(Facade.shared.authToken ?? "", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            let string = String(data: data, encoding: .utf8)!
            
//            let jsonText = string
                   var dictonary:NSDictionary?
                   
//            if let data = jsonText.data(usingEncoding: String.Encoding.utf8) {
                       
                       do {
                        dictonary =  try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] as NSDictionary?
                       
                           if let myDictionary = dictonary
                           {
                                print(" First name is: \(myDictionary)")
                                print(myDictionary)
                            completionBlock(myDictionary as? Dictionary,nil)
                           }
                       } catch let error as NSError {
                           print(error)
                       }
//                   }
//            let dictionary = try? JSONSerialization.jsonObject(with: string, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]

          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
       }
    
    
//    static func postDataFromComment(url:String,parameters:Dictionary<String, Any>,requestName:String,completionBlock : @escaping CompletionBlock)
//    {
//
//        let url = Apphelper.Constants.API.add_comment
//        var nameFile : String = String()
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//        print("Image uplaod parameters-----> ", parameters)
//
//        AF.upload(multipartFormData:
//            {
//                (multipartFormData) in
//
//
//                for (key, value) in parameters
//                {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }else if let valueArray = value as? [String]{
//                        valueArray.forEach {multipartFormData.append(($0).data(using: .utf8)!, withName: key)}
//                    }
//                }
//        }, to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//
//                            completionBlock(hobbysDict, nil)
//
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
//
    static func uploadSingleImageWithAlamofire(imageData: [Data],completionBlock : @escaping CompletionBlock)  {

        let url = Apphelper.Constants.API.updateProfile
        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
                //
                AF.session.configuration.timeoutIntervalForResource = 3600
                AF.session.configuration.timeoutIntervalForRequest = 3600



                AF.upload(multipartFormData: { (multipartFormData) in

                    let randomInt = Int.random(in: 1..<5)

                    for imgData in imageData{


                        multipartFormData.append(imgData, withName: "images[]", fileName: "image.jpeg", mimeType: "image/jpeg")
                       print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
                     // multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")

                    }



//                    for imgData in imageData{
//                        print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//
//
//                        multipartFormData.append(imgData, withName: "images[]", fileName: "imageNumber\(randomInt)", mimeType: "image/jpeg")
//                    }

                },to: url, method: .post , headers: hders)
                    .response { resp in
                        print("sdsdsd",resp.data)
                        print(resp.value)

                        switch resp.result {
                        case .success:
                            if let dict = resp.value
                            {
                                do {
                                    let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
        //                            print(hobbysDict)
                                    completionBlock(hobbysDict, nil)

                                    //                        let data = dict as! Dictionary<String,Any>
                                } catch {
                                    completionBlock(nil, resp.error)
                                    //                          failure()
                                }
                                print(resp.value!)
                                //                        print(data)
                                //                       completionBlock(data,nil)
                            }


                        case .failure(let error): break
                        print((error as NSError).localizedDescription)
                        completionBlock(nil ,resp.error)
                        print("\(error.localizedDescription)")
                        }
                }


    }
//
//    static func uploadPortFolioOnSerer(imageData: Data?,completionBlock : @escaping CompletionBlock)  {
//
//        let boundary = UUID().uuidString
//
//        let session = URLSession.shared
//        let url = Apphelper.Constants.API.add_portfolio
//
//        // Set the URLRequest to POST and to the specified URL
//
//        var urlRequest = URLRequest(url: URL(string: url)!)
//        urlRequest.httpMethod = "POST"
//
//        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
//        // And the boundary is also set here
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue(Facade.shared.authToken ?? "", forHTTPHeaderField: "Authorization")
//
//
//
//        var data = Data()
//
//        // Add the image data to the raw http request data
//        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
//        data.append("Content-Disposition: form-data; name=\"\("portfolio")\"; filename=\"\("image.png")\"\r\n".data(using: .utf8)!)
//        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
//        data.append(imageData!)
//
//        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//
//        // Send a POST request to the URL, with the data we created earlier
//        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//            if error == nil {
//                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
//                if let json = jsonData as? [String: Any] {
//                    print("hhhhhhhh",json)
//                    completionBlock(json,nil)
//
//                }
//            }else {
//                print("errorerrorerrorerrorerror",error!)
//                completionBlock(nil,error)
//
//
//            }
//        }).resume()
//
//    }
//
//    static func uploadPortFolioOnServerWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//
//        let url = Apphelper.Constants.API.add_portfolio
//            let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//            //
//            AF.session.configuration.timeoutIntervalForResource = 3600
//            AF.session.configuration.timeoutIntervalForRequest = 3600
//
//
//
//            AF.upload(multipartFormData: { (multipartFormData) in
//                for (key, value) in parameters! {
//
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }
//
//                }
//                for imgData in imageArray{
//                    print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//
//
//                    multipartFormData.append(imgData, withName: "portfolio", fileName: "image.jpeg", mimeType: "image/jpeg")
//                }
//
//            },to: url, method: .post , headers: hders)
//                .response { resp in
//                    print("sdsdsd",resp.data)
//                    print(resp.value)
//
//                    switch resp.result {
//                    case .success:
//                        if let dict = resp.value
//                        {
//                            do {
//                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//    //                            print(hobbysDict)
//                                completionBlock(hobbysDict, nil)
//
//                                //                        let data = dict as! Dictionary<String,Any>
//                            } catch {
//                                completionBlock(nil, resp.error)
//                                //                          failure()
//                            }
//                            print(resp.value!)
//                            //                        print(data)
//                            //                       completionBlock(data,nil)
//                        }
//
//
//                    case .failure(let error): break
//                    print((error as NSError).localizedDescription)
//                    completionBlock(nil ,resp.error)
//                    print("\(error.localizedDescription)")
//                    }
//            }
//        }
  /*
    static func uploadData(url:String,parameters:Dictionary<String, Any>,requestName:String,arrImg:[UIImage],arrVideos:[URL],completionBlock : @escaping CompletionBlock)
    {
        
        let url = Apphelper.Constants.API.add_project
        var nameFile : String = String()
        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
        print("Image uplaod parameters-----> ", parameters)
        
        AF.upload(multipartFormData:
            {
                MultipartFormData in
                
                var index = 0
                
                for img in arrImg
                {
                    let imageData = img.jpegData(compressionQuality: 0.8)!
                    MultipartFormData.append(imageData, withName: nameFile , fileName:"file\(index).jpg", mimeType:"image/jpeg")
                }
                
                index = 0
                for video in arrVideos
                {
                    index = index + 1
                    var videoData : Data = Data()
                    do
                    {
                        videoData = try Data.init(contentsOf: URL.init(fileURLWithPath: video.path))
                        MultipartFormData.append(videoData, withName: "video", fileName:"file\(index).mp4",mimeType: "video/mp4")
                    }
                    catch
                    {
                        
                    }
                }
                for (key, value) in parameters
                {
                    if let valueString = value as? String{
                        MultipartFormData.append((valueString).data(using: .utf8)!, withName: key)
                    }else if let valueInt = value as? Int{
                        MultipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
                    }else if let valueArray = value as? [String]{
                        valueArray.forEach {MultipartFormData.append(($0).data(using: .utf8)!, withName: key)}
                    }
                }
            
        }, to:url,method:.post,headers: hders, encodingCompletion: {
            encodingResult in
            
            switch encodingResult
            {
            case .success(let upload, _, _):
                
                print("image uploaded")
                upload
            
                    .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                            print("JSON: \(value)")
                            let data = value as! Dictionary<String,Any>
                            completionBlock(data as Dictionary,nil)
                      
                    case .failure(let error):
                        print("Error: \(error)")
                        completionBlock(nil,error)
                       
                    }
 
                }
                break
                
            case .failure(let encodingError):
                completionBlock(nil ,encodingError)
                break
            }
        } )
        
    }
   */
   
//    static func uploadProject(url:String,parameters:Dictionary<String, Any>,requestName:String,arrImg:[UIImage],arrVideos:[URL],completionBlock : @escaping CompletionBlock)
//    {
//
//        let url = Apphelper.Constants.API.add_project
//        var nameFile : String = String()
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//        print("Image uplaod parameters-----> ", parameters)
//
//        AF.upload(multipartFormData:
//            {
//                (multipartFormData) in
//
//                var index = 0
//
//                for img in arrImg
//                {
//                    let imageData = img.jpegData(compressionQuality: 0.8)!
//                    multipartFormData.append(imageData, withName: nameFile , fileName:"file\(index).jpg", mimeType:"images/jpeg")
//                }
//
//                index = 0
//                for video in arrVideos
//                {
//                    index = index + 1
//                    var videoData : Data = Data()
//                    do
//                    {
//                        videoData = try Data.init(contentsOf: URL.init(fileURLWithPath: video.path))
//                        multipartFormData.append(videoData, withName: "video", fileName:"file\(index).mp4",mimeType: "video/mp4")
//                    }
//                    catch
//                    {
//
//                    }
//                }
//                for (key, value) in parameters
//                {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }else if let valueArray = value as? [String]{
//                        valueArray.forEach {multipartFormData.append(($0).data(using: .utf8)!, withName: key)}
//                    }
//                }
//        }, to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//
//                            completionBlock(hobbysDict, nil)
//
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
                
                
                
                
                
                
//                for img in arrImg
//                {
//                    let imageData = img.jpegData(compressionQuality: 0.8)!
//                    multipartFormData.append(imageData, withName: nameFile , fileName:"file\(index).jpg", mimeType:"image/jpeg")
//                }
//
//                index = 0
//                for video in arrVideos
//                {
//                    index = index + 1
//                    var videoData : Data = Data()
//                    do
//                    {
//                        videoData = try Data.init(contentsOf: URL.init(fileURLWithPath: video.path))
//                        multipartFormData.append(videoData, withName: "video", fileName:"file\(index).mp4",mimeType: "video/mp4")
//                    }
//                    catch
//                    {
//
//                    }
//                }
//                for (key, value) in parameters
//                {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }else if let valueArray = value as? [String]{
//                        valueArray.forEach {multipartFormData.append(($0).data(using: .utf8)!, withName: key)}
//                    }
//                }
//
//        }, to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//
//                            completionBlock(hobbysDict, nil)
//
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
    
//    static func jobToServerWithImageAndVideo(videoData: [Data]? = nil, videoKey: String? = nil,parameters : [String: Any],completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.add_project
//        let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//            AF.upload(multipartFormData: { multipartFormData in
//                for (key, value) in parameters {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }
//                }
//                if let key = videoKey, let videoArray = videoData {
//                    videoArray.forEach({
//                        multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                    })
//                }
//
//            }, to: url,method: .post, headers: header)
//                .response { resp in
//                    print("sdsdsd",resp.data)
//                    print(resp.value)
//
//                    switch resp.result {
//                    case .success:
//                        if let dict = resp.value
//                        {
//                            do {
//                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//    //                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                                completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                            } catch {
//                                completionBlock(nil, resp.error)
//                            }
//    //                        print(resp.value!)
//
//                        }
//                    case .failure(let error): break
//                    print((error as NSError).localizedDescription)
//                    completionBlock(nil ,resp.error)
//                    print("\(error.localizedDescription)")
//                }
//            }
//        }
//
//
//
//
//    static func uploadNewJobs(parameters : Dictionary<String, Any>?, imageArray: [Data], videoData: [Data]?,videoKey: String?, completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.add_project
//
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//            if imageArray != nil {
//                for img in imageArray
//                {
//                    print("File size before compression: \(Double((img.count) / 1048576)) mb")
//
//
//                    multipartFormData.append(img, withName: "images", fileName: "image.jpeg", mimeType: "image/jpeg")
//                }
//            }
//            else if videoData != nil {
//                if let key = videoKey, let videoArray = videoData {
//                    videoArray.forEach({
//                        multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                    })
//                }
//            }
//
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//
//                            completionBlock(hobbysDict, nil)
//
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
//
//
//
//    static func uploadjobImageWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.add_project
//        //      }
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        //
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//            for imgData in imageArray{
//                print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//
//                multipartFormData.append(imgData, withName: "profile_photo", fileName: "image.jpeg", mimeType: "image/jpeg")
//            }
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                            //                            print(hobbysDict)
//                            completionBlock(hobbysDict, nil)
//
//                            //                        let data = dict as! Dictionary<String,Any>
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
    
//     static func uploadNewProjectAlamofire(parameters : Dictionary<String, Any>?, videoData: [Data]? = nil, videoKey: String? = nil,imageArray: [Data]? = nil,completionBlock : @escaping CompletionBlock)  {
//
//           let url = Apphelper.Constants.API.add_project
//
//           let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//           AF.session.configuration.timeoutIntervalForResource = 3600
//           AF.session.configuration.timeoutIntervalForRequest = 3600
//
//           AF.upload(multipartFormData: { (multipartFormData) in
//               for (key, value) in parameters! {
//
//                   if let valueString = value as? String{
//                       multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                   }else if let valueInt = value as? Int{
//                       multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                   }
//
//               }
//            let randomInt = Int.random(in: 1..<100)
//            if let key = videoKey, let imgArray = imageArray {
//                imgArray.forEach({
//                    multipartFormData.append($0, withName: key, fileName: "image\(randomInt).pdf", mimeType: "image/pdf")
//                    print("File size before compression: \(Double((imageArray!.count) / 1048576)) mb")
//                })
//            }
//
//
////               for imgData in imageArray{
////
////
////                   multipartFormData.append(imgData, withName: "images[]", fileName: "image.jpeg", mimeType: "image/jpeg")
////                  print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
////                // multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
////
////               }
//
//                if let key = videoKey, let videoArray = videoData {
//                                videoArray.forEach({
//                                    multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                                 print("File size before compression: \(Double((videoData!.count) / 1048576)) mb")
//                                })
//                            }
//
//           },to: url, method: .post , headers: hders)
//               .response { resp in
//                   print("sdsdsd",resp.data)
//                   print(resp.value)
//
//                   switch resp.result {
//                   case .success:
//                       if let dict = resp.value
//                       {
//                           do {
//                               //                                    guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
//
//
//                               let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                               //                                    let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                               //                            print(hobbysDict)
//                               completionBlock(hobbysDict, nil)
//
//                               //                        let data = dict as! Dictionary<String,Any>
//                           } catch {
//                               completionBlock(nil, resp.error)
//                               //                          failure()
//                           }
//                           print(resp.value!)
//                           //                        print(data)
//                           //                       completionBlock(data,nil)
//                       }
//
//
//                   case .failure(let error): break
//                   print((error as NSError).localizedDescription)
//                   completionBlock(nil ,resp.error)
//                   print("\(error.localizedDescription)")
//                   }
//           }
//       }
//
    
    
//    static func uploadImageWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//
//        let url = Apphelper.Constants.API.add_project
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        //
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//            for imgData in imageArray{
//                print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//                let imgSize = Double((imgData.count) / 1048576)
//                if imgSize > 2.0{
//
//                }
//                multipartFormData.append(imgData, withName: "images[]", fileName: "image.png", mimeType: "image/png")
//            }
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                                                        print(hobbysDict)
//                            completionBlock(hobbysDict, nil)
//
//                            //                        let data = dict as! Dictionary<String,Any>
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//                        //                        print(data)
//                        //                       completionBlock(data,nil)
//                    }
//
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
                  
                  
                  
                  

//        },to: url, method: .post , headers: hders)
//            .response { resp in
//
//                print("sdsdsd",resp.data)
//                //print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//
//                        let data = dict as? Dictionary<String,Any>
//
//                        print(resp.value)
//                        print(data)
//                       completionBlock(data,nil)
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
 
    
    
    
//
    static func uploadProfileImageWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {

   // static func uploadProfileImageWithAlamofire(parameters : Dictionary<String, Any>?,postBool: Bool(), imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//          if postBool {
                   //let url = Apphelper.Constants.API.update_profile_photo
        //      }else{
                   let url = Apphelper.Constants.API.updateProfile
        //      }
            let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
            //
            AF.session.configuration.timeoutIntervalForResource = 3600
            AF.session.configuration.timeoutIntervalForRequest = 3600

            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters! {

                    if let valueString = value as? String{
                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
                    }else if let valueInt = value as? Int{
                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
                    }

                }
                for imgData in imageArray{
                    print("File size before compression: \(Double((imgData.count) / 1048576)) mb")


                 //   multipartFormData.append(imgData, withName: "profile_pic", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")  //jpeg
                      multipartFormData.append(imgData, withName: "profile_pic", fileName: "imageData.jpeg", mimeType:  "image/jpeg")
                }

            },to: url, method: .post , headers: hders)
                .response { resp in
                    print("sdsdsd",resp.data)
                    print(resp.value)

                    switch resp.result {
                    case .success:
                        if let dict = resp.value
                        {
                            do {
                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
    //                            print(hobbysDict)
                                completionBlock(hobbysDict, nil)

                                //                        let data = dict as! Dictionary<String,Any>
                            } catch {
                                completionBlock(nil, resp.error)
                                //                          failure()
                            }
                            print(resp.value!)
                            //                        print(data)
                            //                       completionBlock(data,nil)
                        }


                    case .failure(let error): break
                    print((error as NSError).localizedDescription)
                    completionBlock(nil ,resp.error)
                    print("\(error.localizedDescription)")
                    }
            }
        }
    
    
   
    
    // if let dataImg = objUser?.image.jpegData(compressionQuality: 0.2) {

  //                 multipartformdata.append(dataImg, withName: "profile_picture", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")

  //             }
    
    
    
   /*
    static func uploadProfileImageWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
  //  static func uploadProfileImageWithAlamofire(parameters : Dictionary<String, Any>?,postBool: Bool(), imageArray: [Data],completionBlock : @escaping CompletionBlock)  {

 //       if postBool {
             //let url = Apphelper.Constants.API.update_profile_photo
  //      }else{
             let url = Apphelper.Constants.API.update_profile_photo
  //      }
           
            let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
            //
            AF.session.configuration.timeoutIntervalForResource = 3600
            AF.session.configuration.timeoutIntervalForRequest = 3600



            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters! {

                    if let valueString = value as? String{
                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
                    }else if let valueInt = value as? Int{
                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
                    }

                }
                for imgData in imageArray{
                    print("File size before compression: \(Double((imgData.count) / 1048576)) mb")


                    multipartFormData.append(imgData, withName: "profile_photo", fileName: "image.jpeg", mimeType: "image/jpeg")
                }

            },to: url, method: .post , headers: hders)
                .response { resp in
                    print("sdsdsd",resp.data)
                    print(resp.value)

                    switch resp.result {
                    case .success:
                        if let dict = resp.value
                        {
                            do {
                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
    //                            print(hobbysDict)
                                completionBlock(hobbysDict, nil)

                                //                        let data = dict as! Dictionary<String,Any>
                            } catch {
                                completionBlock(nil, resp.error)
                                //                          failure()
                            }
                            print(resp.value!)
                            //                        print(data)
                            //                       completionBlock(data,nil)
                        }


                    case .failure(let error): break
                    print((error as NSError).localizedDescription)
                    completionBlock(nil ,resp.error)
                    print("\(error.localizedDescription)")
                    }
            }
        }
    */
//    static func uploadData(url:String,parameters:Dictionary<String, Any>,requestName:String,arrImg:[UIImage],arrVideos:[URL],completionBlock : @escaping CompletionBlock)
//    {
//        
//        let url = Apphelper.Constants.API.providers_posts
//        var nameFile : String = String()
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        
//        print("Image uplaod parameters-----> ", parameters)
//        
//        AF.upload(multipartFormData:
//            {
//                (multipartFormData) in
//                
//                var index = 0
//                
//                for img in arrImg
//                {
//                    let imageData = img.jpegData(compressionQuality: 0.8)!
//                    multipartFormData.append(imageData, withName: nameFile , fileName:"file\(index).jpg", mimeType:"image/jpeg")
//                }
//                
//                index = 0
//                for video in arrVideos
//                {
//                    index = index + 1
//                    var videoData : Data = Data()
//                    do
//                    {
//                        videoData = try Data.init(contentsOf: URL.init(fileURLWithPath: video.path))
//                        multipartFormData.append(videoData, withName: "video", fileName:"file\(index).mp4",mimeType: "video/mp4")
//                    }
//                    catch
//                    {
//                        
//                    }
//                }
//                for (key, value) in parameters
//                {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }else if let valueArray = value as? [String]{
//                        valueArray.forEach {multipartFormData.append(($0).data(using: .utf8)!, withName: key)}
//                    }
//                }
//                
//        }, to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//                
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            
//                            
//                            
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                            
//                            completionBlock(hobbysDict, nil)
//                            
//                            
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//                        
//                    }
//                    
//                    
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
    
    
   
    
//    static func uploadImageCreatPostWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.providers_posts
//
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//            //                    if imageArray != nil {
//            //                        for imgData in imageArray{
//            //                            print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//            //
//            //
//            //                            multipartFormData.append(imgData, withName: "images", fileName: "image.jpeg", mimeType: "image/jpeg")
//            //                        }
//            //                    }
//            //                    else {
//            //                        var des = [Data]()
//            //                        for imd in  des{
//            //                            multipartFormData.append(imd, withName: "")
//            //                        }
//            //                    }
//            for imgData in imageArray{
//                print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//
//
//                multipartFormData.append(imgData, withName: "images", fileName: "image.jpeg", mimeType: "image/jpeg")
//            }
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            //                                    guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                            //                                    let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                            //                            print(hobbysDict)
//                            completionBlock(hobbysDict, nil)
//
//                            //                        let data = dict as! Dictionary<String,Any>
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//                        //                        print(data)
//                        //                       completionBlock(data,nil)
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
//
    
    
//    static func uploadfileWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.apply_bid
//
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//            for imgData in imageArray{
//                print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
//                multipartFormData.append(imgData, withName: "images", fileName: "image.jpeg", mimeType: "image/jpeg")
//            }
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            //                                    guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                            //                                    let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                            //                            print(hobbysDict)
//                            completionBlock(hobbysDict, nil)
//
//                            //                        let data = dict as! Dictionary<String,Any>
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//                        //                        print(data)
//                        //                       completionBlock(data,nil)
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
        
    
//    static func submitProjectFileWithAlamofire(parameters : Dictionary<String, Any>?, videoKey: String? = nil, imageArray:[URL], completionBlock : @escaping CompletionBlock)  {
//
//    //static func submitProjectFileWithAlamofire(parameters : Dictionary<String, Any>?, imageArray: [Data],completionBlock : @escaping CompletionBlock)  {
//
//        let url = Apphelper.Constants.API.apply_bid
//
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in parameters! {
//
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//
//            }
//
//
//
//
//
//            for docData in imageArray{
////                    let data = docData ?? Data()
//
//                multipartFormData.append(docData, withName: "submition", fileName: "image.pdf", mimeType: "image/pdf")
//            }
//
////            let randomInt = Int.random(in: 1..<100)
////            if let key = videoKey, let imgArray = imageArray {
////                imgArray.forEach({
////                    multipartFormData.append($0, withName: key, fileName: "image\(randomInt).pdf", mimeType: "image/pdf")
////                    print("File size before compression: \(Double((imageArray!.count) / 1048576)) mb")
////                })
////            }
//
////            for imgData in imageArray{
////                print("File size before compression: \(Double((imgData.count) / 1048576)) mb")
////                multipartFormData.append(imgData, withName: "submition[]", fileName: "image.pdf", mimeType: "image/pdf")
////            }
//
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            //                                    guard let httpbody = try? JSONSerialization.data(withJSONObject: parameters, options:[]) else {return}
//
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                            //                                    let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String,Any>
//                            //                            print(hobbysDict)
//                            completionBlock(hobbysDict, nil)
//
//                            //                        let data = dict as! Dictionary<String,Any>
//                        } catch {
//                            completionBlock(nil, resp.error)
//                            //                          failure()
//                        }
//                        print(resp.value!)
//                        //                        print(data)
//                        //                       completionBlock(data,nil)
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
   static func downloadFile(strUrl : String, progressBlock : @escaping ProgressBlock, completionBlock : @escaping CompletionDataBlock)
   {
       let utilityQueue = DispatchQueue.global(qos: .utility)
       
       AF.request(URL.init(string: strUrl)!).downloadProgress(queue: utilityQueue, closure: { (progress) in
           
           progressBlock(progress)
       })
           .responseData { (response) in
               
               if let data = response.value
               {
                   completionBlock(data)
               }
               else
               {
                   completionBlock(nil)
               }
       }
       
   }
   
  
   
   func postDataFromURLNew(url:String,parameters:Dictionary<String, Any>?, identifier : String , requestName:String,completionBlock : @escaping CompletionBlock)
   {
       
       if !self.isSessionConfigured
       {
           let configuration = URLSessionConfiguration.background(withIdentifier: Apphelper.Constants.StringConstant.appName)
            
           configuration.isDiscretionary = true
           configuration.allowsCellularAccess = true
           configuration.timeoutIntervalForRequest = 3600
           configuration.timeoutIntervalForResource = 3600
           
           urlSession = URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
           
           self.isSessionConfigured = true
       }
      // print("API URL-----> ", url)
       //print("API parameters-----> ", parameters)
       var request = URLRequest.init(url: URL.init(string: url)!)
       
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       request.httpMethod = "Post"
       request.allowsCellularAccess = true
       
       do{
           request.httpBody = try JSONSerialization.data(withJSONObject: parameters ?? ["" : ""], options: .prettyPrinted)
       }
       catch{
           print("Cannot serialize")
       }
       
       urlSession!.uploadTask(withStreamedRequest: request).resume()
       //        let dataTask = urlSession?.dataTask(with: request)
       //
       //        dataTask?.resume()
   }
    
    static func postDataFromURLForaStripe(url:String,parameters:Dictionary<String, Any>?, requestName:String,completionBlock : @escaping CompletionBlock)
    {
        print("API URL-----> ", url)
        print("API parameters-----> ", parameters)
        
        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
         
        
        AF.session.configuration.timeoutIntervalForResource = 3600
        AF.session.configuration.timeoutIntervalForRequest = 3600
        
        var encodingParam : ParameterEncoding = JSONEncoding.default
        
        if url == Apphelper.Constants.API.signUp
        {
            encodingParam = URLEncoding.default
        }
        
        // Initial : Alamofire
      AF.request(url, method: .post, parameters: parameters, encoding: encodingParam, headers: hders).responseJSON { (response) in
      
      //responseString(completionHandler: { (response) in

            print("response----->",response)

            switch(response.result) {
               
            case .success(_):
                
              if let dict = response.value
                {
                    let data = dict as! Dictionary<String,Any>
                    
                    //print(response.result.value!)
                     print(data)
                    completionBlock(data as Dictionary,nil)
                }
                
                break
                
            case .failure(let error):
                print((error as NSError).localizedDescription)
                completionBlock(nil ,response.error)
                print("\(error.localizedDescription)")
                
                break
                
            }
        }
    }
    
    // ***** Video ****
//
//    func uploadVideo(videoUrl: URL) { // local video file path..
//        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
//
//        let url = Apphelper.Constants.API.providers_posts
//        let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//        AF.upload(multipartFormData: { (multipartFormData) in
//            multipartFormData.append(videoUrl, withName: "images", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
//        }, to: url, headers: header ).responseJSON { (response) in
//            debugPrint(response)
//        }
//    }

//    func uploadImageOne(){
//        var imageData = UIImagePNGRepresentation(imageView.image)
//
//        if imageData != nil{
//            var request = NSMutableURLRequest(URL: NSURL(string:"Enter Your URL")!)
//            var session = NSURLSession.sharedSession()
//
//            request.HTTPMethod = "POST"
//
//            var boundary = NSString(format: "---------------------------14737809831466499882746641449")
//            var contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
//          //  println("Content Type \(contentType)")
//            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//
//            var body = NSMutableData.alloc()
//
//            // Title
//             body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"title\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData("Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
//
//            // Image
//            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"profile_img\"; filename=\"img.jpg\"\\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
//            body.appendData(imageData)
//            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
//
//
//
//            request.HTTPBody = body
//
//
//            var returnData = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
//
//            var returnString = NSString(data: returnData!, encoding: NSUTF8StringEncoding)
//
//            println("returnString \(returnString)")
//
//        }
//
//
//    }
    
    
     /*
       static func uploadProfileImageWithAlamofire(imageData: Data?,completionBlock : @escaping CompletionBlock)  {
           
           let boundary = UUID().uuidString

           let session = URLSession.shared
           let url = Apphelper.Constants.API.update_profile_photo

           // Set the URLRequest to POST and to the specified URL

           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = "POST"

           // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
           // And the boundary is also set here
           urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
           urlRequest.setValue(Facade.shared.authToken ?? "", forHTTPHeaderField: "Authorization")



           var data = Data()

           // Add the image data to the raw http request data
           data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
           data.append("Content-Disposition: form-data; name=\"\("profile_photo")\"; filename=\"\("image.jpg")\"\r\n".data(using: .utf8)!)
           data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
           data.append(imageData!)

           data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

           // Send a POST request to the URL, with the data we created earlier
           session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
               if error == nil {
                   let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                   if let json = jsonData as? [String: Any] {
                       print("hhhhhhhh",json)
                       completionBlock(json,nil)

                   }
               }else {
                   print("errorerrorerrorerrorerror",error!)
                   completionBlock(nil,error)

                   
               }
           }).resume()

       }
      */
       /*
       static func uploadProfileImageWithAlamofire(imageData: Data?,completionBlock : @escaping CompletionBlock)  {
           
           let boundary = UUID().uuidString

           let session = URLSession.shared
           let url = Apphelper.Constants.API.update_profile_photo

           // Set the URLRequest to POST and to the specified URL

           var urlRequest = URLRequest(url: URL(string: url)!)
           urlRequest.httpMethod = "POST"

           // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
           // And the boundary is also set here
           urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
           urlRequest.setValue(Facade.shared.authToken ?? "", forHTTPHeaderField: "Authorization")



           var data = Data()

           // Add the image data to the raw http request data
           data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
           data.append("Content-Disposition: form-data; name=\"\("images")\"; filename=\"\("image.png")\"\r\n".data(using: .utf8)!)
           data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
           data.append(imageData!)

           data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

           // Send a POST request to the URL, with the data we created earlier
           session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
               if error == nil {
                   let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                   if let json = jsonData as? [String: Any] {
                       print("hhhhhhhh",json)
                       completionBlock(json,nil)

                   }
               }else {
                   print("errorerrorerrorerrorerror",error!)
                   completionBlock(nil,error)

                   
               }
           }).resume()

       }
    */
      
//       static func uploadVideoWithAlamofire(parameters : Dictionary<String, Any>?, videoData: [Data]?,videoKey: String?,completionBlock : @escaping CompletionBlock)  {
//
//
//           let url = Apphelper.Constants.API.add_reviews
//           let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//           //
//           AF.session.configuration.timeoutIntervalForResource = 3600
//           AF.session.configuration.timeoutIntervalForRequest = 3600
//
//
//
//           AF.upload(multipartFormData: { (multipartFormData) in
//               for (key, value) in parameters! {
//
//                   if let valueString = value as? String{
//                       multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                   }else if let valueInt = value as? Int{
//                       multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                   }
//
//               }
//               if let key = videoKey, let videoArray = videoData {
//                   videoArray.forEach({
//                       multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//
//                   })
//               }
//
//            },to: url, method: .post , headers: hders)
//               .response { resp in
//                   print("sdsdsd",resp.data)
//                   //print(resp.value!)
//
//                   switch resp.result {
//                   case .success:
//                       if let dict = resp.value
//                    {
//                                            do {
//                                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//                    //                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                                                completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                                            } catch {
//                                                completionBlock(nil, resp.error)
//                                            }
//                    //                        print(resp.value!)
//
//                                        }
////                       {
////                           let data = dict as! Dictionary<String,Any>
////                       //    let data = dict as! Dictionary<String,Any>
////
////                           print(resp.value!)
////                           print(data)
////                           completionBlock(data,nil)
////                       }
//
//
//                   case .failure(let error): break
//                   print((error as NSError).localizedDescription)
//                   completionBlock(nil ,resp.error)
//                   print("\(error.localizedDescription)")
//                   }
//           }
//       }
//
   
//    static func postToServerWithImageAndVideo(videoData: [Data]? = nil, videoKey: String? = nil,parameters : [String: Any],completionBlock : @escaping CompletionBlock)  {
//        SwiftLoader.show(title: "Loading...", animated: true)
//        let url = Apphelper.Constants.API.providers_posts
//        let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                if let valueString = value as? String{
//                    multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                }else if let valueInt = value as? Int{
//                    multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                }
//            }
//            if let key = videoKey, let videoArray = videoData {
//                videoArray.forEach({
//                    multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                })
//            }
//
//        }, to: url,method: .post, headers: header)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                SwiftLoader.hide()
//                print(resp.value)
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
////                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                            completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                        }
////                        print(resp.value!)
//
//                    }
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//            }
//        }
//    }
//   static func postToServeRiviewVideo(videoData: [Data]? = nil, videoKey: String? = nil,parameters : [String: Any],completionBlock : @escaping CompletionBlock)  {
//
//           let url = Apphelper.Constants.API.addReviews
//           let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//            SwiftLoader.show(title: "Loading...", animated: true)
//           AF.upload(multipartFormData: { multipartFormData in
//               for (key, value) in parameters {
//                   if let valueString = value as? String{
//                       multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                   }else if let valueInt = value as? Int{
//                       multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                   }
//               }
//               if let key = videoKey, let videoArray = videoData {
//                   videoArray.forEach({
//                       multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                    print("File size before compression: \(Double((videoData!.count) / 1048576)) mb")
//                   })
//               }
//
//           }, to: url,method: .post, headers: header)
//               .response { resp in
//                   print("sdsdsd",resp.data)
//                   print(resp.value)
//                    SwiftLoader.hide()
//                   switch resp.result {
//                   case .success:
//                       if let dict = resp.value
//                       {
//                           do {
//                               let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//   //                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                               completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                           } catch {
//                               completionBlock(nil, resp.error)
//                           }
//   //                        print(resp.value!)
//
//                       }
//                   case .failure(let error): break
//                   print((error as NSError).localizedDescription)
//                   completionBlock(nil ,resp.error)
//                   print("\(error.localizedDescription)")
//               }
//           }
//       }
//    static func EditProfileWithImageAndVideo(videoData: [Data]? = nil, videoKey: String? = nil,parameters : [String: Any],completionBlock : @escaping CompletionBlock)  {
//
//            let url = Apphelper.Constants.API.edit_profile
//            let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//            AF.upload(multipartFormData: { multipartFormData in
//                for (key, value) in parameters {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }
//                }
//                if let key = videoKey, let videoArray = videoData {
//                    videoArray.forEach({
//                        multipartFormData.append($0, withName: key, fileName: "video.mov", mimeType: "video/mov")
//                    })
//                }
//
//            }, to: url,method: .post, headers: header)
//                .response { resp in
//                    print("sdsdsd",resp.data)
//                    print(resp.value)
//
//                    switch resp.result {
//                    case .success:
//                        if let dict = resp.value
//                        {
//                            do {
//                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//    //                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                                completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                            } catch {
//                                completionBlock(nil, resp.error)
//                            }
//    //                        print(resp.value!)
//
//                        }
//                    case .failure(let error): break
//                    print((error as NSError).localizedDescription)
//                    completionBlock(nil ,resp.error)
//                    print("\(error.localizedDescription)")
//                }
//            }
//        }
//
    
//    static func postToServerWithVideo(videoData: [Data]? = nil, videoKey: String? = nil,parameters : [String: Any],completionBlock : @escaping CompletionBlock)  {
//
//            let url = Apphelper.Constants.API.add_reviews
//            let header : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//             SwiftLoader.show(title: "Loading...", animated: true)
//            AF.upload(multipartFormData: { multipartFormData in
//                for (key, value) in parameters {
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }
//                }
//                if let key = videoKey, let videoArray = videoData {
//                    videoArray.forEach({
//                        multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                    })
//                }
//
//            }, to: url,method: .post, headers: header)
//                .response { resp in
//                    print("sdsdsd",resp.data)
//                    print(resp.value)
//                     SwiftLoader.hide()
//                    switch resp.result {
//                    case .success:
//                        if let dict = resp.value
//                        {
//                            do {
//                                let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//    //                           let hobbysDict = try? JSONSerialization.jsonObject(with: dict!, options: [])
//
//                                completionBlock(hobbysDict as! Dictionary<String, Any>, nil)
//
//                            } catch {
//                                completionBlock(nil, resp.error)
//                            }
//    //                        print(resp.value!)
//
//                        }
//                    case .failure(let error): break
//                    print((error as NSError).localizedDescription)
//                    completionBlock(nil ,resp.error)
//                    print("\(error.localizedDescription)")
//                }
//            }
//        }
    
    
    
        
//        let url = Apphelper.Constants.API.providers_posts
//        let hders : HTTPHeaders = [ "Authorization" : Facade.shared.authToken ?? ""]
//
//        AF.session.configuration.timeoutIntervalForResource = 3600
//        AF.session.configuration.timeoutIntervalForRequest = 3600
//
//
//
//        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
//
////               AF.upload(multipartFormData: { (multipartFormData) in
////                   multipartFormData.append(videoUrl, withName: "image", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
////               }, to: endPoint!  ).responseJSON { (response) in
////                   debugPrint(response)
////               }
//        AF.upload(multipartFormData: { (multipartFormData) in
//
//
//            for (key, value) in parameters {
//                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
//            }
//
//            // here you can upload only mp4 video
//            multipartFormData.append(videoData, withName: "images", fileName: "\(timestamp).mp4", mimeType: "\(timestamp)/mp4")
////            multipartFormData.append(videoData, withName: "images", fileName: "video.mp4", mimeType: "video/mp4")
//            // here you can upload any type of video
//
////            let urlSTRING = (videoData.absoluteString)
////            multipartFormData.append((urlSTRING.data(using: String.Encoding.utf8, allowLossyConversion: false))!, withName: "images")
//
//            print(multipartFormData)
//        },to: url, method: .post , headers: hders)
//            .response { resp in
//                print("sdsdsd",resp.data)
//                print(resp.value)
//
//                switch resp.result {
//                case .success:
//                    if let dict = resp.value
//                    {
//                        do {
//
//                            let hobbysDict = try JSONSerialization.jsonObject(with: dict!, options: .allowFragments) as! [String: AnyObject]
//
//                            completionBlock(hobbysDict, nil)
//
//                        } catch {
//                            completionBlock(nil, resp.error)
//                        }
//                        print(resp.value!)
//
//                    }
//
//
//                case .failure(let error): break
//                print((error as NSError).localizedDescription)
//                completionBlock(nil ,resp.error)
//                print("\(error.localizedDescription)")
//                }
//        }
//    }
//
//
//                for (key, value) in parameters {
//
//                    if let valueString = value as? String{
//                        multipartFormData.append((valueString).data(using: .utf8)!, withName: key)
//                    }else if let valueInt = value as? Int{
//                        multipartFormData.append(("\(valueInt)").data(using: .utf8)!, withName: key)
//                    }
//
//                }
//                if let key = videoKey, let videoArray = videoData {
//                    videoArray.forEach({
//                        multipartFormData.append($0, withName: key, fileName: "video.mp4", mimeType: "video/mp4")
//                    })
//                }
//
//
//    //            do {
//    //                let videoData = try Data(contentsOf: videoData)
//    //                multipartFormData.append(videoData, withName: videoKey!, fileName: "asset.mp4", mimeType: "asset/mp4")
//    //            } catch {
//    //                debugPrint("Couldn't get Data from URL: \(videoData): \(error)")
//    //            }
//    //            multipartFormData.append(videoData, withName: videoKey!, fileName: "video.mp4", mimeType: "video/mp4")
//
//            },to: url, method: .post , headers: hders)
//                .response { resp in
//                    print("sdsdsd",resp.data)
//
//
//                    switch resp.result {
//                    case .success:
//                        if let dict = resp.value
//                        {
//
//                            let data = dict as! Dictionary<String,Any>
//
//                            print(resp.value!)
//                            print(data)
//                            completionBlock(data,nil)
//                        }
//
//
//                    case .failure(let error): break
//                    print((error as NSError).localizedDescription)
//                    completionBlock(nil ,resp.error)
//                    print("\(error.localizedDescription)")
//                    }
//            }
//    }

}
@available(iOS 13.0, *)
extension ServicesClass_New : URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate
{
   func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
       
       print("background finish")
       
//       if let completionHandler = Apphelper.appDelegate.completionBackgroundHandler
//       {
//           Apphelper.appDelegate.completionBackgroundHandler = nil
//           completionHandler()
//       }
   }
   
   func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
       
       if error == nil
       {
           
       }
       else
       {
           print("Background upload error : \(error!.localizedDescription)")
           session.uploadTask(withStreamedRequest: task.originalRequest!).resume()
       }
   }
   
   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void)
   {
       completionHandler(URLSession.ResponseDisposition.allow)
   }
   
   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data)
   {
       var json : Dictionary<String,Any>?
       
       do{
           json = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String,Any>
       }
       catch
       {
           print("Serialization problem")
       }
       
       print(json ?? ["" : ""])
   }
   
}
