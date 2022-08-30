//  Haute Delivery
//
//  Created by Ashish Gupta on 06/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//

import UIKit

class BaseNavigationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    func changeToRoundOff(val: String?)-> String{
//        let strFloat = Float(/(val)) ?? 0.00
//        return String(format: "%.02f", strFloat)
//    }
    
    public func loadBarItemWith(customButtons : [SSButtonCustom] ,isLeftSide : Bool? = true, action :@escaping ((Int)->())){
        var arrBarButtonItem = [UIBarButtonItem]()
        for objButton in customButtons {
            objButton.tag = customButtons.firstIndex(of: objButton)!
            objButton.handleControlEvents(.touchUpInside) {
                action(objButton.tag)
            }
            let barButtonItem = UIBarButtonItem(customView: objButton)
            arrBarButtonItem.append(barButtonItem)
        }
        if isLeftSide! {
            self.navigationItem.leftBarButtonItems = arrBarButtonItem
        }else{
            self.navigationItem.rightBarButtonItems = arrBarButtonItem
        }
    }

    public func loadBarItemWith(image : UIImage,isLeftSide : Bool? = true, action :@escaping (()->())){
        let customButton = SSButtonCustom(type: .custom)
        customButton.setImage(image, for: .normal)
        customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let barButtonItem = UIBarButtonItem(customView: customButton)
        if isLeftSide! {
            self.navigationItem.leftBarButtonItem = barButtonItem
        }else{
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
        customButton.handleControlEvents(.touchUpInside) {
            action()
        }
    }
    
    public func setBarItemImage(image : UIImage,isLeftSide : Bool? = true){
        let customButton = SSButtonCustom(type: .custom)
        customButton.setImage(image, for: .normal)
        customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let barButtonItem = UIBarButtonItem(customView: customButton)
        if isLeftSide! {
            self.navigationItem.leftBarButtonItem = barButtonItem
        }else{
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
    }
    
    public func loadMultipleBarItemWith(images : [UIImage],isLeftSide : Bool? = true, action :@escaping ((Int)->())){
        var arrItems = [UIBarButtonItem]()
        for img in images{
            let customButton = SSButtonCustom(type: .custom)
            customButton.setImage(img, for: .normal)
            customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            customButton.tag = images.index(of: img)!
            customButton.handleControlEvents(.touchUpInside) {
                action(customButton.tag)
            }
            let barButtonItem = UIBarButtonItem(customView: customButton)
            arrItems.append(barButtonItem)
        }
        if isLeftSide! {
            self.navigationItem.leftBarButtonItems = arrItems
        }else{
            self.navigationItem.rightBarButtonItems = arrItems
        }
    }
    
    public func loadBarItemWith(icon : FAType,iconColor : UIColor? = UIColor.white, isLeftSide : Bool? = true, action :@escaping (()->())){
        let customButton = SSButtonCustom(type: .custom)
        customButton.setFAIcon(icon: icon, iconSize: 20, forState: .normal)
        customButton.setTitleColor(iconColor, for: .normal)
        customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let barButtonItem = UIBarButtonItem(customView: customButton)
        if isLeftSide! {
            self.navigationItem.leftBarButtonItem = barButtonItem
        }else{
            self.navigationItem.rightBarButtonItem = barButtonItem
        }
        customButton.handleControlEvents(.touchUpInside) {
            action()
        }
    }
    
    public func loadMutipleBarItemsWith(icons : [FAType],iconColors : [UIColor?] = [UIColor.white], isLeftSide : Bool? = true, action :@escaping ((Int)->())){
        var arrItems = [UIBarButtonItem]()
        for icon in icons{
            let customButton = SSButtonCustom(type: .custom)
            customButton.setFAIcon(icon: icon, iconSize: 20, forState: .normal)
            customButton.setTitleColor(iconColors[icons.index(of: icon)!], for: .normal)
            customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            customButton.tag = icons.index(of: icon)!
            customButton.handleControlEvents(.touchUpInside) {
                action(customButton.tag)
            }
            let barButtonItem = UIBarButtonItem(customView: customButton)
            arrItems.append(barButtonItem)
        }
        if isLeftSide! {
            self.navigationItem.leftBarButtonItems = arrItems
        }else{
            self.navigationItem.rightBarButtonItems = arrItems
        }
    }
    

    func setNavigation(title : String?, tintColor : UIColor?, barTintColor : UIColor? , textColor : UIColor?) {
        if let _ = title {
            self.title = title
        }
        if let _ = tintColor{
            self.navigationController?.navigationBar.tintColor = tintColor
        }
        if let _ = barTintColor{
            self.navigationController?.navigationBar.barTintColor = barTintColor
        }
        if let _ = textColor {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : textColor!]
        }
    }
}

public class SSButtonCustom: UIButton {
    private var action : (()->())?
    
    func handleControlEvents(_ events:UIControl.Event, withCompletionBlock block:@escaping ()->()) {
        action = block
        self.addTarget(self, action: #selector(SSButtonCustom.btnAction(_:)), for: events)
    }
    
    @objc func btnAction(_ sender:AnyObject) {
        action!()
    }
}
