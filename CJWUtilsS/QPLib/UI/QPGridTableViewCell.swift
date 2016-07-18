//
//  QPGridTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 7/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public protocol QPGridTableViewCellDelegate {
	func buttonAt(index: Int) -> UIButton
	func numberOfColumn() -> Int
	func numberOfRow() -> Int
}

public class QPGridTableViewCell: QPTableViewCell {

	public var delegate: QPGridTableViewCellDelegate?

	public var buttons: [UIButton] = []

	public var row = 0
	public var column = 0

	override public func setupViews(view: UIView) {
		super.setupViews(view)

		column = delegate?.numberOfColumn() ?? 0
		row = delegate?.numberOfRow() ?? 0

		let count = column * row - 1
		self.backgroundColor = COLOR_WHITE
		//

		for index in 0 ... count {
//			let button = TopIconButton()
			let button = delegate?.buttonAt(index) ?? UIButton()
			button.tag = index
			// button.setTitle("\(titles[index])", forState: UIControlState.Normal)
			button.setImage(UIImage(named: "Phone"), forState: UIControlState.Normal)
			button.setTitleColor(UIColor.lightGrayColor(), forState:
					UIControlState.Normal)
			button.setTitle("fuck it", forState: UIControlState.Normal)
			// button.backgroundColor = COLOR_WHITE
			// button.imageEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5)
			buttons.append(button)
			view.addSubview(button)
		}
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
//		for button in buttons {
//			button.titleLabel?.font = FONT_M
//		}
	}

	public func addTarget(target: AnyObject?, action: Selector) {
		for button in buttons {
			button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
		}
	}

	override public func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		var horizanReferenceView = buttons.first!
		var verticalReferenceView = buttons.first!
		let wwwScale: CGFloat = CGFloat(1) / CGFloat(column)
		for button in buttons {
			let index = buttons.indexOf(button)!
			if index == 0 {
				button.leadingAlign(view, predicate: "0")
				button.topAlign(view, predicate: "0")
				horizanReferenceView = button
				verticalReferenceView = button
			} else {
				if index % column == 0 {
					button.topAlign(verticalReferenceView, predicate: "0")
					button.leadingAlign(view, predicate: "0")
					verticalReferenceView = button
					horizanReferenceView = button
				} else {
					button.leadingConstrain(horizanReferenceView, predicate: "0")
					button.centerY(horizanReferenceView)
					horizanReferenceView = button
				}
				if index == column * row - 1 {
					button.bottomAlign(view, predicate: "-10")
				}
			}
			button.width(view, predicate: "*\(wwwScale)")
			button.aspectRatio()
		}
	}
}
