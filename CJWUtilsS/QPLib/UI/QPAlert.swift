//
//  QPAlert.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import KLCPopup

public class QPAlert: NSObject {

	class var sharedInstance: QPAlert {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPAlert? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPAlert()
		}
		return Static.instance!
	}

	public var pop: KLCPopup!

	public class func dismiss() {
		QPAlert.sharedInstance.dismiss()
	}

	public func dismiss() {
		pop.dismiss(true)
	}

	/**
	 文字弹窗

	 - parameter text:     显示的文字
	 - parameter duration: 显示时长,默认1s后消失
	 */
	public class func showTips(text: String, duration: NSTimeInterval = 1) {
		QPAlert.sharedInstance.showTips(text, duration: duration)
	}

	/**
	 文字弹窗

	 - parameter text:     显示的文字
	 - parameter duration: 显示时长,默认1s后消失
	 */
	func showTips(text: String, duration: NSTimeInterval = 1) {

		let www = SCREEN_WIDTH * 0.72
		let hhh = SCREEN_HEIGHT * 0.167916042

		let vvv = UIView(frame: CGRectMake(0, 0, www, hhh))
		vvv.backgroundColor = COLOR_WHITE
		vvv.layer.cornerRadius = 10

		let textLabel = UILabel()
		textLabel.numberOfLines = 0
		vvv.addSubview(textLabel)

		textLabel.alignTop("0", leading: "0", bottom: "0", trailing: "0", toView: vvv)
		textLabel.text = text
		textLabel.textAlignment = NSTextAlignment.Center

		if self.pop != nil {
			if self.pop.isBeingDismissed || self.pop.isBeingShown {
				return
			}
		}
		let pop = KLCPopup(contentView: vvv, showType: KLCPopupShowType.GrowIn, dismissType: KLCPopupDismissType.BounceOut, maskType: KLCPopupMaskType.Dimmed, dismissOnBackgroundTouch: true, dismissOnContentTouch: false)

		pop.contentView.layer.cornerRadius = 20
		pop.show()
		self.pop = pop

		excute(duration) { () -> () in
			self.dismiss()
		}
	}
}

public extension NSObject {
	/**
	 文字弹窗

	 - parameter text:     显示的文字
	 - parameter duration: 显示时长,默认1s后消失
	 */
	public func showText(text: String, duration: NSTimeInterval = 1) {
		QPAlert.showTips(text, duration: duration)
	}
}
