//
//  QPAlertUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 2/27/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPAlertUtils: NSObject {
	public typealias QPAlertUtilsBlock = (index: Int) -> ()

	public class func showSelection(viewcontroller: UIViewController, title: String, message: String, titles: [String], block: QPAlertUtilsBlock) {

		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.ActionSheet)
		for actionTitle in titles {
			let alertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default) { (action) -> Void in
				if let index = titles.indexOf(actionTitle) {
					block(index: index)
				}
			}
			alert.addAction(alertAction)
		}

		let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (action) -> Void in
		}

		alert.addAction(cancel)
		viewcontroller.presentViewController(alert, animated: true) { () -> Void in
			//
		}
	}
}
