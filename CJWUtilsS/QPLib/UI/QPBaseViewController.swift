//
//  QPBaseViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public class QPBaseViewController: UIViewController {
    
    public var info = NSDictionary()
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 是否隐藏NavigationBar,默认不隐藏
    public var shouldHideNavigationBar : Bool = false
    
    override public func viewWillAppear(animated: Bool) {
        
        
        if shouldHideNavigationBar {
            
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }else{
            
//            self.navigationController?.navigationBar.translucentWith(UIColor.whiteColor())
            self.navigationController?.navigationBar.translucent = false
            
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
//            self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        }
        super.viewWillAppear(animated)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

public extension UIViewController {
    public func request(){
    }
    
    public func requestMore(){
    }
}

public extension UIViewController {
    
    
    
    public func pushViewController(viewController: UIViewController){
        if self.navigationController != nil {
            viewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    public func popViewController(){
        if self.navigationController != nil {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    public func setBackTitle(title:String){
        let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
        button.setBackgroundImage(UIImage(named: "Practicetopic_icon_back"), forState: .Normal)
        button.addTarget(self, action: "controllerDismiss", forControlEvents: UIControlEvents.TouchUpInside)
        let back = UIBarButtonItem()
        //        back.title = title
        back.customView = button
        //        self.navigationItem.backBarButtonItem = back
        //        self.navigationItem.leftBarButtonItem = back
    }
    
    public func setBackAction(action:Selector){
        let back = UIBarButtonItem()
        //        back.title = title
        back.action = action
        self.navigationItem.backBarButtonItem = back
    }
    
    public func showNetworkException(){
//        self.view.showTemporary("网络错误")
    }
}

extension UIViewController {
    func newViewWillAppear(animated:Bool){
//        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        //        IQKeyboardManager.sharedManager().enableAutoToolbar = false
//        IQKeyboardManager.sharedManager().preventShowingBottomBlankSpace = true
        //        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationItem.backBarButtonItem?.enabled = false
    }
    
    func newViewWillDisappear(animated:Bool){
        self.view.endEditing(true)
        self.navigationController?.view.endEditing(true)
    }
}

public extension UIView {
    public func setToAutoLayout(){
        if self.subviews.count > 0 {
            for sv in self.subviews {
                sv.setToAutoLayout()
            }
        }
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
