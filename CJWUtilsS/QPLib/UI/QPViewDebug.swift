//
//  QPViewDebug.swift
//  CJWUtilsS
//
//  Created by Frank on 3/8/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPViewDebug: UIView {
}

// MARK: - 给view debug的小工具
public extension UIView {

	/**
	 debug的时候方便查看背景的颜色

	 - parameter deepDebug: 是否需要深度遍历所有的subview
	 */
	public func debug(deepDebug: Bool = false) {
		layer.borderColor = UIColor.blackColor().CGColor
		layer.borderWidth = 1

		if self is UIImageView {
			self.backgroundColor = UIColor.pomegranateColor()
		} else if self is UILabel {
			self.backgroundColor = UIColor.peterRiverColor()
		} else if self is UIButton {
			self.backgroundColor = UIColor.pumpkinColor()
		} else if self is UITextField {
			self.backgroundColor = UIColor.alizarinColor()
		}
		self.backgroundColor = COLOR_DEBUG

		if deepDebug {
			for sv in self.subviews {
				sv.debug(true)
			}
		}
	}
}