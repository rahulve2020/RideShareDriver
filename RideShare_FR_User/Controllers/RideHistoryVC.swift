//
//  RideHistoryVC.swift
//  Ride-Share FR
//
//  Created by Priya Rastogi on 04/07/22.
//

import UIKit
import FSCalendar
import DropDown

@available(iOS 13.0, *)
class RideHistoryVC: SidePanelBaseViewController, FSCalendarDataSource, FSCalendarDelegate  {

    @IBOutlet weak var vV: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calenderBtn: UIButton!
    
    let dropDown = DropDown()
    var selectedId : Int = 0
    var selectDate : [String]?
    
    var userHistoryDetails = [UserHistoryDetails]()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
//    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
//        [unowned self] in
//        let panGesture = UIPanGestureRecognizer(target: self.calenderView, action: #selector(self.calenderView.handleScopeGesture(_:)))
//        panGesture.delegate = self
//        panGesture.minimumNumberOfTouches = 1
//        panGesture.maximumNumberOfTouches = 2
//        return panGesture
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        vV.shadow()
        historyList()
        tableView.delegate = self
        tableView.dataSource = self
        
        if UIDevice.current.model.hasPrefix("iPhone") {
            self.calendarHeightConstraint.constant = 150
            
        }
        
        self.calenderView.select(Date())
        self.calenderView.appearance.headerTitleColor     = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.calenderView.appearance.weekdayTextColor     = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    //    self.calenderView.appearance.eventDefaultColor    = Colors.NavTitleColor
        self.calenderView.appearance.selectionColor       = .systemGreen
       // self.calenderView.appearance.titleSelectionColor  = .na
      //  self.calenderView.appearance.todayColor           = #colorLiteral(red: 0.2789987922, green: 0.8928467631, blue: 0.4446960688, alpha: 1)
        self.calenderView.appearance.todaySelectionColor  = #colorLiteral(red: 0.1642515659, green: 0.2854531109, blue: 0.5348326564, alpha: 1)
        self.calenderView.allowsMultipleSelection = false
      
        self.calenderView.scope = .week
        
        // For UITest
        self.calenderView.accessibilityIdentifier = "calendar"
        // Do any additional setup after loading the view.
    }
    
    
    func setDropDown(){
        
      //  dropDown.anchorView = txtAvailableHallFor
        dropDown.dataSource = ["Weekly","Monthly"]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.selectedId = index + 1
         //   self.txtAvailableHallFor.text = item
            
            
            
        }
        dropDown.show()
    }
    
    @IBAction func calenderTapped(_ sender: Any) {
        setDropDown()
    }
    
    func orderByDate(str : String) -> Void {
        var dicParam : Dictionary<String,Any> = Dictionary()
        dicParam["orderDate"] = str
    
        AppServices.shared.orderListByDate(param: dicParam, success: { (data) in

            debugPrint("changePassword:-\(data!)")
           // let dataObj = data as! [String : Any]
            self.selectDate?.removeAll()
            let datDict = data as? [String : Any]
            if datDict?["data"] is [[String : Any]] {
            let dataArray = datDict?["data"] as? [[String : Any]]
                self.userHistoryDetails.removeAll()
                for item in dataArray! {
                    let modelObj = UserHistoryDetails.init(data: item)
                    self.userHistoryDetails.append(modelObj)
                }
                
            }
            if self.userHistoryDetails.count == 0{
                let label = UILabel()
                label.frame = CGRect(x: 140, y: 200, width: 200, height: 50)
                label.text = "No data found"
                self.tableView.addSubview(label)
            }
             //   self.tableView.reloadData()
            
           // self.loadData()
            self.tableView.reloadData()
           

        }, failure: {errorMsg in
            self.showOkAlert(errorMsg)
        })
    }
//    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
//        if shouldBegin {
//            let velocity = self.scopeGesture.velocity(in: self.view)
//            switch self.calenderView.scope {
//            case .month:
//                return velocity.y < 0
//            case .week:
//                return velocity.y > 0
//            }
//        }
//        return shouldBegin
//    }
    
    func historyList() -> Void {
        
    AppServices.shared.orderListing(success: { (data) in
            print("getFaqDataFromServer\(data!)")

        let datDict = data as? [String : Any]
        if datDict?["data"] is [[String : Any]] {
            let dataArray = datDict?["data"] as? [[String : Any]]
            
            for item in dataArray! {
                let modelObj = UserHistoryDetails.init(data: item)
                self.userHistoryDetails.append(modelObj)
            }
        }
       // self.loadData()
            self.tableView.reloadData()
            
    }, failure: {errorMsg in
        self.showOkAlert(errorMsg)
    })
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        self.selectDate = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectDate)")
        orderByDate(str: selectDate![0])
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }

    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }

}


@available(iOS 13.0, *)
extension RideHistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if self.userHistoryDetails.count == 0{
//                self.tableView.setEmptyMessage("No data found")
//            } else {
//                self.tableView.reloadData()
//            }
//            return userHistoryDetails.count
    
        return userHistoryDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.separatorStyle = .none
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RideHistoryViewCell") as! RideHistoryViewCell
        cell.selectionStyle = .none
        cell.confirmLbl.text = self.userHistoryDetails[indexPath.row].order_status
        cell.info = self.userHistoryDetails[indexPath.row]
   
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
        
    }
}
