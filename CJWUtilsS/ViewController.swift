//
//  ViewController.swift
//  CJWUtilsS
//
//  Created by cen on 8/12/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.lightGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        QPKeyChainUtils.sharedInstance.save("abc", value: "def")
        if let pwd = QPKeyChainUtils.value("abc") {
            print("pwd \(pwd)")
        }
        
//        QPKeyChainUtils.sharedInstance.cache("aaaa", forKey: "cjw")
        cacheToDisk("aaaa", forKey: "cjw")
        if let value = QPKeyChainUtils.sharedInstance.cacheBy("cjw") {
            print("value \(value)")
        }
        
        showHUD("nihao")
        showHUD("nihao")
        showHUD("nihao")
        showHUD("nihao")
        showHUD("nihao")
        
        excute(3) { () -> () in
//            self.hideHUD()
        }
    }


}

