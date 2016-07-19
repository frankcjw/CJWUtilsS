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
	func numberOfItem() -> Int
}

//extension QPGridTableViewCell: QPGridTableViewCellDelegate {
//	public func buttonAt(index: Int) -> UIButton {
//		return UIButton()
//	}
//
//	public func numberOfRow() -> Int {
//		return 0
//	}
//
//	public func numberOfColumn() -> Int {
//		return 0
//	}
//}

public class QPGridTableViewCell: QPTableViewCell {

	public var delegate: QPGridTableViewCellDelegate?

	public var buttons: [UIButton] = []

	private var row = 0
	public var column = 0
	private var count = 0

	override public func setupViews(view: UIView) {
		super.setupViews(view)

		column = delegate?.numberOfColumn() ?? 0

		let itemCount = delegate?.numberOfItem() ?? 0
		row = itemCount / column
		if (itemCount % column) != 0 {
			row += 1
		}
		// row = delegate?.numberOfRow() ?? 0
		count = itemCount
		self.backgroundColor = COLOR_WHITE
		//

		for index in 0 ... count - 1 {
			let button = delegate?.buttonAt(index) ?? UIButton()
			button.tag = index
			buttons.append(button)
			view.addSubview(button)
		}
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
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
					button.topConstrain(verticalReferenceView, predicate: "0")
					button.leadingAlign(view, predicate: "0")
					verticalReferenceView = button
					horizanReferenceView = button
				} else {
					button.leadingConstrain(horizanReferenceView, predicate: "0")
					button.centerY(horizanReferenceView)
					horizanReferenceView = button
				}
				if index == count - 1 {
					button.bottomAlign(view, predicate: "-10")
				}
			}
			button.width(view, predicate: "*\(wwwScale)")
			button.aspectRatio()
		}
	}
}
