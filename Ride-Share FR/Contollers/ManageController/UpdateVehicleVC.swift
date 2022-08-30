//
//  UpdateVehicleVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 28/06/22.
//

import UIKit
import DropDown
@available(iOS 13.0, *)
class UpdateVehicleVC: UIViewController {

   
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtModelName: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var txtColor: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    
    
    @IBOutlet weak var companyView: UIView!
    @IBOutlet weak var modelView: UIView!
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var subCategoryView: UIView!
    @IBOutlet weak var vV: UIView!
    
    var vehicleDetailsModel : VehicleDetailsModel?
    var categoryList = [VehicleCategoryModel]()
    var categorySubList = [VehicleSubCategoryModel]()
    
    
    
    var selectedCategoryList : VehicleCategoryModel?
    var selectedCategoryId : String?
    var selectedSubCategoryId : String?
    var selectedSubCategoryList : VehicleSubCategoryModel?
    var profileModel : ProfileModel?
    
    let dropDown = DropDown()
    var selectedId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        load()
        loadData ()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getCategoryDetails()
    }

    func load() {
        
        companyView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        numberView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        colorView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        modelView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        categoryView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
        subCategoryView.layer.borderColor = #colorLiteral(red: 0.06241328269, green: 0.1183073893, blue: 0.1983669996, alpha: 1)
       
        companyView.layer.borderWidth = 1
        numberView.layer.borderWidth = 1
        colorView.layer.borderWidth = 1
        modelView.layer.borderWidth = 1
        categoryView.layer.borderWidth = 1
        subCategoryView.layer.borderWidth = 1
     
    }
    func loadData () {
        self.txtCompanyName.text = self.profileModel?.company_name
        self.txtModelName.text = self.profileModel?.model_of_vehicle
        self.txtNumber.text = self.profileModel?.plate_number
        self.txtColor.text = self.profileModel?.vehicle_color
       // self.txtCategory.text = self.profileModel?.vehicleCategoryName
      //  self.txtSubCategory.text = self.profileModel?.vehicleSubCategoryName
      //  self.numberLbl.text = self.userProfile.mobile_number

}
    func setDropDown(){
        var categoryList = [String]()
        for i in self.categoryList {
            categoryList.append(i.category_name!)
            
        }
        dropDown.anchorView = txtCategory
        dropDown.dataSource = categoryList //["Economy","Sedan"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.selectedId = index + 1
            self.selectedCategoryList = self.categoryList[index]
            self.selectedCategoryId = self.selectedCategoryList?._id
            print(selectedCategoryId)
            getSubCategoryleDetails(id: self.selectedCategoryId ?? "")
            self.txtCategory.text = item
            self.txtSubCategory.text = ""
            
            
        }
        dropDown.show()
    }
    
    
    func setDropDown1(){
        var categorySubList = [String]()
        categorySubList.removeAll()
        for i in self.categorySubList {
            categorySubList.append(i.vehicle_subcategory_name!)
        }
        dropDown.anchorView = txtSubCategory
        dropDown.dataSource = categorySubList//["Economy","Sedan"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.selectedId = index + 1
            self.selectedSubCategoryList = self.categorySubList[index]
            self.selectedSubCategoryId = self.selectedSubCategoryList?._id
            print(selectedSubCategoryId)
            self.txtSubCategory.text = item
            
            
            
        }
        dropDown.show()
    }
    func getCategoryDetails() -> Void {
      
        
        AppServices.shared.getCategoryList(success: { [self] (data) in
        
            print("datadatadatadata",data)

            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? [[String : Any]]

            for item in dataArray! {
                let modelObj = VehicleCategoryModel.init(data: item)
              
                self.categoryList.append(modelObj)

            }
            print("self.Category:-\(self.categoryList.count)")
            //   getSubCategoryleDetails()
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    func getSubCategoryleDetails(id: String){
        var dicParam : Dictionary<String,Any> = Dictionary()
        //let obj = categoryList[0]._id
        dicParam["vehicle_category"] = id
    
        AppServices.shared.getSubCategoryList(param: dicParam, success: { (data) in
            self.categorySubList.removeAll()
            print("datadatadata:-",data)

            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? [[String : Any]]

            for item in dataArray! {
                let modelObj = VehicleSubCategoryModel.init(data: item)
              
                self.categorySubList.append(modelObj)

            }
    
        }, failure: {errorMsg in })
    }
    
    func getVehicleDetails(){
        var dicParam : Dictionary<String,Any> = Dictionary()
         // let obj = vehicleDetailsModel
      //  dicParam["email"] = self.email//txtVehicleNmae.text!
        dicParam["company_name"] = txtCompanyName.text!
        dicParam["model_of_vehicle"] = txtModelName.text!
        dicParam["vehicle_color"] = txtColor.text!
        dicParam["plate_number"] = txtNumber.text!
        dicParam["vehicle_category"] = selectedCategoryId
        dicParam["vehicle_subCategoy"] = selectedSubCategoryId
    

        AppServices.shared.driverUpdateDetails(param: dicParam, success: { (data) in
            
            print("datadatadata:-",data)
            let dictdata = data as! [String : Any]
            let dataObj = dictdata["data"] as! [String : Any]
            DSUserPrefrence.vehicle_category = dataObj["vehicle_category"] as! String
            DSUserPrefrence.vehicle_subCategoy = dataObj["vehicle_subCategoy"] as! String
           // DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
           // }

    
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
    
    @IBAction func categoryBtn(_ sender: Any) {
        setDropDown()
    }
    @IBAction func subCategoryBtn(_ sender: Any) {
        setDropDown1()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        getVehicleDetails()
    }
}
@available(iOS 13.0, *)

extension UpdateVehicleVC : UITextFieldDelegate{
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       if (textField == txtCompanyName){
            txtCompanyName.resignFirstResponder()
            txtModelName.becomeFirstResponder()
            
        }
        else if (textField == txtModelName){
            txtModelName.resignFirstResponder()
            txtNumber.becomeFirstResponder()
            
        }
        else if (textField == txtNumber){
            txtNumber.resignFirstResponder()
            txtColor.becomeFirstResponder()
            
        }
        else if (textField == txtColor){
            txtColor.resignFirstResponder()
            txtCategory.becomeFirstResponder()
        }
        else if (textField == txtCategory){
            txtCategory.resignFirstResponder()
            txtSubCategory.becomeFirstResponder()
        }
        else if (textField == txtSubCategory){
            txtSubCategory.resignFirstResponder()
            
        }
        return true
    }
}
