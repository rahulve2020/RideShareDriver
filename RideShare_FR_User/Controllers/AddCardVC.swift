//
//  AddCardVC.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 04/07/22.
//

import UIKit
import Stripe
import Alamofire


protocol CardListDelegate: class {

    func didSelectCreditCard(model: CardListModel?)
}
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class AddCardVC: UIViewController {

    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var cardListModel = [CardListModel]()
    
    var selectedIndex: Int?
    var isCameFromProfile = false
    weak var delegate: CardListDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        tableView.dataSource = self
        tableView.delegate = self
      
        getCardList()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
      //  getCardList()      
    }
    
    
    func getCardList(){
        var dicParam : Dictionary<String,Any> = Dictionary()
    
        let token = DSUserPrefrence.Token
        let headers: HTTPHeaders = ["x-auth": token ?? ""]
        self.cardListModel.removeAll()
        AppServices.shared.getUserCardList(success: { (data) in
            print("datadatadata:-",data)
            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? NSArray
            var arr = [CardListModel]()
//            for i in dataArray {
//                print("dataArray")
//            }
            for item in dataArray! {
                let modelObj = CardListModel.init(dict: (item as? [String: Any])!)
                self.cardListModel.append(modelObj)

            }
            
//            if arr.count > 0{
//                self.cardListModel = arr
//                self.tableView.isHidden = false
//                self.tableView.reloadData()
//            }else{
//
//               // Alert.showAlertWithTitle(msg: "No card added. Please add card.", controler: self)
//            }
            print("self.Category:-\(self.cardListModel.count)")
            self.tableView.reloadData()
            
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }

    func addNewCard(cardToken: String){
        var dicParam : Dictionary<String,Any> = Dictionary()
    
        dicParam["tokenId"] = cardToken
        let token = DSUserPrefrence.Token
        let headers:HTTPHeaders = ["Content-Type" : "application/json", "x-auth": token ?? ""]
        print("parameters: ",dicParam)
        print("header: ", headers)
        
        AppServices.shared.getAddCardDetails(param: dicParam, success: { (data) in
            print("datadatadata:-",data)
            let datDict = data as? [String : Any]
            let dataArray = datDict?["data"] as? NSArray
//            var arr = [CardListModel]()

//            for item in dataArray! {
//                let model = CardListModel(dict: (item as? [String: Any])!)
//                arr.append(model)
//            }
//
            self.getCardList()
        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
//    if self.currentService.count == 0{
//        self.tableView.setEmptyMessage("No data found")
//    } else {
//        self.tableView.restore()
//    }
//    return currentService.count
    func completePaymentProcessApi(_ stripeId: String, _ error: STPErrorBlock?) {
       //send stripe id with require other details to backend to complete the payment process
        if error != nil {
            print(stripeId)
        } else {
            displayAlert(title: "", message: "error")
        }
    }
    
    
    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
      DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true, completion: nil)
      }
    }


    
    @IBAction func backbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addCardBtn(_ sender: Any) {
      //  let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCardDetailsVC") as! AddCardDetailsVC
      // self.navigationController?.pushViewController(vc, animated: true)
        let addCardViewController = STPAddCardViewController()                                                //abhishek
        addCardViewController.delegate = self
        let navigationControler = UINavigationController(rootViewController: addCardViewController)
      //  self.navigationController?.pushViewController(addCardViewController, animated: true)
        self.present(navigationControler, animated: true, completion: nil)
    }
    
}

@available(iOS 13.0, *)
extension AddCardVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return cardListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCardViewCell") as! AddCardViewCell
        cell.selectionStyle = .none
        let model = cardListModel[indexPath.row]
        cell.cardName.text = "card ends with " + (model.cardDetails?.last4 ?? "")
        
        if  self.selectedIndex != nil && self.selectedIndex == indexPath.row{
            cell.selectionImageView.image = UIImage(named: "selected")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isCameFromProfile{                                                                  //abhishek
        self.selectedIndex = indexPath.row
        tableView.reloadData()
        delegate?.didSelectCreditCard(model: cardListModel[indexPath.row])
        self.navigationController?.popViewController(animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
        
        
    }
}


@available(iOS 13.0, *)
extension AddCardVC: STPAddCardViewControllerDelegate{
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        //navigationController?.popViewController(animated: true)
        self.dismiss(animated: false, completion: nil)
    }

     func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        print("card token",token)
        self.dismiss(animated: false, completion: nil)
        self.addNewCard(cardToken: token.tokenId)
    }

}

//extension AddCardVC: STPAddCardViewControllerDelegate {
//    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
//        //getting stripe id
//        completePaymentProcessApi(paymentMethod.stripeId, completion)
//        self.navigationController?.popViewController(animated: true)
//    }
//}

