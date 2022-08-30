//
//  OwnerMenuView.swift
//  Banquet Gem
//
//  Created by Priya Rastogi on 02/03/22.
//

import UIKit
import SDWebImage

struct arrOwnerMenu {
    var name:String
    var icon:String
    var isSelected = false
    
    init(name:String, icon:String, isSelected:Bool) {
        self.name = name
        self.icon = icon
        self.isSelected = isSelected
    }
}

var OwnerContactIdNew = String()

class OwnerMenuView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate  {

    
    @IBOutlet weak var lblName: UILabel!
   
    @IBOutlet weak var leftConst: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var viewWidth: NSLayoutConstraint!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var btnforward: UIButton!
    
    var arrayOwnerMenu = [arrOwnerMenu]()
   
    
    var OwnerDelegate:MoveToOwnerPreviousViewDelegate?
    var newOwnerDelegate: MyOwnerViewDelegate?
    
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
        OwnerDelegate?.getTapOnHeaderClick()
    }
    
    @IBAction func btnforwardTap(_ sender: UIButton) {
        newOwnerDelegate?.didTapButton()
    }
    
    override func didMoveToSuperview() {
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Home", icon: "home_on_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "My Banquate Hall", icon: "home_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Manage Enquiry", icon: "booking_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Help and Support", icon: "help_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Share", icon: "share_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "About", icon: "about_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Term and Condition", icon: "term_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Change Password", icon: "lock_off_ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "rate Us", icon: "star_2_off)ic", isSelected: false))
        arrayOwnerMenu.append(arrOwnerMenu.init(name: "Log Out", icon: "logout_off_ic", isSelected: true))
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

        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOwnerMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerMenuCell", for: indexPath) as! OwnerMenuCell
        cell.populateData(data: arrayOwnerMenu[indexPath.row])
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
        delegate?.MoveToOwnerPreviousViewDelegate(selected: indexPath.row)
    }
}



protocol MoveToOwnerPreviousViewDelegate{
    func MoveToOwnerPreviousViewDelegate(selected:Int)
    func getTapOnHeaderClick()
}

protocol MyOwnerViewDelegate {
    func didTapButton()
}

