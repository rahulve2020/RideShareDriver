//
//  ConfirmRideVC.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 15/07/22.
//

import UIKit
import SOPullUpView

protocol UpdateView {
    func updatePopUp(vehicleId: String?, totalCharge: String?, totalTime: Int?, pickupLat: Double?, pickupLong: Double, dropLat: Double, dropLong: Double  )
}


        

@available(iOS 13.0, *)
class ConfirmRideVC: UIViewController, SOPullUpViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var handleArea: UIView!
    
    var delegate : UpdateView?
   // var driverListModel = [DriverListModel]()
    var vehicleCategoryList = [VehicleCategoryList]()
  //  var vehicleCategoryList : VehicleCategoryList?
    
    var pickUpLat : Double?
    var pickUpLong : Double?
    var dropLat : Double?
    var dropLong : Double?
    let sectionTittle : [String] = ["Economy","Poplur","fav"]
    
    var pullUpControl: SOPullUpControl? {
         didSet {
             pullUpControl?.delegate = self
         }
     }
    override func viewDidLoad() {
        super.viewDidLoad()

        getVehicleList()
        
        // Do any additional setup after loading the view.
    }
    
    func getVehicleList(){
        var dicParam : Dictionary<String,Any> = Dictionary()

        dicParam["pickup_longitude"] = self.pickUpLong
        dicParam["pickup_latitude"] = self.pickUpLat
        dicParam["drop_latitude"] = self.dropLat
        dicParam["drop_longitude"] = self.dropLong

        AppServices.shared.getVehicleCategory(param: dicParam, success: { (data) in
            print("datadatadata:-",data)
            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? NSArray

//            for i in dataArray {
//                print("dataArray")
//            }
            for item in dataArray! {
                let modelObj = VehicleCategoryList.init(data: (item as? [String: Any])!)
                self.vehicleCategoryList.append(modelObj)

            }
            print("self.Category:-\(self.vehicleCategoryList.count)")
            self.tableView.reloadData()

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }

   


    func pullUpViewStatus(_ sender: UIViewController, didChangeTo status: PullUpStatus) {
        switch status {
                    case .expanded:
                        UIView.animate(withDuration: 0.6)  { [weak self] in
                          //  self?.titleLbl.alpha = 0
                        }
                    case .collapsed:
                        UIView.animate(withDuration: 0.6) { [weak self] in
                       //     self?.titleLbl.alpha = 1
                        }
                    }
         }

    func pullUpHandleArea(_ sender: UIViewController) -> UIView {
          return handleArea
      }
}

@available(iOS 13.0, *)
extension ConfirmRideVC: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
            return (vehicleCategoryList[section].subcategoryInfo.count)

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

      return   vehicleCategoryList[section].category_name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return self.vehicleCategoryList.count

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.text = vehicleCategoryList[section].category_name
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  return tableView.dequeueReusableCell(withIdentifier: "ConfirmRideViewCell", for: indexPath)
        self.tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmRideViewCell") as! ConfirmRideViewCell
        cell.selectionStyle = .none
        cell.taxiName.text = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].vehicle_subcategory_name
        cell.distanceLbl.text = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].Description
        cell.priceLbl.text = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalCharge
        cell.seatAvailiblityLbl.text = String(vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].vehicle_seat_availability ?? 0)
        
        if let urlImage = URL(string: vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].vehicle_subcategory_picture ?? "") {
        cell.taxiImg.sd_setImage(with: urlImage, completed: nil)
            }

//        let modelObj = vehicleCategoryList[indexPath.row].subcategoryInfo
//        if indexPath.section == 0 {
//
//            cell.taxiName.text = modelObj[indexPath.row].vehicle_subcategory_name
////            cell.seatAvailiblityLbl.text = "\(modelObj.subcategoryInfo.first?.vehicle_seat_availability)"
////            cell.priceLbl.text = modelObj.subcategoryInfo.first?.totalCharge
////            cell.distanceLbl.text = modelObj.subcategoryInfo.first?.Description
////            if let urlImage = URL(string: modelObj.subcategoryInfo.first?.vehicle_subcategory_picture ?? "") {
////                cell.taxiImg.sd_setImage(with: urlImage, completed: nil)
////                        }
//        } else if indexPath.section == 1 {
//            cell.taxiName.text = modelObj[indexPath.row].vehicle_subcategory_name
//
//        } else if indexPath.section == 2 {
//            cell.taxiName.text = modelObj[indexPath.row].vehicle_subcategory_name
//        }
     //   let modelObj = vehicleCategoryList[indexPath.row]
   //     cell.taxiName.text = modelObj.subcategoryInfo.vehicle_subcategory_name
//        cell.taxiName.text = modelObj.subcategoryInfo.first?.vehicle_subcategory_name
//        cell.seatAvailiblityLbl.text = "\(modelObj.subcategoryInfo.first?.vehicle_seat_availability)"
//        cell.priceLbl.text = modelObj.subcategoryInfo.first?.totalCharge
//        cell.distanceLbl.text = modelObj.subcategoryInfo.first?.Description
//        if let urlImage = URL(string: modelObj.subcategoryInfo.first?.vehicle_subcategory_picture ?? "") {
//            cell.taxiImg.sd_setImage(with: urlImage, completed: nil)
//                    }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DriverDetailsVC") as! DriverDetailsVC
//        vc.vehicleId = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row]._id
//        vc.totalCharge = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalCharge
//        vc.totalTime = Int(vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalTime ?? 0)
//        self.navigationController?.pushViewController(vc, animated: true)
        pullUpControl?.collapsed()
        self.delegate?.updatePopUp(vehicleId: vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row]._id, totalCharge: vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalCharge, totalTime: Int(vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalTime ?? 0), pickupLat: pickUpLat!, pickupLong: pickUpLong!, dropLat: dropLat!, dropLong: dropLong!)
//        let vc = storyboardMain().instantiateViewController(withIdentifier: "DriverDetailsVC") as! DriverDetailsVC
//
//        vc.vehicleId = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row]._id
//        vc.totalCharge = vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalCharge
//        vc.totalTime = Int(vehicleCategoryList[indexPath.section].subcategoryInfo[indexPath.row].totalTime ?? 0)
//        vc.pickUpLat = pickUpLat
//        vc.pickUpLong = pickUpLong
//        vc.dropLat = dropLat
//        vc.dropLong = dropLong
//      //  ConfirmRideVC.isHidden = true
//    //    handleArea.isHidden = true
//        //tableView.isHidden = true
//     //   ConfirmRideVC.isHidden = true
//    //    pullUpControl?.collapsed()
//        self.addChild(vc)
//        vc.view.frame = self.view.frame
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
        
    }
    
    
}
