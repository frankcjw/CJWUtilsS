//
//  QPBaseViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

class QPBaseViewController: UIViewController {
    
    var info = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        IQKeyboardManager.sharedManager().enable = false
        //        IQKeyboardManager.sharedManager().enableAutoToolbar = true
        //        self.setBackTitle("")
    }
    
    /// 是否隐藏NavigationBar,默认不隐藏
    var shouldHideNavigationBar : Bool = false
    
    override func viewWillAppear(animated: Bool) {
        
        
        if shouldHideNavigationBar {
            
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }else{
            
            self.navigationController?.navigationBar.translucentWith(UIColor.whiteColor())
            self.navigationController?.navigationBar.translucent = false
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        }
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIViewController {
    func request(){
    }
    
    func requestMore(){
    }
}

extension NSObject {
    //    var http : QPHttpUtils {
    //        return QPHttpUtils.sharedInstance
    //    }
    private func appendingKey() -> String{
        return "\(HOST)-\(QPMemberUtils.sharedInstance.memberId)"
    }
    
    func cacheBy(key : String) -> AnyObject?{
        let newKey = key + appendingKey()
        //
        //        if key == KEY_QuestionInfo {
        //
        //        }
        //        if key == KEY_CourseCategorySelectionId {
        //            //            return -1
        //            if !cacheIsExist(KEY_CourseCategorySelectionId) {
        //                return -1
        //            }
        //        }
        //        if QPCacheUtils.isExist(newKey) {
        //            //            let cacheObject : AnyObject = CJWCacheUtils.getCacheBy(key)
        //            //            CJWCacheUtils.sharedCache().removeObjectForKey(key)
        //            return QPCacheUtils.getCacheBy(newKey)
        //        }else{
        //            return nil
        //        }
        return QPCacheUtils.getCacheBy(newKey)
    }
    
    
    
    func cache(cacheObject: AnyObject!, forKey: String!){
        let newKey = forKey + appendingKey()
        QPCacheUtils.cache(cacheObject, forKey: newKey)
    }
    
    func cacheToDisk(cacheObject: AnyObject!, forKey: String!){
        let newKey = forKey + appendingKey()
        QPCacheUtils.cache(cacheObject, forKey: newKey, toDisk: true)
    }
    
    func cacheIsExist(key:String) -> Bool {
        let newKey = key + appendingKey()
        return QPCacheUtils.isExist(newKey)
    }
}

extension UIViewController {
    
    
    
    func pushViewController(viewController: UIViewController){
        if self.navigationController != nil {
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func popViewController(){
        if self.navigationController != nil {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func setBackTitle(title:String){
        let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setBackgroundImage(UIImage(named: "Practicetopic_icon_back"), forState: .Normal)
        button.addTarget(self, action: "controllerDismiss", forControlEvents: UIControlEvents.TouchUpInside)
        let back = UIBarButtonItem()
        //        back.title = title
        back.customView = button
        //        self.navigationItem.backBarButtonItem = back
        //        self.navigationItem.leftBarButtonItem = back
    }
    
    func controllerDismiss(){
        self.popViewController()
    }
    
    func setBackAction(action:Selector){
        let back = UIBarButtonItem()
        //        back.title = title
        back.action = action
        self.navigationItem.backBarButtonItem = back
    }
    
    func showNetworkException(){
        self.view.showTemporary("网络错误")
    }
}

extension UIViewController {
    func shouldChat(){
        if let index = self.navigationController?.viewControllers.indexOf(self) {
            if index == 0 {
                if QPUtils.sharedInstance.chatting {
                    //                    self.pushViewController(QPUtils.sharedInstance.chattingViewController)
                }
            }
        }
        
    }
}

extension UIViewController {
    func newViewWillAppear(animated:Bool){
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        //        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        IQKeyboardManager.sharedManager().preventShowingBottomBlankSpace = true
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.backBarButtonItem?.enabled = false
    }
    
    func newViewWillDisappear(animated:Bool){
        self.view.endEditing(true)
        self.navigationController?.view.endEditing(true)
    }
    
    //    func newViewWillDisappear(animated:Bool){
    //    }
}

