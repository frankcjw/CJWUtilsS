//
//  QPAppearance.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public let FONT_TITLE = UIFont.boldSystemFontOfSize(15)
public let FONT_NORMAL = UIFont.systemFontOfSize(14)
public let FONT_BIG = UIFont.systemFontOfSize(15)
public let FONT_NORMAL_BOLD = UIFont.boldSystemFontOfSize(14)
public let FONT_LARGE = UIFont.systemFontOfSize(18)
public let FONT_SMALL = UIFont.systemFontOfSize(12)
public let FONT_SMALL_BOLD = UIFont.boldSystemFontOfSize(12)

public let TEXT_CENTER = NSTextAlignment.Center
/// 屏幕宽度
//public let SCREEN_WIDTH: CGFloat = UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame.width ?? 0
public let SCREEN_WIDTH = screenWidth
private var screenWidth: CGFloat {
	let frontToBackWindows = UIApplication.sharedApplication().windows.reverse()
	for window in frontToBackWindows {
		if window.windowLevel == UIWindowLevelNormal {
			return window.width
		}
	}
	return 0
}

/// 屏幕高度
//public let SCREEN_HEIGHT: CGFloat = UIApplication.sharedApplication().keyWindow?.rootViewController?.view.frame.height ?? 0
public let SCREEN_HEIGHT = screenHeight
private var screenHeight: CGFloat {
	let frontToBackWindows = UIApplication.sharedApplication().windows.reverse()
	for window in frontToBackWindows {
		if window.windowLevel == UIWindowLevelNormal {
			return window.height
		}
	}
	return 0
}

public let capitals = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
public let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

class QPAppearance: NSObject {
	class func setup() {
		// UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),NSFontAttributeName: FONT_TITLE]
		// UIButton.appearance().tintColor = MAIN_COLOR
		// UIBarButtonItem.appearance().setBackButtonBackgroundImage(UIImage(named: "Practicetopic_icon_back"), forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)

		// UIView.appearance().tintColor = MAIN_COLOR
		// UIAlertView.appearance().tintColor = MAIN_COLOR
		UINavigationBar.appearance().barStyle = UIBarStyle.Black // 这是白色,黑色就注释掉吧
		UINavigationBar.appearance().tintColor = UIColor.whiteColor()
		UINavigationBar.appearance().barTintColor = MAIN_COLOR
	}
}

public extension UIView {

	public var width: CGFloat {
		return self.frame.width
	}

	public var height: CGFloat {
		return self.frame.height
	}

	public var x: CGFloat {
		return self.frame.origin.x
	}

	public var y: CGFloat {
		return self.frame.origin.y
	}
}

public extension UIView {
	public func cornorRadius(radius: CGFloat = 3) {
		layer.cornerRadius = radius
		layer.masksToBounds = true
	}

	public func toCircleView() {
		var radius: CGFloat!
		if self.width == self.height {
			radius = self.width
		} else {
			radius = self.width > self.height ? self.height : self.width
		}

		let layer = self.layer
		layer.cornerRadius = radius / 2
		layer.masksToBounds = true
	}
}

public extension UILabel {

	public func setTextColor(color: UIColor, atRange range: NSRange) {
		let attribute = getAttribute()
		attribute.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
		self.attributedText = attribute
	}

	public func setTextFont(font: UIFont, atRange range: NSRange) {
		let attribute = getAttribute()
		attribute.addAttribute(NSFontAttributeName, value: font, range: range)
		self.attributedText = attribute
	}

	public func getAttribute() -> NSMutableAttributedString {
		var attribute: NSMutableAttributedString!
		if self.attributedText == nil {
			let txt = self.text ?? ""
			attribute = NSMutableAttributedString(string: txt)
		} else {
			attribute = NSMutableAttributedString(attributedString: attributedText!)
		}
		return attribute
	}
}

public extension UIView {
	public func addTapGesture(target: AnyObject?, action: Selector) {
		let tap = UITapGestureRecognizer(target: target, action: action)
		self.userInteractionEnabled = true
		self.addGestureRecognizer(tap)
	}

	public func removeGesture() {
		self.removeGesture()
		self.userInteractionEnabled = false
	}
}

extension CALayer {
	func transition() {
		/*

		 if([self animationForKey:key]!=nil){
		 [self removeAnimationForKey:key];
		 }
		 CATransition *transition=[CATransition animation];

		 //动画时长
		 transition.duration=duration;

		 //动画类型
		 transition.type=[self animaTypeWithTransitionType:animType];

		 //动画方向
		 transition.subtype=[self animaSubtype:subType];

		 //缓动函数
		 transition.timingFunction=[CAMediaTimingFunction functionWithName:[self curve:curve]];

		 //完成动画删除
		 transition.removedOnCompletion = YES;

		 [self addAnimation:transition forKey:key];

		 return transition;
		 */

		if self.animationForKey("key") != nil {
			self.removeAnimationForKey("key")
		}
		let transition = CATransition()
		transition.duration = 8
		transition.type = "oglFlip"
		transition.subtype = kCATransitionFromTop
		transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		transition.removedOnCompletion = true
		self.addAnimation(transition, forKey: "key")
	}
}

public extension UIScrollView {
	/**
	 滑动到顶部

	 - parameter animate: 是否需要动画
	 */
	func scrollToTop(animate: Bool) {
		self.setContentOffset(CGPointMake(0, 0), animated: animate)
	}
}

public extension UISearchBar {
	/// UISearchBar 里面的UITextField
	public var textField: UITextField? {
		if let textFieldInsideSearchBar = self.valueForKey("searchField") as? UITextField {
			return textFieldInsideSearchBar
		} else {
			return nil
		}
	}
}

/// 有一定padding的textfield
public class QPTextField: UITextField {
	override public func layoutSubviews() {
		super.layoutSubviews()
		layer.borderWidth = 1
		layer.borderColor = UIColor.lightGrayColor().CGColor
		layer.cornerRadius = 5
		layer.masksToBounds = true
	}

	override public func editingRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 10);
	}

	override public func textRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectInset(bounds, 10, 10);
	}
}

public extension UILabel {
	func textAlignmentCenter() {
		self.textAlignment = NSTextAlignment.Center
	}
}

public class QPPaddingTextField: UITextField {

	@IBInspectable public var paddingLeft: CGFloat = 4
	@IBInspectable public var paddingRight: CGFloat = 4

	override public func textRectForBounds(bounds: CGRect) -> CGRect {
		return CGRectMake(bounds.origin.x + paddingLeft, bounds.origin.y,
			bounds.size.width - paddingLeft - paddingRight, bounds.size.height);
	}

	override public func editingRectForBounds(bounds: CGRect) -> CGRect {
		return textRectForBounds(bounds)
	}
}

public extension UITextField {
	/**
	 简单的添加左边padding

	 - parameter padding: 左边padding
	 */
	public func leftPadding(padding: CGFloat) {
		let paddingView: UIView = UIView(frame: CGRectMake(0, 0, padding, 20))
		leftView = paddingView
		leftViewMode = UITextFieldViewMode.Always;
	}
}

public class QPControl: UIControl {
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

public extension UIView {
	public func backgroundColorClear() {
		self.backgroundColor = UIColor.clearColor()
	}

	public func backgroundColorBlack() {
		self.backgroundColor = UIColor.blackColor()
	}

	public func backgroundColorWhite() {
		self.backgroundColor = UIColor.whiteColor()
	}

	public func backgroundColorHex(hex: String) {
		let color = UIColor(fromHexCode: hex)
		self.backgroundColor = color
	}
}

// MARK: - 发弹幕
public extension NSObject {
	/**
	 发弹幕

	 - parameter text: 弹幕内容
	 */
	public func showScreenComment(text: String) {
		let frontToBackWindows = UIApplication.sharedApplication().windows.reverse()
		for window in frontToBackWindows {
			if window.windowLevel == UIWindowLevelNormal {

				let text = text.stringByReplacingOccurrencesOfString("\n", withString: "")
				let font = UIFont.systemFontOfSize(17)

				let label = UILabel()
				let ran = CGFloat(rand())
				let hei: CGFloat = 30
				let width = text.calculateWidth(font, height: hei)

				label.frame = CGRectMake(320, ran % 290, width, hei);
				label.text = text
				label.font = font
				label.textColor = UIColor.whiteColor()
				label.numberOfLines = 0
				label.shadowEffect()
				window.addSubview(label)

				let time = Double(width / 60.0)
				UIView.animateWithDuration(time, animations: {
					label.frame = CGRectMake(-width, label.frame.origin.y, label.frame.size.width, label.frame.size.height);

					}, completion: { (flag) in
					label.removeFromSuperview()
				})
			}
		}
	}
}

public extension UIView {

	/**
	 背景添加阴影效果
	 */
	public func shadowEffect() {
		self.layer.shadowColor = UIColor.blackColor().CGColor;// shadowColor阴影颜色
		self.layer.shadowOffset = CGSizeMake(-4, 4);// shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
		self.layer.shadowOpacity = 0.8;// 阴影透明度，默认0
		self.layer.shadowRadius = 4;// 阴影半径，默认3
		// shadowEffect2()
	}
}

public extension UILabel {
	public func updateLineGap(gap: CGFloat) {
		let paragStyle = NSMutableParagraphStyle()
		paragStyle.lineSpacing = gap

		if let string = self.text {

			let attributeString = NSMutableAttributedString(string: string)
//			let range = string.rangeOfString(string)
//			attributeString.addAttribute(NSParagraphStyleAttributeName, value: paragStyle, range: range)

			attributeString.addAttributes([NSParagraphStyleAttributeName: paragStyle], range: NSMakeRange(0, string.length()))
			self.attributedText = attributeString
		}
	}
}

public extension UIScrollView {
	public func currentPage() -> Int {
		let aaa = Int(self.contentOffset.x + self.width)
		let bbb = Int(self.width)
		let page = aaa / bbb
		return page - 1
	}
}