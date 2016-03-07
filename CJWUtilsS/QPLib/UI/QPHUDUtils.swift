//
//  QPHUDUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD

class QPHUDUtils: NSObject {
	var mbHUD : MBProgressHUD?

	class var sharedInstance : QPHUDUtils {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : QPHUDUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPHUDUtils()
		}
		return Static.instance!
	}
}

public extension NSObject {
	public func showHUD(text: String) {
		SVProgressHUD.setBackgroundColor(COLOR_BLACK)
		SVProgressHUD.setForegroundColor(COLOR_WHITE)
		SVProgressHUD.setRingThickness(8)
		SVProgressHUD.showWithStatus(text)
	}

	public func hideHUD() {
		SVProgressHUD.dismiss()
	}

	public func showLoading(view: UIView, text: String) {
		MBProgressHUD.showHUDAddedTo(view, animated: true)
	}
}

public extension UIView {

	private func cleanHud() {
		if let hud = QPHUDUtils.sharedInstance.mbHUD {
			hud.hide(true)
		}
	}

	public func showLoading(text: String) {
		cleanHud()
		self.userInteractionEnabled = false
		let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
		if hud != nil { }
		hud.labelText = text
		hud.mode = .Indeterminate
		QPHUDUtils.sharedInstance.mbHUD = hud
	}

	public func hideLoading() {
		cleanHud()
		self.userInteractionEnabled = true
		MBProgressHUD.hideAllHUDsForView(self, animated: true)
	}

	/**
	 老方法,和以前的项目对接
	 隐藏hud
	 */
	public func hideAllHUD() {
		hideLoading()
	}

	/**
	 老方法,和以前的项目对接
	 显示hud

	 - parameter text: 需要显示的内容
	 */
	public func showHUDwith(text: String) {
		showLoading(text)
	}

	/**
	 老方法,和以前的项目对接
	 短暂出现hud

	 - parameter text: 需要显示的内容
	 */
	public func showTemporary(text: String) {
		showLoading(text)
		self.excute(1.5) { () -> () in
			self.hideAllHUD()
		}
	}
}