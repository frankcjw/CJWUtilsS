//
//  QPGridTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 7/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
@objc
public protocol QPGridTableViewCellDelegate {
	func viewAt(index: Int) -> UIView
	func numberOfColumn() -> Int
	func numberOfItem() -> Int
	optional func heightPredicateForView() -> String
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
	public var customViews: [UIView] = []

	private var row = 0
	public var column = 0
	private var count = 0

	let gridContainerView = UIView()

	override public func setupViews(view: UIView) {
		super.setupViews(view)
		self.delegate = self
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

		view.addSubview(gridContainerView)
		let view = gridContainerView
		for index in 0 ... count - 1 {
			let customView = delegate?.viewAt(index) ?? UIView()
			customView.tag = index
			customViews.append(customView)
			view.addSubview(customView)
		}
		view.debug(true)
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
	}

	public func addTarget(target: AnyObject?, action: Selector) {
		for customView in customViews {
//			button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
			customView.addTapGesture(target, action: action)
		}
	}

	override public func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		gridContainerView.topAlign(view, predicate: "0")
		gridContainerView.bottomAlign(view, predicate: "0")
		gridContainerView.leadingAlign(view, predicate: "0")
		gridContainerView.trailingAlign(view, predicate: "0")

		var horizanReferenceView = customViews.first!
		var verticalReferenceView = customViews.first!

		let wwwScale: CGFloat = CGFloat(1) / CGFloat(column)

		let view = gridContainerView
		for button in customViews {
			let index = customViews.indexOf(button)!

			let scale: CGFloat = CGFloat(1) / CGFloat(column * 2)
			let indexFloat: CGFloat = CGFloat(index + 1) * 2 - 1
			let predicateX: CGFloat = indexFloat * scale * 2

			if index == 0 {
//				button.leadingAlign(view, predicate: "0")
				button.topAlign(view, predicate: "0")
				horizanReferenceView = button
				verticalReferenceView = button
			} else {
				if index % column == 0 {
					button.topConstrain(verticalReferenceView, predicate: "0")
//					button.leadingAlign(view, predicate: "0")
					verticalReferenceView = button
					horizanReferenceView = button
				} else {
//					button.leadingConstrain(horizanReferenceView, predicate: "0")
					button.centerY(horizanReferenceView)
					horizanReferenceView = button
				}

				if index == count - 1 {
					button.bottomAlign(view, predicate: "0")
				}
			}

			button.centerX(button.superview!, predicate: "*\(predicateX)")

			button.width(view, predicate: "*\(wwwScale)")
			if index != 0 {
				button.width(horizanReferenceView)
			}
			if let predicate = delegate?.heightPredicateForView?() {
				button.heightConstrain(predicate)
			} else {
				button.aspectRatio()
			}

			/*

			 let scale: CGFloat = CGFloat(1) / CGFloat(numberOfLogo * 2)
			 let indexFloat: CGFloat = CGFloat(index + 1) * 2 - 1
			 let predicate: CGFloat = indexFloat * scale * 2
			 logo.centerX(logo.superview!, predicate: "*\(predicate)")
			 */
		}
		/*
		 for button in customViews {
		 let index = customViews.indexOf(button)!
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
		 if let predicate = delegate?.heightPredicateForView?() {
		 button.heightConstrain(predicate)
		 } else {
		 button.aspectRatio()
		 }
		 }
		 */
	}
}

extension QPGridTableViewCell: QPGridTableViewCellDelegate {
	public func numberOfItem() -> Int {
		return 4
	}

	public func numberOfColumn() -> Int {
		return 4
	}

	public func viewAt(index: Int) -> UIView {
		let label = UILabel()
		label.text = "label \(index)"
		label.textAlignmentCenter()
		return label
	}
}
