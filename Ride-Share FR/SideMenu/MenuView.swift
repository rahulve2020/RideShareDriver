//
//  MenuView.swift
//  Banquet Gem
//
//  Created by Imran on 01/02/22.
//

import UIKit
import SDWebImage

struct arrMenu {
    var name:String
    var icon:String
    var isSelected = false
    
    init(name:String, icon:String, isSelected:Bool) {
        self.name = name
        self.icon = icon
        self.isSelected = isSelected
    }
}

var ContactIdNew = String()


class MenuView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var lblName: UILabel!
   
    @IBOutlet weak var leftConst: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var btnforward: UIButton!
    
    var arrayMenu = [arrMenu]()
   
    
    var delegate:MoveToPreviousViewDelegate?
    var newDelegate: MyViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        DispatchQueue.main.async {
            
            //self.getContactNewElementFormFirebase()
            self.imgView.layer.borderWidth = 1
            self.imgView.layer.masksToBounds = false
            self.imgView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.imgView.layer.cornerRadius = self.imgView.frame.height/2
            self.imgView.clipsToBounds = true
            
            self.tblView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
            self.viewWidth.constant = 1.0
            self.tblView.dataSource = self
            self.tblView.delegate = self
            self.tblView.reloadData()
            self.tblView.separatorStyle = .none
            
            let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnView(_:)))
            tapGest.delegate = self
            self.addGestureRecognizer(tapGest)
           // self.leftConst.constant = -(self.frame.size.width-50)
            
        }
    }
    
   
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.getTapOnHeaderClick()
    }
    
    @IBAction func btnforwardTap(_ sender: UIButton) {
        newDelegate?.didTapButton()
    }
    @IBAction func logoutBtn(_ sender: Any) {
     //   let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
      //  self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didMoveToSuperview() {
        arrayMenu.append(arrMenu.init(name: "Home", icon: "home_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Wallet", icon: "wallet_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "History", icon: "history_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Setting", icon: "settings_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Notification", icon: "notification_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Change Password", icon: "change_password_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Rating ", icon: "rating_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Share", icon: "share_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "Contact Us", icon: "contact_us_ic", isSelected: false))
        arrayMenu.append(arrMenu.init(name: "About Us", icon: "about_us_ic", isSelected: false))
       // arrayMenu.append(arrMenu.init(name: "Log Out", icon: "logout_off_ic", isSelected: true))
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tblView) ?? false {
            return false
        }
        return true
    }
    
    func showMenu() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            UIView.animate(withDuration: 0.4, animations: {
                //self.leftConst.constant = 0
                self.layoutIfNeeded()
            }, completion: { (compeletion) in
            })
        }
    }
    
   
    func closeMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            //self.leftConst.constant = -(self.frame.size.width-50)
            self.layoutIfNeeded()
        }) { (complete) in
            self.close()
        }
    }
    
    @objc func didTapOnView(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.4, animations: {
           // self.leftConst.constant = -(self.frame.size.width-50)
            self.layoutIfNeeded()
        }) { (complete) in
            let point = sender.location(in: self)
            if !(self.tblView.frame.contains(point)) {
                self.close()
            }
        }
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        closeMenu()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.populateData(data: arrayMenu[indexPath.row])
        return cell
        
        
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0{
//            return 20
//        }
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeMenu()
        delegate?.moveToPreviousView(selected: indexPath.row)
    }
}



protocol MoveToPreviousViewDelegate{
    func moveToPreviousView(selected:Int)
    func getTapOnHeaderClick()
}

protocol MyViewDelegate {
    func didTapButton()
}

