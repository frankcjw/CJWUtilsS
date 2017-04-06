//
//  QPResponder.swift
//  CJWUtilsS
//
//  Created by Frank on 11/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

/// QP全局启动
public class QPResponder: UIResponder, UIApplicationDelegate {

	public var window: UIWindow?
	public var isNewFeature = false

	class var sharedInstance: QPResponder {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPResponder? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPResponder()
		}
		return Static.instance!
	}
    
    public func applicationWillEnterForeground(application: UIApplication) {
        onAutoLogin()
    }

	public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		let window = UIWindow(frame: UIScreen.mainScreen().bounds)
		self.window = window
		window.rootViewController = QPWelcomViewController()
		window.makeKeyAndVisible()

		UINavigationBar.appearance().barStyle = UIBarStyle.Black// 这是白色....
		UINavigationBar.appearance().tintColor = UIColor.whiteColor()
		UINavigationBar.appearance().barTintColor = UIColor.mainColor()
		let bar = UINavigationBar.appearance()
		bar.translucentBar(UIColor.mainColor())
		bar.translucent = false
		UITabBar.appearance().tintColor = UIColor.mainColor()
		UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
		checkForceUpdate()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QPResponder.onLogout), name: "onLogout", object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QPResponder.onLogin(_:)), name: "onLogin", object: nil)

		/**
         *  是新装或者更新软件,不处理
         */
		if !isNewFeature {
			setupLoginStatus()
		}
		log.outputLogLevel = .Debug
		return true
	}

	/**
     处理登录状态请求
     */
	public func setupLoginStatus() {
		if onAutoLogin() {
		} else {
			showLogin()
		}
	}

	/**
     检查更新
     */
	public func checkForceUpdate() {
		QPVersionUtils.isForceUpdate()
		QPVersionUtils.setup()

	}

	/**
     随意弹出页面
     
     - parameter viewController: <#viewController description#>
     */
	public func showVC(viewController: UIViewController) {
		window?.rootViewController = viewController
		window?.makeKeyAndVisible()
	}

	public class func showVC(viewController: UIViewController) {
		QPResponder.sharedInstance.showVC(viewController)
	}

	public func showNaviVC(vc: UIViewController) {
		let navi = UINavigationController(rootViewController: vc)
		self.showVC(navi)
	}

	/**
     登录成功通知
     
     - parameter notification:
     */
	public func onLogin(notification: NSNotification) {
	}

	/**
     跳转到登出
     */
	public func onLogout() {
	}

	/**
     跳转到登录页面
     */
	public func showLogin() {
	}

	/**
     处理自动登录,被动调用
     
     - returns: 是否正在进行自动登录
     */
	public func onAutoLogin() -> Bool {
		return false
	}
}