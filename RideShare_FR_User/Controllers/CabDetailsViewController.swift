//
//  CabDetailsViewController.swift
//  RideShare_FR_User
//
//  Created by Aditya Gupta on 05/08/22.
//

import UIKit
import Alamofire
import SwiftyJSON


class CabDetailsViewController: UIViewController {
    @IBOutlet weak var _view: UIView!
    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var carImg: UIImageView!
    @IBOutlet weak var carNameLbl: UILabel!
    @IBOutlet weak var plateLbl: UILabel!
    @IBOutlet weak var otpLbl: UILabel!
    
    var objResponse : Response?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self._view.layer.cornerRadius = 12
        self._view.clipsToBounds = true
        // Do any additional setup after loading the view.
        self.plateLbl.text = objResponse?.driverInfo?.plate_number
        self.carNameLbl.text = objResponse?.driverInfo?.vehicle_subcategory_name
        self.driverNameLbl.text = objResponse?.driverInfo?.name
        if let otp = objResponse?.otp {
            self.otpLbl.text = "\(otp)"
        }
        carImg.sd_setImage(with: URL.init(string:  objResponse?.driverInfo!.vehicle_subcategory_picture ?? "" )) { (image, error, cache, urls) in
           if (error != nil) {
                self.carImg.image = UIImage(named: "blue_car")//blue_car
            } else {
                self.carImg.image = image
            }
        }
        driverImg.sd_setImage(with: URL.init(string:  objResponse?.driverInfo!.profile_pic ?? "" )) { (image, error, cache, urls) in
            if (error != nil) {
                self.driverImg.image = UIImage(named: "provider_img")
            } else {
                self.driverImg.image = image
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
       // self.verif
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
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "tel://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    @available(iOS 13.0, *)
    func cancelBooking() -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
      
       
        dicParam["orderId"] = objResponse?.orderId

        AppServices.shared.bookingCancelOrder(param: dicParam, success: { (data) in

            debugPrint("cancelOrderBooking:-\(data!)")
            
            self.view.removeFromSuperview()
//            let dataObj = data as! [String : Any]
//
//            self.showOkAlertWithHandler(dataObj["message"] as! String) {
//                self.navigationController?.popViewController(animated: true)
//            }


        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    @IBAction func callActionBtn(_ sender: Any) {
        let phNUmber = objResponse?.driverInfo?.mobile_number ?? "0000"
      //  let phNUmber =   "\(objResponse?.driverInfo?.country_code ?? "") - \(objResponse?.driverInfo?.mobile_number)"
       callNumber(phoneNumber: phNUmber)

    }
    
    @IBAction func msgBtn(_ sender: Any) {
    }
    
    @available(iOS 13.0, *)
    @IBAction func cancelBtn(_ sender: Any) {
        self.view.removeFromSuperview()
      //  cancelBooking()

    }
}
