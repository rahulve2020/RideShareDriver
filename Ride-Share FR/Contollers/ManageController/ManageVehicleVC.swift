//
//  ManageVehicleVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/06/22.
//

import UIKit
@available(iOS 13.0, *)
class ManageVehicleVC: UIViewController {
    @IBOutlet weak var compantNameLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var plateNoLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var modelNameLbl: UILabel!
    @IBOutlet weak var subCategoryLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var vV: UIView!
    
    var profileModel : ProfileModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        getProfile()
        vV.shadow()
//        setvalue()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
     //   setvalue()
        getProfile()
    }

//    func setvalue(){
//
//        self.compantNameLbl.text = DSUserPrefrence.company_name
//        self.plateNoLbl.text = DSUserPrefrence.plate_number
//       self.colorLbl.text = DSUserPrefrence.vehicle_color
//        self.modelNameLbl.text = DSUserPrefrence.model_of_vehicle
//
//
//    }
    
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
        self.compantNameLbl.text = self.profileModel?.company_name
        self.modelNameLbl.text = self.profileModel?.model_of_vehicle
        self.plateNoLbl.text = self.profileModel?.plate_number
        self.colorLbl.text = self.profileModel?.vehicle_color
        self.categoryLbl.text = self.profileModel?.vehicleCategoryName
        self.subCategoryLbl.text = self.profileModel?.vehicleSubCategoryName
      //  self.numberLbl.text = self.userProfile.mobile_number

}
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdateVehicleVC") as! UpdateVehicleVC
        vc.profileModel = self.profileModel
       self.navigationController?.pushViewController(vc, animated: true)
    }
}
