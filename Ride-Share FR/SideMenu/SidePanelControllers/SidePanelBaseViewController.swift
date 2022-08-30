//  Haute Delivery
//
//  Created by Ashish Gupta on 06/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//
//

import UIKit
import SidebarOverlay

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SidePanelBaseViewController: SOContainerViewController {
    
    var strAppUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSlide()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        _ = try? isUpdateAvailable { (update, error) in
//            if let error = error {
//             //   print(self.isUpdateAvailable)
//                print(error)
//            } else if let update = update {
//                if update {
//                if self.strAppUrl != "" {
//                    DispatchQueue.main.async {
//                    alertMessase(strOk: "Update", withTitle: "Snap Merchant Control Restaurant Alert", message:  "A new version of Snap Merchant Control is available,Please update.", cancelAction: {}, okAction: {
//                        if #available(iOS 10.0, *) {
//                            UIApplication.shared.open(URL(string: self.strAppUrl)!, options: [:], completionHandler: nil)
//
//                        } else {
//                            UIApplication.shared.openURL(URL(string: self.strAppUrl)!)
//                        }
//                    })
//                }
//                    }
//                print(update)
//            }
//            }
//        }
//    }
//
//    func changeToRoundOff(val: String?)-> String{
//        let strFloat = Float((val)) ?? 0.00
//        return String(format: "%.02f", strFloat)
//    }
    
    @IBAction func btnActionSideMenu(_ sender: UIButton) {
        if let container = self.so_containerViewController {
            container.isSideViewControllerPresented = true
        }
    }
    
   
    
    func setupSlide() {
        self.sideMenuWidth = KScreenSize.width * 0.78
        self.menuSide = .left
        self.sideViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
    }

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
            if let container = self.so_containerViewController{
                self.menuSide = .left
                self.sideViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
                container.isSideViewControllerPresented = true
                
            }
        }
    }
    
    public func loadMultipleBarItemWith(images : [UIImage],isLeftSide : Bool? = true, action :@escaping ((Int)->())){
        var arrItems = [UIBarButtonItem]()
        for img in images{
            let customButton = SSButtonCustom(type: .custom)
            customButton.setImage(img, for: .normal)
            customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            customButton.tag = images.firstIndex(of: img)!
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
    
//    public func loadBarItemWith(icon : FAType,iconColor : UIColor? = UIColor.white, isLeftSide : Bool? = true, action :@escaping (()->())){
//        let customButton = SSButtonCustom(type: .custom)
//        customButton.setFAIcon(icon: icon, iconSize: 20, forState: .normal)
//        customButton.setTitleColor(iconColor, for: .normal)
//        customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        let barButtonItem = UIBarButtonItem(customView: customButton)
//        if isLeftSide! {
//            self.navigationItem.leftBarButtonItem = barButtonItem
//        }else{
//            self.navigationItem.rightBarButtonItem = barButtonItem
//        }
//        customButton.handleControlEvents(.touchUpInside) {
//            action()
//        }
  //  }
    
    public func loadMutipleBarItemsWith(icons : [FAType],iconColors : [UIColor?] = [UIColor.white], isLeftSide : Bool? = true, action :@escaping ((Int)->())){
        var arrItems = [UIBarButtonItem]()
        for icon in icons{
            let customButton = SSButtonCustom(type: .custom)
            customButton.setFAIcon(icon: icon, iconSize: 20, forState: .normal)
            customButton.setTitleColor(iconColors[icons.firstIndex(of: icon)!], for: .normal)
            customButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            customButton.tag = icons.firstIndex(of: icon)!
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
    
    //MARK: UTC to Current date
    func convertDateFormatterUTC(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"//this your string date format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let convertedDate = dateFormatter.date(from: date)
        guard dateFormatter.date(from: date) != nil else {
            return ""
        }
        dateFormatter.dateFormat = "d MMM yyyy , hh:mm a"
        dateFormatter.timeZone = TimeZone.current
        let timeStamp = dateFormatter.string(from: convertedDate!)
        return timeStamp
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
    
    
    func isUpdateAvailable(completion: @escaping (Bool?, Error?) -> Void) throws -> URLSessionDataTask {
        guard let info = Bundle.main.infoDictionary,
            let currentVersion = info["CFBundleShortVersionString"] as? String,
            let identifier = info["CFBundleIdentifier"] as? String,
            let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
                throw VersionError.invalidBundleInfo
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw VersionError.invalidResponse }
                let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
                guard let result = (json?["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String else {
                    throw VersionError.invalidResponse
                }
                self.strAppUrl = (result["trackViewUrl"] as? String) ?? ""
                completion(version != currentVersion, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
    
    enum VersionError: Error {
        case invalidResponse, invalidBundleInfo
    }
}


