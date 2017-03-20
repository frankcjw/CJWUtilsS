//
//  QPColumnsView.swift
//  CJWUtilsS
//
//  Created by Frank on 19/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

public class QPColumnsView: UIControl {

	private var count = 2
	public var labels: [UILabel] = []
	public var lines: [UIView] = []
	public var indicatorLines: [UIView] = []
	public var currentIndex = 0
	public var selectAble = true

	public func hideLines(flag: Bool = true) {
		for line in lines {
			line.hidden = flag
		}
	}

	public func labelAt(index: Int) -> UILabel {
		return labels[index]
	}

	public convenience init (count: Int) {
		self.init(frame: CGRect.zero)
		self.count = count
		setup(self)
		setupData(self)
		setupLine(self)
	}

	convenience init (count: Int, frame: CGRect) {
		self.init(frame: frame)
		self.count = count
		setup(self)
		setupData(self)
		setupLine(self)
	}

	public convenience init () {
		self.init(frame: CGRect.zero)
		setup(self)
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup(self)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup(self)
	}

	public override func updateConstraints() {
		super.updateConstraints()
	}

	public func setupLabel(label: UILabel) {
		label.numberOfLines = 0
		label.cornorRadius(15)
	}

	public func setupLine(view: UIView) {

		if count == 1 {
//			let xPredicate = UIView.predicate(1, count: 1)
//			let line = UIView()
//			view.addSubview(line)
//			line.widthConstrain("1")
//			line.height(view, predicate: "*0.6")
//			line.centerY(view)
//			line.centerX(view, predicate: "*\(xPredicate)")
//			line.backgroundColorWhite()
//			lines.append(line)
			return
		}
		for index in 1 ... count - 1 {
			let xPredicate = Float(2) * Float(index) / Float(count)
			let line = UIView()
			view.addSubview(line)
			line.widthConstrain("1")
			line.height(view, predicate: "*0.6")
			line.centerY(view)
			line.centerX(view, predicate: "*\(xPredicate)")
			line.backgroundColorWhite()
			lines.append(line)
		}
	}

	public func setupData(view: UIView) {
		for index in 1...count {

			let indexFloat = NSNumber(integer: index).floatValue
			let countFloat = NSNumber(integer: count).floatValue

			let aaa: Float = indexFloat * 2 - 1
			let bbb: Float = (countFloat * 1)
			let xPredicate: Float = aaa / bbb
			let label = UILabel()
			label.tag = index - 1
			labels.append(label)
			view.addSubview(label)

			label.centerY(view)
			label.heightConstrain(">=30")
			label.widthConstrain(">=80")
			label.centerX(view, predicate: "*\(xPredicate)")
			label.textAlignmentCenter()
			label.text = "label \(index)"
			label.textColor = UIColor.whiteColor()
			label.font = FONT_NORMAL
			label.addTapGesture(self, action: "onTap:")

			setupLabel(label)

			let line = UIView()
			view.addSubview(line)
			line.bottomAlign(view, predicate: "0")
			line.width(label)
			line.heightConstrain("2")
			line.centerX(label)
			line.backgroundColor = UIColor.mainColor()
			line.hidden = true
			indicatorLines.append(line)

		}
	}

	func onTap(gesture: UIGestureRecognizer) {
		if let tag = gesture.view?.tag {
			selectIndex(tag)
			self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
		}

	}

	public func setup(view: UIView) {
	}

	public func selectIndex(index: Int) {
		if !selectAble {
			return
		}
		if index < labels.count {
			for label in labels {
				label.backgroundColor = UIColor.whiteColor()
				label.textColor = UIColor.darkGrayColor()
			}
			for line in indicatorLines {
				line.hidden = true
			}

			let label = labelAt(index)
			label.backgroundColor = UIColor.mainColor()
			label.textColor = UIColor.whiteColor()
			indicatorLines[index].hidden = false
			self.currentIndex = index
		}

	}

	public func custom(block: (label: UILabel, index: Int) -> ()) {
		var index = 0
		for label in labels {
			block(label: label, index: index)
			index += 1
		}
	}

}

//public class QPColumnsView2: QPColumnsView {
//	public let imageView = UIImageView()
//
//	public override func setupData(view: UIView) {
//		super.setupData(view)
//		view.addSubview(imageView)
//		let label = labelAt(labels.count - 1)
//		label.hidden = true
//		imageView.centerX(label)
//		imageView.centerY(label)
//		// imageView.aspectRatio()
//		imageView.height(label)
//		imageView.scaleAspectFit()
//		imageView.image("w_unit")
//	}
//}

public extension UILabel {
	func setTitle(title: String, subtitle: String, titleColor: UIColor, subtitleColor: UIColor) {
		let label = self
		label.numberOfLines = 0
		let titleLen = title.length()
		label.text = "\(title)\n\(subtitle)"
		label.textColor = subtitleColor
		label.font = FONT_NORMAL
		label.textAlignmentCenter()
		let range = NSMakeRange(0, titleLen)
		label.setTextColor(titleColor, atRange: range)
		label.setTextFont(FONT_BIG, atRange: range)
	}

}

public extension QPColumnsView {
	public func setTitle(title: String, subtitle: String, index: Int, titleColor: UIColor, subtitleColor: UIColor) {
		let label = labelAt(index)
		label.setTitle(title, subtitle: subtitle, titleColor: titleColor, subtitleColor: subtitleColor)
	}

	public func setTitle(title: String, subtitle: String, index: Int) {
		setTitle(title, subtitle: subtitle, index: index, titleColor: UIColor.lightGrayColor(), subtitleColor: UIColor.whiteColor())
	}
}
