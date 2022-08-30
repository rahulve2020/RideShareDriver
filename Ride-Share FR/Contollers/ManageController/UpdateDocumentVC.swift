//
//  UpdateDocumentVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/06/22.
//

import UIKit
@available(iOS 13.0, *)
class UpdateDocumentVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var statusLicenceLbl1: UILabel!
    @IBOutlet weak var statusLicenseLbl2: UILabel!
    
    @IBOutlet weak var statusInsuranceLbl1: UILabel!
    @IBOutlet weak var statusInsuranceLbl2: UILabel!
    
    @IBOutlet weak var statusCredentaislLbl1: UILabel!
    @IBOutlet weak var statusCredentaislLbl2: UILabel!
    
    @IBOutlet weak var statusQualificationLbl1: UILabel!
    @IBOutlet weak var statusQualificationLbl2: UILabel!
    
    @IBOutlet weak var licenceImg: UIImageView!
    @IBOutlet weak var insuranceImg: UIImageView!
    @IBOutlet weak var credentailsImg: UIImageView!
    @IBOutlet weak var qualificationImg: UIImageView!
    
    var isProfilePicUpload:Bool? = false
    var selectedButton : Int?
    var profileModel : ProfileModel?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.statusLicenseLbl2.isHidden = true
        self.statusInsuranceLbl2.isHidden = true
        self.statusCredentaislLbl2.isHidden = true
        self.statusQualificationLbl2.isHidden = true
        // Do any additional setup after loading the view.
        getProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   setvalue()
        getProfile()
    }

    func getProfile() -> Void {
        AppServices.shared.getProfileDetails(success: { (data) in

            print("datadatadatadata",data)

            let dataObj = data as! [String : Any]
          //  DSUserPrefrence.Token = dataObj["token"] as? String ?? ""
            let dataArray = dataObj["data"] as? [String : Any]
            self.profileModel = ProfileModel.init(data: dataArray!)
      //      self.profileModel?.append(modelObj)

        //    debugPrint("details jobs array",self.profileModel?.count)
            self.loadData()

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
        
    }

    func loadData () {
        self.statusLicenceLbl1.text = self.profileModel?.driving_licence_status
        self.statusInsuranceLbl1.text = self.profileModel?.vehicle_insurance_status
        self.statusCredentaislLbl1.text = self.profileModel?.credential_status
        self.statusQualificationLbl1.text = self.profileModel?.qualification_status
//        licenceImg.sd_setImage(with: URL.init(string: (profileModel?.driving_licence) ?? "" )) { (image, error, cache, urls) in
//                    if (error != nil) {
//                       // self.licenceImg.image = UIImage(named: "")
//                        self.licenceImg.image = image
//                    } else {
//                      //  self.licenceImg.image = image
//                        self.licenceImg.image = UIImage(named: "")
//                    }
//                }
        if let urlImage = URL(string: profileModel?.driving_licence ?? "") {
            licenceImg.sd_setImage(with: urlImage, completed: nil)
        }
        if let urlImage = URL(string: profileModel?.vehicle_insurance ?? "") {
            insuranceImg.sd_setImage(with: urlImage, completed: nil)
        }
        if let urlImage = URL(string: profileModel?.credential ?? "") {
            credentailsImg.sd_setImage(with: urlImage, completed: nil)
        }
        if let urlImage = URL(string: profileModel?.qualification ?? "") {
            qualificationImg.sd_setImage(with: urlImage, completed: nil)
        }
      //  self.numberLbl.text = self.userProfile.mobile_number

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
            if selectedButton == 0 {
                self.licenceImg.image = image
                
                
            } else if selectedButton == 1 {
                self.insuranceImg.image = image
               
                
            } else if selectedButton == 2 {
                self.credentailsImg.image = image
                
                
            } else if selectedButton == 3 {
                self.qualificationImg.image = image
                
            }
           // self.licenceImg.image = image
            

        }
        picker.dismiss(animated: true, completion: nil)
        uploadPic()
    }
    
    @IBAction func updateLicenceBtn(_ sender: Any) {
        selectedButton = 0
        self.openCameraAndGallery()
    }
    @IBAction func updateInsuranceBtn(_ sender: Any) {
        selectedButton = 1
        self.openCameraAndGallery()

    }
    @IBAction func updateCredentailsBtn(_ sender: Any) {
        selectedButton = 2
        self.openCameraAndGallery()
       
    }
    @IBAction func updateQualificationBtn(_ sender: Any) {
        selectedButton = 3
        self.openCameraAndGallery()
       
    }
    
    func getUpdateDocument() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["driving_licence"] = ""//txtNewPassword.text
        dicParam["vehicle_insurance"] = ""
        dicParam["credential"] = ""
        dicParam["qualification"] = ""

        AppServices.shared.updateDocument(param: dicParam, success: { (data) in

            debugPrint("updateProfile:-\(data!)")
            let dictdata = data as! [String : Any]
            let alert = UIAlertController(title: "", message: (data as? Dictionary<String,Any>)? ["message"] as? String, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                action in
                
                self.navigationController?.popViewController(animated: true)
                
            }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    func uploadPic()-> Void{
        var imgDataArray = [Data]()
        var imgDataArray1 = [Data]()
        var imgDataArray2 = [Data]()
        var imgDataArray3 = [Data]()
        if selectedButton == 0 {
           // var imgDataArray = [Data]()
            if let imgData = (licenceImg.image)!.pngData() ??
                (licenceImg.image)!.pngData(){
                imgDataArray = [imgData]
            }
        } else if selectedButton == 1 {
            if let imgData = (insuranceImg.image)!.pngData() ??
                (insuranceImg.image)!.pngData(){
                imgDataArray1 = [imgData]
            }
        } else if selectedButton == 2 {
            if let imgData = (credentailsImg.image)!.pngData() ??
                (credentailsImg.image)!.pngData(){
                imgDataArray2 = [imgData]
            }
        }else if selectedButton == 3 {
            if let imgData = (qualificationImg.image)!.pngData() ??
                (qualificationImg.image)!.pngData(){
                imgDataArray3 = [imgData]
            }
        }
//        var imgDataArray1 = [Data]()
//        if let imgData = (insuranceImg.image)!.pngData() ??
//            (insuranceImg.image)!.pngData(){
//            imgDataArray1 = [imgData]
//        }
//        var imgDataArray2 = [Data]()
//        if let imgData = (credentailsImg.image)!.pngData() ??
//            (credentailsImg.image)!.pngData(){
//            imgDataArray2 = [imgData]
//        }
//        var imgDataArray3 = [Data]()
//        if let imgData = (qualificationImg.image)!.pngData() ??
//            (qualificationImg.image)!.pngData(){
//            imgDataArray3 = [imgData]
//        }
        var dicParam : Dictionary<String,Any> = Dictionary()
        //dicParam["user_id"] = DSUserPrefrence.user_ID
        dicParam["email"] = DSUserPrefrence.email_address

                AppServices.shared.updateDriverDocumentImage( param: dicParam, imageArray: imgDataArray,imageArray1: imgDataArray1,imageArray2: imgDataArray2,imageArray3: imgDataArray3, success: { (data) in
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "", message: (data as? Dictionary<String,Any>)? ["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                        action in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)
                }
            }, failure: {errorMsg in
                self.showOkAlert(errorMsg)
            })
//        }else {
//            //self.showOkAlert("Please add image")
//        }
    }
    
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func updateBtn(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SaveManageDocumentVC") as! SaveManageDocumentVC
//       self.navigationController?.pushViewController(vc, animated: true)
//        
//    }
    @IBAction func continueBtn(_ sender: Any) {
//       // getUpdateDocument()
//        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountDetailsVC") as! AccountDetailsVC
//       // self.navigationController?.pushViewController(vc, animated: true)
//        if   isProfilePicUpload == true{
//            self.uploadPic()
//
//        }
//        else{
//            getUpdateDocument()
//        }
    }
}

