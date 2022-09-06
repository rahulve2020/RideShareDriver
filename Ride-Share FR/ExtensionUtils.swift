//
//  ExtensionUtils.swift
//  ServiceHubConnect
//
//  Created by Imran on 29/01/22.
//

import UIKit

class ExtensionUtils: NSObject {}

//MARK: Extension UIColor
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
    
//    public class var KColorAppTheme: UIColor{
//        return UIColor(hex: KColor.hexStrAppTheme)
//    }
    
//    public class var KColorBorder: UIColor{
//        return UIColor(hex: KColor.hexStrBorder)
//    }
    
   
}



//MARK: Extension String
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }

    //MARK: Localization
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeAColl() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

extension UILabel {

    func set(text:String, leftIcon: UIImage? = nil, rightIcon: UIImage? = nil) {

        let leftAttachment = NSTextAttachment()
        leftAttachment.image = leftIcon
        leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: 20, height: 20)
        if let leftIcon = leftIcon {
            leftAttachment.bounds = CGRect(x: 0, y: -2.5, width: leftIcon.size.width, height: leftIcon.size.height)
        }
        let leftAttachmentStr = NSAttributedString(attachment: leftAttachment)

        let myString = NSMutableAttributedString(string: "")

        let rightAttachment = NSTextAttachment()
        rightAttachment.image = rightIcon
        rightAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 20)
        let rightAttachmentStr = NSAttributedString(attachment: rightAttachment)


        if semanticContentAttribute == .forceRightToLeft {
            if rightIcon != nil {
                myString.append(rightAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if leftIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(leftAttachmentStr)
            }
        } else {
            if leftIcon != nil {
                myString.append(leftAttachmentStr)
                myString.append(NSAttributedString(string: " "))
            }
            myString.append(NSAttributedString(string: text))
            if rightIcon != nil {
                myString.append(NSAttributedString(string: " "))
                myString.append(rightAttachmentStr)
            }
        }
        attributedText = myString
    }
}


extension NSAttributedString {
    func height(withConstrainedWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}


//MARK: Extension ScrollView
public extension UIScrollView {
    func addRefreshControl(_ block:@escaping ()->()) {
        self.addSubview(SSRefreshControl().addRefreshControl(block))
    }
}

//MARK: Extension NSDictionary
public extension NSDictionary {
    func toData(jsonPath : String = "data") -> Data{
        let dataDict = self.value(forKeyPath: jsonPath)
        do{
            let dataJson = try JSONSerialization.data(withJSONObject: dataDict ?? ["" : ""], options: .prettyPrinted)
            
            //let hobbysDict = try JSONSerialization.data(withJSONObject: dataDict!, options: .allowFragments) as! [String: AnyObject]
            
            
           // let dataJson = try JSONSerialization.data(withJSONObject: dataDict as Any, options: .prettyPrinted)
            return dataJson
        }catch let error{
           // alertMessase(message: error.localizedDescription, okAction: {})
        }
        return Data()
    }
    
    func toCustom(jsonPath: String) -> Data {
        let dataDict = self.value(forKey: jsonPath)
        do {
            let dataJson = try JSONSerialization.data(withJSONObject: dataDict as Any, options: .prettyPrinted)
            return dataJson
        } catch let error {
          //  alertMessase(message: error.localizedDescription, okAction: {})
        }
        return Data()
    }
}


//MARK: Extension Encodable
extension Encodable {
    var postDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        let postDict = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        print("Post Dictionary : \(String(describing: postDict))")
        return postDict
    }
}

public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

//MARK: Custom class for Refresh Scroll
class SSRefreshControl: UIRefreshControl {
    var action : (()->())?
    func addRefreshControl(_ block:@escaping ()->()) -> UIRefreshControl {
        action = block
        self.tintColor = UIColor.black
        self.addTarget(self, action: #selector(SSRefreshControl.loadRefreshing), for: .valueChanged)
        return self
    }
    
    @objc func loadRefreshing() {
        action!()
        self.endRefreshing()
    }
}

//MARK: Text field
extension UITextField {
    func addBottomBorder(){
        let border = CALayer()
        let width = CGFloat(1.5)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}


extension UIButton
{
    
    
    func MakeCornetBtn(){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.clipsToBounds = true
        self.layer.cornerRadius = 8.0
    }
    
    func primaryBorderColor(){
        self.layer.borderWidth = 1.1
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = #colorLiteral(red: 1, green: 0.1772966683, blue: 0.5015750527, alpha: 1)
    }
    
    func makeRoundedBtn(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    
}

extension UIImageView{
    func MakeRoundImage()
    {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}

//MARK: Extension UIView
extension UIView {
    
    
    
    
    class func fromNib<T : UIView>(xibName: String) -> T {
        return Bundle.main.loadNibNamed(xibName, owner: nil, options: nil )![0] as! T
    }
    
    
    func roundedCorner(cornerRadii: CGSize, corners: UIRectCorner) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: cornerRadii)
        
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.path = maskPath.cgPath
        layer.mask = shape
        
    }
    
    
    func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    func shadow () {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
    }
    
    func setImg(){
    self.layer.borderWidth=1.0
    //self.img.layer.masksToBounds = false
    self.layer.borderColor = #colorLiteral(red: 0.203332454, green: 0.3568145037, blue: 0.6725091934, alpha: 1)
    self.layer.cornerRadius = self.frame.size.height/2
    self.clipsToBounds = true
        
    }
    func makeRounded(){
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
    func makeRoundCorner(_ radius:CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    func makeBorder(_ width:CGFloat,color:UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.clipsToBounds = true
    }
    
    //give the border to UIView
    func border(radius : CGFloat,borderWidth : CGFloat,color :CGColor){
        self.layer.masksToBounds = true
        self.layer.cornerRadius  = radius
        self.layer.borderWidth   = borderWidth
        self.layer.borderColor   = color
    }
    
    //give the circle border to UIView
    func circleBorder() {
        let hight = self.layer.frame.height
        let width = self.layer.frame.width
        if hight < width {
            self.layer.cornerRadius = hight/2
            self.layer.masksToBounds = true
        }
        else {
            self.layer.cornerRadius  = width/2
            self.layer.masksToBounds = true
        }
    }
    
    func addShadow(radius: CGFloat, cornerRadius: CGFloat = 1, color: UIColor = UIColor.lightGray.withAlphaComponent(0.8)){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
    }
    
    
    func snapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func close() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }, completion: { (compelete) in
            if compelete {
                self.removeFromSuperview()
            }
        })
    }
    
    func addThreeSideShadow() {
        layer.cornerRadius = 10
        let shadowSize:CGFloat = 3
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: shadowSize + shadowSize + 2,
                                                   width: self.frame.size.width + shadowSize,
                                                   height: self.frame.size.height + shadowSize))
        self.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func MakeRoundView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
}
