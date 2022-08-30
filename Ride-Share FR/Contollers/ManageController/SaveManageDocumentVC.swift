//
//  SaveManageDocumentVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 29/06/22.
//

import UIKit
@available(iOS 13.0, *)
class SaveManageDocumentVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var arrQuestion = ["Please upload a picture of your valid driving license"," Please upload a picture of your insurance card. "," Please upload a picture of your credentails. "," Please upload a picture of your qualification. "]
    var imgDriving : UIImage? = nil
    var imgInsurance : UIImage? = nil
    var imgCredentails : UIImage? = nil
    var imgQualification : UIImage? = nil
    var arrImage = [UIImage?]()
    var isStatus = false
    var dictDriving : NSDictionary?
    var dictInsurance : NSDictionary?
    var dictCredentails : NSDictionary?
    var dictQualification : NSDictionary?
    var uploadDoc = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        if isStatus {
            imgDriving = urlToUIimage(strUrl: dictDriving?.value(forKey: "path") as? String)
            imgInsurance = urlToUIimage(strUrl: dictInsurance?.value(forKey: "path") as? String)
            imgCredentails = urlToUIimage(strUrl: dictCredentails?.value(forKey: "path") as? String)
            imgQualification = urlToUIimage(strUrl: dictQualification?.value(forKey: "path") as? String)
            arrImage = [imgDriving,imgInsurance,imgCredentails,imgQualification]
           // AnimatableReload.reload(tableView: self.tblDocuments, animationDirection: .down)
            //btnSkip.isHidden = true
        }
    }
    
    func urlToUIimage (strUrl: String?) -> UIImage?{
        if let _ = strUrl , strUrl != "" {
            let url = URL(string:strUrl!)
            if let data = try? Data(contentsOf: url!){
                let image: UIImage = UIImage(data: data)!
                return image
            }
        }else{
            return nil
        }
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBtn(_ sender: Any) {
//        if !isStatus {
//            if !uploadDoc {
//                uploadDocument()
//            }else{
//                alertMessase(message: "Please wait, your document verification in under progress", okAction: {
//                    self.moveToHome()
//                })
//            }
//        }else{
//            let statusDriving = dictDriving?.value(forKey: "status") as? Int
//            let statusInsurance = dictInsurance?.value(forKey: "status") as? Int
//            if statusDriving == 2 || statusInsurance == 2{
//                uploadDocument()
//            }else{
//                alertMessase(message: "Verification in under progress") {
//                     self.moveToHome()
//                }
//            }
//        }
    }
    
    
    
    
    
}
@available(iOS 13.0, *)
extension SaveManageDocumentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveMangeDocumentCell") as! SaveMangeDocumentCell
        cell.selectionStyle = .none
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
        
    }
}
