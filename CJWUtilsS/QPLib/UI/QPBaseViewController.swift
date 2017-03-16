//
//  QPBaseViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public typealias QPViewController = QPBaseViewController

public class QPBaseViewController: UIViewController {

	public var info = NSDictionary()
	override public func viewDidLoad() {
		super.viewDidLoad()
	}

	/// 是否隐藏NavigationBar,默认不隐藏
	public var shouldHideNavigationBar: Bool = false

	override public func viewWillAppear(animated: Bool) {

		if shouldHideNavigationBar {

			self.navigationController?.setNavigationBarHidden(true, animated: animated)
		} else {

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
	/**
	 请求服务器方法.
	 */
	public func request() {
	}

	/**
	 请求加载更多
	 */
	public func requestMore() {
	}
}

public extension UIViewController {
	public func presentViewControllerFromKeyWindow() {
//        let vc = CJWWebViewController()
//        vc.url = "http://www.qq.com"
		let vc = self
		let barButton = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: vc, action: #selector(UIViewController.dismiss))
		vc.navigationItem.leftBarButtonItem = barButton
		let navi = UINavigationController(rootViewController: vc)

		UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(navi, animated: true, completion: { () -> Void in
			//
		})
	}
}

public extension UIViewController {
	public func dismiss() {
		self.dismissViewControllerAnimated(true) {
			//
		}
	}
}

public extension UIViewController {
	/**
	 安全的push view controller

	 - parameter viewController: 要跳转的view controller
	 - parameter animated:       是否动画 默认true
	 */
	public func pushViewController(viewController: UIViewController, animated: Bool = true) {
		if let navi = self.navigationController {
			if let vc = viewController as? QPTableViewController {
				vc.pushedViewController = self
			}
			viewController.hidesBottomBarWhenPushed = QPUtils.sharedInstance.config.hidesBottomBarWhenPushed
			navi.pushViewController(viewController, animated: animated)
		}
	}

	/**
	 安全的返回上一页

	 - parameter animated: 是否动画 默认true
	 */
	public func popViewController(animated: Bool = true) {
		if let navi = self.navigationController {
			navi.popViewControllerAnimated(animated)
		}
	}

	/**
     测试,失败了
     
     - parameter title: <#title description#>
     */
	func setBackTitle(title: String) {
		let button = UIButton(frame: CGRectMake(0, 0, 30, 30))
		button.setBackgroundImage(UIImage(named: "Practicetopic_icon_back"), forState: .Normal)
		button.addTarget(self, action: Selector("controllerDismiss"), forControlEvents: UIControlEvents.TouchUpInside)
		let back = UIBarButtonItem()
		// back.title = title
		back.customView = button
		self.navigationItem.backBarButtonItem = back
//		self.navigationItem.leftBarButtonItem = back
	}

	/**
     测试,失败了
     重写navigationShouldPopOnBackButton这个方法实现吧少年
     - parameter action:
     */
	func setBackAction(action: Selector) {
		let back = UIBarButtonItem()
		// back.title = title
		back.action = action
		self.navigationItem.backBarButtonItem = back
	}

	public func showNetworkException() {
		let text = "网络错误"
		if view is UITableView {
			self.navigationController?.view.showHUDTemporary(text)
		} else {
			self.view.showHUDTemporary(text)
		}
		if let vc = self as? UITableViewController {
			vc.tableView.endRefreshing()
		}
	}
}

extension UIViewController {
	func newViewWillAppear(animated: Bool) {
//        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
		// IQKeyboardManager.sharedManager().enableAutoToolbar = false
//        IQKeyboardManager.sharedManager().preventShowingBottomBlankSpace = true
		// self.navigationController?.interactivePopGestureRecognizer?.delegate = self
		self.navigationItem.backBarButtonItem?.enabled = false
	}

	func newViewWillDisappear(animated: Bool) {
		self.view.endEditing(true)
		self.navigationController?.view.endEditing(true)
	}
}

public extension UIView {
	/**
	 把view以及子view的translatesAutoresizingMaskIntoConstraints = false
	 */
	public func setToAutoLayout() {
		if self.subviews.count > 0 {
			for sv in self.subviews {
				sv.setToAutoLayout()
			}
		}
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}

public extension UIViewController {
	public func pushViewControllerAndDismiss(vc: UIViewController) {
		if let navi = self.navigationController {
			vc.hidesBottomBarWhenPushed = QPUtils.sharedInstance.config.hidesBottomBarWhenPushed
			var vcs = navi.viewControllers
			vcs.removeLast()
			vcs.append(vc)
			navi.setViewControllers(vcs, animated: true)

		}
	}
}

public extension UIViewController {
	public func addRightButton(title: String, action: Selector) {
		let barButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: action)
		self.navigationItem.rightBarButtonItem = barButton
	}
}

public extension UIViewController {
	public func translucentBar(color: UIColor) {
		self.navigationController?.navigationBar.translucentBar(color)
	}

	public func removeTranslucent() {
		self.navigationController?.navigationBar.translucent = true
	}
}

extension UIViewController {
	func fuckingBack() {
		self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: Selector("back"))
	}

	func fuckingBackAgain() {
		self.navigationController?.interactivePopGestureRecognizer?.removeTarget(self, action: Selector("back"))
	}
}
