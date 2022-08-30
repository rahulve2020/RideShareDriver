//
//  RatingVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 30/06/22.
//

import UIKit

@available(iOS 13.0, *)
class RatingVC: SidePanelBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vV: UIView!
    
    var ratingListModel = [RatingListModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        ratingAndCommentrList()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    


    func ratingAndCommentrList() -> Void {
        
    AppServices.shared.getRatingAndCommentList(success: { (data) in
            print("getFaqDataFromServer\(data!)")
//            self.ratingListModel.removeAll()
//            let dataObj = data as! [String : Any]
//        let dataArray = dataObj["data"] as? [[String : Any]]
//
//            for item in dataArray! {
//                let modelObj = RatingListModel.init(data: item)
//                self.ratingListModel.append(modelObj)
//
//            }
        let datDict = data as? [String : Any]
        if datDict?["data"] is [[String : Any]] {
            let dataArray = datDict?["data"] as? [[String : Any]]
            
            for item in dataArray! {
                let modelObj = RatingListModel.init(data: item)
                self.ratingListModel.append(modelObj)
                
            }
            
        }
            
            self.tableView.reloadData()
            
            
    }, failure: {errorMsg in
        self.showOkAlert(errorMsg)
    })
        
    }
    
}

@available(iOS 13.0, *)
extension RatingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    //return 4
        return ratingListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingViewCell") as! RatingViewCell
        cell.selectionStyle = .none
        cell.info = self.ratingListModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
        
        
    }
}
