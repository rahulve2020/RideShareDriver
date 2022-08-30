//
//  ActivityIndicator.swift
//  Freeluancer
//
//  Created by Imran malik on 17/03/20.
//  Copyright © 2020 virtualEmployee. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class ActivityIndicator: NSObject {
    
    class func show() {
       //RappleActivityIndicatorView.startAnimatingWithLabel("Loading...", attributes: RappleModernAttributes)
      //  let activityData = ActivityData()//
      //  NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
                SwiftLoader.show(title: "Loading...", animated: true)


    }

    class func showWithText(_ text: String) {
       
    }
    
    class func hide() {
        SwiftLoader.hide()

     //   NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
   
    }
}
/*
class splashScreenLoader: NSObject
{
    static let shared : splashScreenLoader = splashScreenLoader()
    
    var view : UIView?
    
    func showSplash()
    {
        view = Bundle.main.loadNibNamed("splashView", owner: self, options: nil)?.first as? SplashView
        
        view?.bounds = CGRect.init(x: 0, y: 0, width: (UIApplication.shared.keyWindow?.rootViewController?.view.bounds.width)!, height: (UIApplication.shared.keyWindow?.rootViewController?.view.bounds.height)! + 64)
        
        
        UIApplication.shared.keyWindow?.addSubview(view!)
    }
    
    func removeSplash()
    {
        if view != nil
        {
            view?.removeFromSuperview()
        }
    }
}
*/










/*

class ActivityIndicator: NSObject {
    
    class func showActivity() {
        RappleActivityIndicatorView.startAnimating()
    }
    
    class func showActivityWithText() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleModernAttributes)
    }
    
    class func showActivityWithText(text: String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(text, attributes: RappleModernAttributes)
    }
    
    class func hideActivity() {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    class func hideActivity(_ status: RappleCompletion, text: String) {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: status, completionLabel: text)
    }
    
}
 */
