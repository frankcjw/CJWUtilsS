//
//  GZAlertActionUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public class QPAlertActionUtils: NSObject {
}

public class CJWDate2: NSDate {
	public class func testing() {
		print("test CJWDate", terminator: "")
	}
}

public extension UIViewController {
	typealias QPAlertActionControllerInputBlock = (text: String) -> ()

	public func showInputAlert(title: String, message: String, inputedText: String?, keyboardType: UIKeyboardType, placeholder: String, block: QPAlertActionControllerInputBlock) {

		let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
		let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
		let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
			let tf = actionSheet.textFields?.first
			tf?.resignFirstResponder()
			tf?.keyboardType = keyboardType
			if let text = tf?.text {
				if text != "" {
					block(text: text)
				}
			}
		}

		actionSheet.addTextFieldWithConfigurationHandler { (textField) -> Void in
			textField.placeholder = placeholder
			if let input = inputedText {
				if input != "" {
					textField.text = input
				}
			}
		}

		actionSheet.addAction(cancelAction)
		actionSheet.addAction(comfirmAction)
		self.presentViewController(actionSheet, animated: true) { () -> Void in
		}
	}

	public func showInputAlert(title: String, message: String, inputedText: String?, placeholder: String, block: QPAlertActionControllerInputBlock) {
		showInputAlert(title, message: message, inputedText: inputedText, keyboardType: UIKeyboardType.Default, placeholder: placeholder, block: block)
	}

	public func showConfirmAlert(title: String, message: String, confirm: QPNormalBlock) {
		let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)

		let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
			confirm()
		}
		actionSheet.addAction(comfirmAction)
		self.presentViewController(actionSheet, animated: true) { () -> Void in
		}
	}

	public func showConfirmAlert(title: String, message: String, confirm: QPNormalBlock, cancel: QPNormalBlock) {
		let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)

		let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
			cancel()
		}
		let comfirmAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (action) -> Void in
			confirm()
		}
		actionSheet.addAction(cancelAction)
		actionSheet.addAction(comfirmAction)
		self.presentViewController(actionSheet, animated: true) { () -> Void in
		}
	}

	typealias GZActionSheetBlock = (index: Int) -> ()
	public func showActionSheet(title: String, message: String, buttons: Array<String>, block: GZActionSheetBlock) {
		let actionSheet = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
		for button in buttons {
			let index = buttons.indexOf(button)!
			let action = UIAlertAction(title: button, style: UIAlertActionStyle.Default) { (action) -> Void in
				block(index: index)
			}
			actionSheet.addAction(action)
		}
		let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
		}
		actionSheet.addAction(cancelAction)
		self.presentViewController(actionSheet, animated: true) { () -> Void in
		}
	}
}
