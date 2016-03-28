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
public let SCREEN_WIDTH = UIApplication.sharedApplication().keyWindow!.rootViewController!.view.frame.width
/// 屏幕高度
public let SCREEN_HEIGHT = UIApplication.sharedApplication().keyWindow!.rootViewController!.view.frame.height

let capitals = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
let letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

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

public extension UIImageView {
	public func toCircleImageView() {
		self.toCircleView()
	}

	public func scaleAspectFit() {
		self.contentMode = UIViewContentMode.ScaleAspectFit
	}
}

public extension UIView {
	public func cornorRadius(radius: CGFloat) {
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

	private func getAttribute() -> NSMutableAttributedString {
		var attribute: NSMutableAttributedString!
		if self.attributedText == nil {
			print("empt")
			if self.text == nil {
				attribute = NSMutableAttributedString(string: "")
			}
			attribute = NSMutableAttributedString(string: self.text!)
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

		print("\(transition)")
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
	public var textField: UITextField? {
		if let textFieldInsideSearchBar = self.valueForKey("searchField") as? UITextField {
			return textFieldInsideSearchBar
		} else {
			return nil
		}
	}
}