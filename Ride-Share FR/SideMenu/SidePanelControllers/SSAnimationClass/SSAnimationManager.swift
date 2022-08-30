//  Haute Delivery
//
//  Created by Ashish Gupta on 06/06/19.
//  Copyright © 2019 Ashish Gupta. All rights reserved.
//
//

import UIKit

class SSAnimationManager: NSObject {
    
    static var shared = SSAnimationManager()
    private var startFrame = CGRect(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2, width: 0, height: 0)
    private var endFrame = CGRect(x: UIScreen.main.bounds.size.width/2, y: UIScreen.main.bounds.size.height/2, width: 0, height: 0)
    
    private override init() {
        super.init()
    }
    
    func add(startFrame : CGRect, endFrame : CGRect){
        self.startFrame = startFrame
        self.endFrame = endFrame
    }
}



class SSPresentationController : UIPresentationController {
    override open var shouldRemovePresentersView: Bool {
        return false
}
}

