//
//  ConfirmRideLocationVC.swift
//  RideShare_FR_User
//
//  Created by Priya Rastogi on 15/07/22.
//

import UIKit
import MapKit
//import SideMenu
import GooglePlaces
import GoogleMaps
import CoreLocation
import SidebarOverlay
import SOPullUpView

@available(iOS 13.0, *)
class ConfirmRideLocationVC: SidePanelBaseViewController,SOPullUpViewDataSource {

    @IBOutlet weak var vwMap: GMSMapView!
    @IBOutlet weak var imgMarker: UIImageView!
    
    
    let pullUpController = SOPullUpControl()

    var bottomPadding: CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0.0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pullUpController.dataSource = self
        pullUpController.setupCard(from: view)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pullUpViewCollapsedViewHeight() -> CGFloat {
         return bottomPadding + 40
    }
    
    func pullUpViewController() -> UIViewController {
         guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? ConfirmRideVC else {return UIViewController()}
         vc.pullUpControl = self.pullUpController
         return vc
      }

    func pullUpViewExpandedViewHeight() -> CGFloat {
        return 400
    }
}
