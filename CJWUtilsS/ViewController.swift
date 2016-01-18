//
//  ViewController.swift
//  CJWUtilsS
//
//  Created by cen on 8/12/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(indexPath.row) \(indexPath.section)"
        return cell
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
        
       
//        showHUD("nihao")
        self.view.showLoading("buhao")
        
        excute(3) { () -> () in
//            self.hideHUD()
//            self.view.hideLoading()
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }

    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}

