//
//  DriverDetailsVC.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 15/07/22.
//

import UIKit

@available(iOS 13.0, *)
class DriverDetailsVC: UIViewController {

   
    @IBOutlet weak var _view: UIView!
    @IBOutlet weak var msgView: UITextView!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var gifView: UIView!
    @IBOutlet weak var txtMedicalCondition: UITextField!
    
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var medicalView: UIView!
    @IBOutlet weak var txtView: UIView!
    
    var driverListModel = [DriverListModel]()
    
    var pickUpLat : Double?
    var pickUpLong : Double?
    var dropLat : Double?
    var dropLong : Double?
    
    var vehicleId : String?
    var totalTime : Int?
    var totalCharge : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        //getRideList()
        load()
        gifView.isHidden = true
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self._view.layer.cornerRadius = 12
        self._view.clipsToBounds = true
    //   self.gifView.layer.cornerRadius = 12
    //    self.gifView.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    func load() {
        txtAge.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        txtMedicalCondition.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
        txtView.layer.borderColor = #colorLiteral(red: 0.7482101321, green: 0.7533286214, blue: 0.7227731347, alpha: 1)
     
        ageView.layer.borderWidth = 1
        medicalView.layer.borderWidth = 1
        txtView.layer.borderWidth = 1
     
    }

    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }

    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;

        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.view.removeFromSuperview()
        
    }
    
    
    
    

    func getRideList(){
        var dicParam : Dictionary<String,Any> = Dictionary()
    
        dicParam["pickup_longitude"] = self.pickUpLong
        dicParam["pickup_latitude"] = self.pickUpLat
        dicParam["vehicle_subCategoy"] = self.vehicleId
        dicParam["drop_latitude"] = self.dropLat
        dicParam["drop_longitude"] = self.dropLong
        dicParam["userAge"] = self.txtAge.text //"32"
        dicParam["medicalCondition"] = self.txtMedicalCondition.text //"good condition"
        dicParam["specialNote"] = self.msgView.text  //"Please come at my place as soon as possible"
        dicParam["total_Charge"] = self.totalCharge
        dicParam["total_time"] = self.totalTime
        
        AppServices.shared.getDriverListing(param: dicParam, success: { [self] (data) in
            
            
            print("datadatadata:-",data)
            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? NSArray
            
        
            
            if dataArray?.count == 0 {
                let alert = UIAlertController(title: "", message: (data as? Dictionary<String,Any>)? ["message"] as? String, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) {
                    action in
                }
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
            }
            else{
              //  self.view.removeFromSuperview()
                let jeremyGif = UIImage.gifImageWithName("search")
                    let imageView = UIImageView(image: jeremyGif)
               // imageView.frame = CGRect(x: 0.0, y: 200.0, width: self.gifView.frame.size.width, height: self.gifView.frame.size.height)
                imageView.frame = CGRect(x: 0.0, y: 375.0, width: self.view.frame.size.width, height: 250)
                
                view.addSubview(imageView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                    print("Async after 2 seconds")
                    view.removeFromSuperview()
                }

            }
            
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
       
        }
    
   @objc func runCode() {
        print("Do whatever here")
    self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        _view.isHidden = true
//        gifView.isHidden = true
        getRideList()
        
    }
}




@available(iOS 13.0, *)
extension DriverDetailsVC : UITextFieldDelegate, UITextViewDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == txtAge){
            txtAge.resignFirstResponder()
            txtMedicalCondition.becomeFirstResponder()
            
        }
        else if (textField == txtMedicalCondition){
            txtMedicalCondition.resignFirstResponder()
            
        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
  
        if textField == txtAge {
            ageView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            ageView.layer.borderWidth = 1
        }
        else if textField == txtMedicalCondition {
            medicalView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            medicalView.layer.borderWidth = 1
        }
       
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == msgView {
            txtView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
            txtView.layer.borderWidth = 1
        }
       
    }
    
}
