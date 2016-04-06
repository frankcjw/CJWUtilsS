//
//  QPImageUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SDWebImage

public class QPImageUtils: NSObject {
}

public extension UIImageView {
	public func image(url: String, placeholder: String) {
		let placeholderImage = UIImage(named: placeholder)
		sd_setImageWithURL(NSURL(string: url), placeholderImage: placeholderImage) { (img, error, type, nsurl) -> Void in
			//
		}
	}

	public func image(name: String) {
		if let img = UIImage(named: name) {
			self.image = img
		}
	}
}

public extension UIImage {
	/**
	 通过uicolor生成uiimage

	 - parameter color: 颜色

	 - returns: 图片
	 */
	public static func fromColor(color: UIColor = UIColor.redColor()) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillRect(context, rect)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return img
	}
}