//
//  QPFloatView.swift
//  CJWUtilsS
//
//  Created by Frank on 8/9/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPFloatView: UIView {

	override public func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		let subview = super.hitTest(point, withEvent: event)
		let flag = (subview == self)
		if !flag {
			return subview
		}
		return nil
	}

}
