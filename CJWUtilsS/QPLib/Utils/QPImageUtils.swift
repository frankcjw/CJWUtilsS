//
//  QPImageUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SDWebImage
//import SwiftRandom

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
//	public static func fromColor(color: UIColor = UIColor.redColor()) -> UIImage {
//		let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
//		UIGraphicsBeginImageContext(rect.size)
//		let context = UIGraphicsGetCurrentContext()
//		CGContextSetFillColorWithColor(context, color.CGColor)
//		CGContextFillRect(context, rect)
//		let img = UIGraphicsGetImageFromCurrentImageContext()
//		UIGraphicsEndImageContext()
//		return img
//	}

	public static func fromColor(color: UIColor = UIColor.redColor(), width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
		let rect = CGRect(x: 0, y: 0, width: width, height: height)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillRect(context, rect)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return img
	}
}

public extension UIImageView {
	/**
	 生成任意尺寸的图片

	 - parameter width:  图片宽
	 - parameter height: 图片高
	 */
	public func imageWithSize(width: Int, height: Int) {
		let qnurl = "http://oagxrzzdf.bkt.clouddn.com/123.jpg?imageView2/1/w/\(Int(width))/h/\(Int(height))"
		self.image(qnurl, placeholder: "")
	}
}

public extension UIButton {
	/**
	 在button右手边添加图片

	 - parameter img: 右手边的图片
	 */
	public func addRightImage(img: UIImage) {
		let button = self
		let arrow = UIImageView()
		arrow.image = img
		if let title = button.titleLabel {
			button.addSubview(arrow)
			arrow.centerY(title)
			arrow.heightConstrain("10")
			arrow.widthConstrain("10")
			arrow.leadingConstrain(title, predicate: "4")
		}
	}
}

public extension UIImageView {
	public func toCircleImageView() {
		self.toCircleView()
	}

	public func scaleAspectFit() {
		self.contentMode = UIViewContentMode.ScaleAspectFit
		self.clipsToBounds = true
	}

	public func scaleAspectFill() {
		self.contentMode = UIViewContentMode.ScaleAspectFill
		self.clipsToBounds = true
	}
}

public class QPCircleImageView: UIImageView {
	public override func layoutSubviews() {
		super.layoutSubviews()
		toCircleView()
	}

	override public func updateConstraints() {
		super.updateConstraints()
	}

	public func setup() {
	}

	convenience public init () {
		self.init(frame: CGRect.zero)
		setup()
	}

	override public init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
}

extension UIImageView {

	func imageTemplate() {
		let imgs = ["http://hbimg.b0.upaiyun.com/cbc211d045703eba40fb65d5f9bcb8d016da04923577c-gbORW6_fw658", "http://hbimg.b0.upaiyun.com/5ecda99cb699618741836ad85c7c710c89b79d1fd38b4-4sjJsP_fw658", "http://hbimg.b0.upaiyun.com/8c224d2e4b6e35d0c0cc8ee2f018055a012840fa2440f-33rNHQ_fw658", "http://hbimg.b0.upaiyun.com/7e4b4c962dd7d928c58b5c499329e7e3317b7864337b6-n3aIxL_fw658"]
		let ran = (Int(arc4random()) % imgs.count)

		let url = imgs[ran]
		image(url, placeholder: "")
		self.scaleAspectFill()

		// self.scaleAspectFill()
	}
}
