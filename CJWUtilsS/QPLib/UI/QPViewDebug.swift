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
		self.backgroundColor = COLOR_DEBUG
		layer.borderColor = UIColor.blackColor().CGColor
		layer.borderWidth = 1

		if deepDebug {
			for sv in self.subviews {
				sv.debug(true)
			}
		}
	}
}