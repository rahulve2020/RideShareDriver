//
//  Common.swift
//  ServiceHubConnect
//
//  Created by Pervez Malik on 15/04/21.
//

import Foundation
import UIKit
import SystemConfiguration
import CoreLocation
//import EventKit
//import TwilioChatClient

final class Common {
    static var locManager = CLLocationManager()

    // MARK: - Singleton
    static let shared = Common()
    //var selectedItems = [Info]()
    
    class public func currentLocation() -> CLLocation? {
        
              //let locManager = CLLocationManager()
              locManager.startUpdatingLocation()
              locManager.requestWhenInUseAuthorization()
              var currentLocation: CLLocation?
              if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                  CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                  currentLocation = locManager.location
              }else
              {
                  locManager.stopUpdatingLocation()
                  
              }
              
              return currentLocation
    }
    
//    class public func getTotalItemCount(ps: [Info])-> Int  {
//       return ps.reduce(0) {
//        return $0 + Common.getItemCount(info: $1)
//        }
//    }
    
//    class func getItemCount(info: Info) -> Int {
//        var count = 0;
//        if(info.itemCount > 0) {
//            count = info.itemCount
//        } else {
//            count = Common.getSelectedSizeCount(sizePrice: info.size_price)
//        }
//        return count;
//    }
    
//    class public func getTotalItemCost(ps: [Info])-> Double  {
//       return ps.reduce(0) {
//        return $0 + Common.getItemCost(info: $1)
//        }
//    }
//
//    class func getItemCost(info: Info) -> Double{
//        var price: Double = 0.0;
//        if(info.itemCount > 0) {
//            price = (Double(info.price ?? "0") ?? 0) * Double(info.itemCount)
//        }
//        else {
//            price = Double(Common.getSelectedSizePriceCost(sizePrice: info.size_price))
//        }
//        let extraCost = Double(Common.getExtaTotalCost(info: info));
//        return price + extraCost;
//        
////        let selectedExtraCost = Common.getSelectedSizePriceCost(sizePrice: info.size_price)
////        let extraCost = Common.getExtaTotalCost(info: info);
////        return price + extraCost + selectedExtraCost;
//    }
//    // for with out extra items
//    class func getExtaTotalCost(info: Info) -> Double{
//        let extraArray: [extraInfoListData] = info.extraInfoArray
//        return Double(extraArray.reduce(0) {
//            return $0 + Common.getExtraItemCost(dataListDetail: $1.dataList)
//        })
//    }
//    // for with extra items
//    class func getExtraItemCost(dataListDetail: [dataListDetail]) -> Double {
//        dataListDetail.reduce(0) {
//         var price: String = "0";
//            if($1.itemCount > 0) {
//                price = $1.price ?? "0"
//            }
//            return $0 + (Double(price ) ?? 0) * Double($1.itemCount)
//            }
//    }
//    
//    class public func getSelectedSizePriceCost(sizePrice: [sizePriceList])-> Double  {
//        return sizePrice.reduce(0) {
//         var price: String = "0";
//         if($1.itemCount > 0) {
//             price = $1.price ?? "0"
//         }
//            return $0 + (Double(price ) ?? 0) * Double($1.itemCount)
//         }
//    }
//    class public func getSelectedSizeCount(sizePrice: [sizePriceList])-> Int  {
//        return sizePrice.reduce(0) {
//             return $0 + $1.itemCount
//         }
//    }
//    
//    class public func getTotalTimeDuration(ps: [Info])-> Double  {
//        return ps.reduce(0.0) {
//        return $0 + Common.getTimeDuration(info: $1)
//        }
//    }
//    
//    class func getTimeDuration(info: Info) -> Double{
//        var duration: Double = 0.0;
//        if(info.itemCount > 0) {
//            duration = (Double(info.duration ?? 0)) * Double(info.itemCount)
//        } else {
//            duration = Common.getSelectedTimeDuration(sizeDuration: info.size_price)
//        }
//        let extraItemDuration = Common.getExtaTotalTimeDuration(info: info);
//        return duration + extraItemDuration;
//    }
//    
//    class public func getSelectedTimeDuration(sizeDuration: [sizePriceList])-> Double  {
//        return sizeDuration.reduce(0) {
//         var duration: Int = 0;
//         if($1.itemCount > 0) {
//            duration = $1.duration ?? 0
//         }
//            if $1.isSelected {
//                $1.isSelected = false
//            }
//            return $0 + (Double(duration ) ) * Double($1.itemCount) 
//         }
//    }
//    class func getExtaTotalTimeDuration(info: Info) -> Double{
//        let extraArray: [extraInfoListData] = info.extraInfoArray
//        return extraArray.reduce(0.0) {
//            return $0 + Double(Common.getTotalTime(dataListDetail: $1.dataList))
//         }
//    }
//    class func getTotalTime(dataListDetail: [dataListDetail]) -> Double {
//        dataListDetail.reduce(0) {
//            var eDuration: Double = 0.0;
//            if($1.itemCount > 0) {
//                eDuration = $1.duration ?? 0.0
//            }
//            if $1.isSelected {
//                $1.isSelected = false
//            }
//    
//            return $0 + (Double(eDuration)) * Double($1.itemCount) 
//            }
//    }
//    
//    class public func isIdenticalInfo(firstInfo: Info, secondInfo: Info) -> Bool {
//        if (firstInfo.isExtraPackage == false && firstInfo.is_size == false ) {
//            return firstInfo._id == secondInfo._id
//        } else if (firstInfo.isExtraPackage == true && secondInfo.isExtraPackage == true && firstInfo.is_size == true && secondInfo.is_size == true && firstInfo.size_price.count == secondInfo.size_price.count) {
//            return firstInfo._id == secondInfo._id && Common.isSizeListIdentical(firstSize: firstInfo.size_price, secondSize: secondInfo.size_price) && Common.isExtraInfoListIdentical(firstExtraInfo: firstInfo.selectedExtraInfoArray, secondExtraInfo: secondInfo.selectedExtraInfoArray)
//        } else if (firstInfo.isExtraPackage == true && firstInfo.is_size == false) {
//            return firstInfo._id == secondInfo._id && Common.isExtraInfoListIdentical(firstExtraInfo: firstInfo.selectedExtraInfoArray, secondExtraInfo: secondInfo.selectedExtraInfoArray)
//        } else if (firstInfo.isExtraPackage == false && firstInfo.is_size == true) {
//            return firstInfo._id == secondInfo._id && Common.isSizeListIdentical(firstSize: firstInfo.size_price, secondSize: secondInfo.size_price)
//        }
//        return false
//    }
//    
//    class public func isSizeListIdentical(firstSize:[sizePriceList], secondSize:[sizePriceList]) -> Bool {
//        if firstSize.count == secondSize.count {
//        for i in 0..<firstSize.count {
//            let firstElement = firstSize[i]
//            let secondElement = secondSize[i]
//            if(Common.isSizeIdentical(firstSize: firstElement, secondSize: secondElement)){
//                continue
//            } else {
//                return false
//            }
//        }
//        return true;
//        }
//        return false
//    }
//    
//    
//    class public func isSizeIdentical(firstSize:sizePriceList, secondSize:sizePriceList) -> Bool {
//        return firstSize.size == secondSize.size && firstSize.price == secondSize.price && firstSize.itemCount == secondSize.itemCount
//    }
//    
//    class public func isExtraInfoListIdentical(firstExtraInfo:[extraInfoListData], secondExtraInfo:[extraInfoListData]) -> Bool {
//        if (firstExtraInfo.count == secondExtraInfo.count) {
//            for i in 0..<firstExtraInfo.count {
//                let firstElement = firstExtraInfo[i]
//                let secondElement = secondExtraInfo[i]
//                if(Common.isExtraInfoIdentical(firstExtraInfo: firstElement, secondExtraInfo: secondElement)){
//                    continue
//                } else {
//                    return false
//                }
//            }
//            return true;
//        }
//      
//        return false;
//    }
//    class public func isExtraInfoIdentical(firstExtraInfo:extraInfoListData, secondExtraInfo:extraInfoListData) -> Bool {
//        if (firstExtraInfo._id == secondExtraInfo._id) {
//            for i in 0..<firstExtraInfo.dataList.count {
//                let firstElement = firstExtraInfo.dataList[i]
//                let secondElement = secondExtraInfo.dataList[i]
//                if(Common.isDataListIdentical(firstDataList: firstElement, secondDataList: secondElement)){
//                    continue
//                } else {
//                    return false
//                }
//            }
//            return true;
//        }
//      
//        return false;
//    }
//    
//    class public func isDataListIdentical(firstDataList:dataListDetail, secondDataList:dataListDetail) -> Bool {
//        return firstDataList.size == secondDataList.size && firstDataList.price == secondDataList.price && firstDataList.itemCount == secondDataList.itemCount
//    }
//    
//    class public func itemExitsInArray(items: [[Info]], object: Info) -> Int{
//        var found = -1;
//        for i in 0..<items.count {
//            for seperateItmem in  items[i] {
//                if (Common.isIdenticalInfo(firstInfo: seperateItmem, secondInfo: object)) {
//                    found = i;
//                    return found;
//                }
//            }
//        }
//        return found;
//    }
//    
//    class public func getConsolidatedArray(items: [Info]) -> [[Info]] {
//        var consolidatedItems = [[Info]]();
//        for item in items {
//         let existingIndex = Common.itemExitsInArray(items: consolidatedItems, object: item)
//            if(existingIndex > -1){
//                var seperateItems:[Info] = consolidatedItems[existingIndex];
//                seperateItems.append(item);
//                consolidatedItems[existingIndex] = seperateItems;
//                
//            } else {
//                var seperateItems = [Info]()
//                seperateItems.append(item)
//                consolidatedItems.append(seperateItems);
//            }
//        }
//        return consolidatedItems;
//    }
//    class public func saveCatagoryIds() -> (String? , String?){
//        var catagory_id : String?
//        var subCatagory_id : String?
//
//        return(catagory_id , subCatagory_id)
//        
//    }
//    
}

