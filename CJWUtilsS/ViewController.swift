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
        
        QPKeyChainUtils.save("abcf", value: "def")
        QPKeyChainUtils.save("abc3", value: "def")
        QPKeyChainUtils.save("abc1", value: "def1")
        QPKeyChainUtils.save("abc2", value: "def2")
        QPKeyChainUtils.save("abc3", value: "def3")
        QPKeyChainUtils.save("abc4", value: "def4")
        
        
        if let pwd = QPKeyChainUtils.value("abc") {
            print("pwd \(pwd)")
        }else{
            print("pwd nil")
        }
        
        QPKeyChainUtils.deleteValue("abc")
        
        if let pwd = QPKeyChainUtils.value("abc") {
            print("pwd \(pwd)")
        }else{
            print("pwd nil")
        }
        
        QPKeyChainUtils.debug()
        
        
//        QPKeyChainUtils.sharedInstance.cache("aaaa", forKey: "cjw")
//        cacheToDisk("aaaa", forKey: "cjw")
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

