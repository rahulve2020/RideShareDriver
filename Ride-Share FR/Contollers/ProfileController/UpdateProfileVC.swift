//
//  UpdateProfileVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/06/22.
//

import UIKit
import GoogleMaps
import GooglePlaces

@available(iOS 13.0, *)
class UpdateProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var updateImg: UIButton!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtArea: UITextField!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var vV: UIView!
    
    var isProfilePicUpload:Bool? = false
    var lat: String?
    var long: String?
    
    var locationManager : CLLocationManager!
    var arrCodinate = [String]()
    var gmsAddress : GMSAddress?
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        img.setImg()
        vV.shadow()
        setvalue()
        // Do any additional setup after loading the view.
    }
    func setvalue(){
        
        self.txtFirstName.text = DSUserPrefrence.FullName
        self.txtNumber.text = "\(DSUserPrefrence.country_code) - \(DSUserPrefrence.mobile_number)"
        //self.emailLbl.text = DSUserPrefrence.email_address
        self.txtArea.text = DSUserPrefrence.serviceArea
        img.sd_setImage(with: URL.init(string:  DSUserPrefrence.profilePicture )) { (image, error, cache, urls) in
            if (error != nil) {
                self.img.image = UIImage(named: "")
            } else {
                self.img.image = image
            }
        }
        
    }


    func load() {
        firstView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        areaView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        
        firstView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        areaView.layer.borderWidth = 1
        updateImg.layer.cornerRadius = updateImg.frame.size.width/2
        updateImg.clipsToBounds = true
       
    }
    
    
//    func getUpdateProfile() -> Void {
//        var dicParam : Dictionary<String,Any> = Dictionary()
//        dicParam["name"] = txtFirstName.text
//        dicParam["serviceArea"] = txtArea.text
//        dicParam["latitude"] = self.lat
//        dicParam["longitude"] = self.long
//        dicParam["profile_pic"] = ""//txtNewPassword.text
//
//
//        AppServices.shared.editProfile(param: dicParam, success: { (data) in
//
//            debugPrint("updateProfile:-\(data!)")
//            let dictdata = data as! [String : Any]
//            let dataObj = dictdata["data"] as! [String : Any]
////            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
////            vc.name = dataObj["name"] as! String
////            vc.email = dataObj["email"] as! String
////            vc.profile = dataObj["profile_pic"] as! String
////            self.navigationController?.pushViewController(vc, animated: true)
//           // self.showOkAlertWithHandler(dataObj["message"] as! String) {
//                DSUserPrefrence.FullName = dataObj["name"] as! String
//                DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
//                DSUserPrefrence.email_address = dataObj["email"] as! String
//                DSUserPrefrence.serviceArea = dataObj["serviceArea"] as! String
//
//                self.navigationController?.popViewController(animated: true)
//          //  }
//
//        }, failure: {errorMsg in
//            self.showOkAlert(errorMsg)
//        })
//    }
    func uploadPic()-> Void{
        
            var imgDataArray = [Data]()
            if let imgData = (img.image)!.pngData() ??
                (img.image)!.pngData(){
                imgDataArray = [imgData]
            }
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["user_id"] = DSUserPrefrence.user_ID
        dicParam["name"] = txtFirstName.text
        dicParam["serviceArea"] = txtArea.text
        dicParam["latitude"] = self.lat
        dicParam["longitude"] = self.long
        
        //if img.image != nil {
            AppServices.shared.updateProfile( param: dicParam, imageArray: imgDataArray, success: { (data) in
                DispatchQueue.main.async {
                    print("imageArrayimageArray:-",data!)
                    let dictdata = data as! [String : Any]
                    let dataObj = dictdata["data"] as! [String : Any]
                    DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
                    DSUserPrefrence.FullName = dataObj["name"] as! String
                   // DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
                    DSUserPrefrence.email_address = dataObj["email"] as! String
                    DSUserPrefrence.serviceArea = dataObj["serviceArea"] as! String
                    self.navigationController?.popViewController(animated: true)
                }
            }, failure: {errorMsg in
                self.showOkAlert(errorMsg)
            })
//        }else {
//            //self.showOkAlert("Please add image")
//        }
    }
    
    
    func openCameraAndGallery() -> Void {
        
        let alertController = UIAlertController.init(title: nil, message: "Please select an option for upload image", preferredStyle: .actionSheet)
        
        let galleryAlert = UIAlertAction.init(title: "Select image", style: .default) { (_action) in
            self.gallerySetup()
        }
        
        let CameraAlert = UIAlertAction.init(title: "Take image", style: .default) { (_action) in
            self.cameraAction()
        }
        
        let cancel = UIAlertAction.init(title: "Cancel", style: .cancel) { (_action) in
            
        }
        
        alertController.addAction(galleryAlert)
        alertController.addAction(CameraAlert)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func gallerySetup() -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func cameraAction() -> Void {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     //   imageData.removeAll()
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
          //  self.uploadPic()
           // self.selectedImage = image
            
          //  imageData.append(self.selectedImage!)
            isProfilePicUpload = true
            self.img.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func locationBtnTapped(_ sender: Any) {
        let locationGetViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationGetViewController") as! LocationGetViewController
        // locationGetViewController.currentLocation = self.locationManager.location
        locationGetViewController.delegateLocation = self
        self.navigationController?.pushViewController(locationGetViewController, animated: true)
    }
    
    @IBAction func updateProfile(_ sender: Any) {
        self.openCameraAndGallery()
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
          uploadPic()
//        if   isProfilePicUpload == true{
//            self.uploadPic()
//        }
//        else{
//            getUpdateProfile()
//        }
    }
    }




@available(iOS 13.0, *)
extension UpdateProfileVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtFirstName){
            txtFirstName.resignFirstResponder()
            txtNumber.becomeFirstResponder()
            
        }
        else if (textField == txtNumber){
            txtNumber.resignFirstResponder()
            txtArea.becomeFirstResponder()
            
        }
    
        else if (textField == txtArea){
            txtArea.resignFirstResponder()
            
        }
        
        return true
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == txtFirstName {
//            firstView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
//            firstView.layer.borderWidth = 1
//        }
//        else if textField == txtNumber {
//            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
//            numberView.layer.borderWidth = 1
//        }
//        else if textField == txtArea {
//            areaView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
//            areaView.layer.borderWidth = 1
//        }
//
//
//    }
}
@available(iOS 13.0, *)
extension UpdateProfileVC : LocationGetControllerDelegate{
   
    
    func locationGetData(addressString: GMSAddress?) {
        if (addressString != nil) {
            self.gmsAddress = addressString
            self.txtArea.text = addressString?.lines!.joined(separator: "\n")
//            let strLat = String(describing: /(addressString?.coordinate.latitude))
//            let strLong = String(describing: /(addressString?.coordinate.longitude))
            if let templat = addressString?.coordinate.latitude {
                self.lat = String(templat)
                self.arrCodinate.append(self.lat!)
            }
            if let temlong = addressString?.coordinate.longitude {
                self.long = String(temlong)
                self.arrCodinate.append(self.long!)
            }
           // self.lat = String(describing: (addressString?.coordinate.latitude))
           // self.long = String(describing: (addressString?.coordinate.longitude))
          //  self.arrCodinate = [self.lat,self.long]
        }
    }
    
    
}
