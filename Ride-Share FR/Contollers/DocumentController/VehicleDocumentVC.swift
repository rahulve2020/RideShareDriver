//
//  VehicleDocumentVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 24/06/22.
//

import UIKit
@available(iOS 13.0, *)
class VehicleDocumentVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    var isProfilePicUpload1:Bool? = false
    var isProfilePicUpload2:Bool? = false
    var isProfilePicUpload3:Bool? = false
    var selectedButton : Int?
    
    var categoryId : String?
    var subCategoryId : String?
    
    lazy var email : String = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.statusLicenseLbl2.isHidden = true
        self.statusInsuranceLbl2.isHidden = true
        self.statusCredentaislLbl2.isHidden = true
        self.statusQualificationLbl2.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func getVehicleDetails(){
        var dicParam : Dictionary<String,Any> = Dictionary()
         // let obj = vehicleDetailsModel
//        dicParam["email"] = self.email//txtVehicleNmae.text!
//        dicParam["driving_licence"] = txtCompanyName.text!
//        dicParam["vehicle_insurance"] = txtModelName.text!
//        dicParam["credential"] = txtColor.text!
//        dicParam["qualification"] = txtNumber.text!


        AppServices.shared.getDriverDocument(param: dicParam, success: { (data) in
            
            print("datadatadata:-",data)
            let dictdata = data as! [String : Any]
            let dataObj = dictdata["data"] as! [String : Any]
            DSUserPrefrence.vehicle_category = dataObj["vehicle_category"] as! String
            DSUserPrefrence.vehicle_subCategoy = dataObj["vehicle_subCategoy"] as! String
            DispatchQueue.main.async {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "VehicleDocumentVC") as! VehicleDocumentVC
                self.navigationController?.pushViewController(vc, animated: true)
            }

    
        }, failure: {errorMsg in })
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
                //self.statusLicenseLbl2.isHidden = false
               // self.statusLicenceLbl1.isHidden = true
                
            } else if selectedButton == 1 {
                self.insuranceImg.image = image
               // self.statusInsuranceLbl2.isHidden = false
               // self.statusInsuranceLbl1.isHidden = true
                
            } else if selectedButton == 2 {
                self.credentailsImg.image = image
               // self.statusCredentaislLbl2.isHidden = false
               // self.statusCredentaislLbl1.isHidden = true
                
            } else if selectedButton == 3 {
                self.qualificationImg.image = image
               // self.statusQualificationLbl2.isHidden = false
               // self.statusQualificationLbl1.isHidden = true
            }
           // self.licenceImg.image = image
            

        }
        picker.dismiss(animated: true, completion: nil)
    }

    
    func uploadPic()-> Void{
        
            var imgDataArray = [Data]()
            if let imgData = (licenceImg.image)!.pngData() ?? 
                (licenceImg.image)!.pngData(){
                imgDataArray = [imgData]
            }
        var imgDataArray1 = [Data]()
        if let imgData = (insuranceImg.image)!.pngData() ??
            (insuranceImg.image)!.pngData(){
            imgDataArray1 = [imgData]
        }
        var imgDataArray2 = [Data]()
        if let imgData = (credentailsImg.image)!.pngData() ??
            (credentailsImg.image)!.pngData(){
            imgDataArray2 = [imgData]
        }
        var imgDataArray3 = [Data]()
        if let imgData = (qualificationImg.image)!.pngData() ??
            (qualificationImg.image)!.pngData(){
            imgDataArray3 = [imgData]
        }
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["email"] = email

        AppServices.shared.driverDocumentImage( param: dicParam, imageArray: imgDataArray,imageArray1: imgDataArray1,imageArray2: imgDataArray2,imageArray3: imgDataArray3, success: { (data) in
                DispatchQueue.main.async {
                    print("imageArrayimageArray:-",data!)
                    let dictdata = data as! [String : Any]
                    let dataObj = dictdata["data"] as! [String : Any]
                    DSUserPrefrence.profilePicture = dataObj["driving_licence"] as! String
                    DSUserPrefrence.profilePicture = dataObj["vehicle_insurance"] as! String
                    DSUserPrefrence.profilePicture = dataObj["credential"] as! String
                    DSUserPrefrence.profilePicture = dataObj["qualification"] as! String
                    
                    let alert = UIAlertController(title: "", message: (data as? Dictionary<String,Any>)? ["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                        action in
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                                alert.addAction(okAction)
                                self.present(alert, animated: true, completion: nil)

                }
            }, failure: {errorMsg in
                self.showOkAlert(errorMsg)
            })

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
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtn(_ sender: Any) {
        uploadPic()
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


//extension VehicleDocumentVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//}
