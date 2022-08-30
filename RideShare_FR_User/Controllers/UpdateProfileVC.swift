//
//  UpdateProfileVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/06/22.
//

import UIKit

@available(iOS 13.0, *)
class UpdateProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var updateImg: UIButton!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var lastView: UIView!
    @IBOutlet weak var numberView: UIView!
   
    @IBOutlet weak var vV: UIView!
    
    var isProfilePicUpload:Bool? = false
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        img.setImg()
        vV.shadow()
        setvalue()
        // Do any additional setup after loading the view.
    }
    

    func load() {
        firstView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        lastView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        

        
        firstView.layer.borderWidth = 1
        lastView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
       
        
        updateImg.layer.cornerRadius = updateImg.frame.size.width/2
        updateImg.clipsToBounds = true
       
    }
    func setvalue(){
        
        self.txtFirstName.text = DSUserPrefrence.FullName
        self.txtLastName.text = DSUserPrefrence.email_address
        self.txtNumber.text = "\(DSUserPrefrence.country_code) - \(DSUserPrefrence.mobile_number)"
      //  self.emailLbl.text = DSUserPrefrence.email_address
        img.sd_setImage(with: URL.init(string:  DSUserPrefrence.profilePicture )) { (image, error, cache, urls) in
            if (error != nil) {
                self.img.image = UIImage(named: "")
            } else {
                self.img.image = image
            }
        }
        
    }
//
//    func getUpdateProfile() -> Void {
//        var dicParam : Dictionary<String,Any> = Dictionary()
//       // dicParam["email"] = DSUserPrefrence.email_address
//       // dicParam["mobile"] = DSUserPrefrence.contact_number
//        dicParam["name"] = txtFirstName.text
//        dicParam["profile_pic"] = ""//txtNewPassword.text
//
//
//        AppServices.shared.updateProfileDetails(param: dicParam, success: { (data) in
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
       // dicParam["mobile_no"] = txtPhoneNumber.text
      //  dicParam["country_code"] = btnCountryCode.titleLabel?.text ?? ""
     //   dicParam["email"] = txtLastName.text
       // dicParam["profile_pic"] = imgDataArray
        
        //if img.image != nil {
            AppServices.shared.updateProfile( param: dicParam, imageArray: imgDataArray, success: { (data) in
                DispatchQueue.main.async {
                    print("imageArrayimageArray:-",data!)
                    let dictdata = data as! [String : Any]
                    let dataObj = dictdata["data"] as! [String : Any]
                    DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
                    DSUserPrefrence.FullName = dataObj["name"] as! String
                  //  DSUserPrefrence.profilePicture = dataObj["profile_pic"] as! String
                    DSUserPrefrence.email_address = dataObj["email"] as! String
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
//
//        }
//        else{
//            getUpdateProfile()
//        }
//    }
      //  getUpdateProfile()
}

}

@available(iOS 13.0, *)
extension UpdateProfileVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtFirstName){
            txtFirstName.resignFirstResponder()
            txtLastName.becomeFirstResponder()
            
        }
        else if (textField == txtLastName){
            txtLastName.resignFirstResponder()
            txtNumber.becomeFirstResponder()
            
        }
        else if (textField == txtNumber){
            txtNumber.resignFirstResponder()
            
        }
        
        
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtFirstName {
            firstView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            firstView.layer.borderWidth = 1
        }
        else if textField == txtLastName {
            lastView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            lastView.layer.borderWidth = 1
        }
        else if textField == txtNumber {
            numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            numberView.layer.borderWidth = 1
        }
        
       
      
    }
}

