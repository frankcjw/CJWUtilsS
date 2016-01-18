//
//  QPHUDUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

class QPHUDUtils: NSObject {
}

public extension NSObject {
    public func showHUD(text:String){
        SVProgressHUD.setBackgroundColor(COLOR_LIGHT_GRAY)
        SVProgressHUD.setForegroundColor(COLOR_LIGHT_LIGHT_GRAY)
        SVProgressHUD.setRingThickness(6)
        SVProgressHUD.showWithStatus(text)

    }
    
    public func hideHUD(){
        SVProgressHUD.dismiss()
    }
}
