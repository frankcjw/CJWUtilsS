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
	optional func gridPadding() -> Int
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
	var grids: [UIView] = []

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

		view.addSubview(gridContainerView)
		let thisView = view
		let view = gridContainerView
		for index in 0 ... count - 1 {

			let grid = UIView()
			grids.append(grid)
			gridContainerView.addSubview(grid)

			let customView = delegate?.viewAt(index) ?? UIView()
			customView.tag = index
			customViews.append(customView)
			customView.debug()
			grid.addSubview(customView)
		}
		thisView.debug()
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

		let tmpPadding = delegate?.gridPadding?() ?? 0
		let padding = tmpPadding == 0 ? 0 : tmpPadding / 2

		gridContainerView.topAlign(view, predicate: "\(padding)")
		gridContainerView.bottomAlign(view, predicate: "-\(padding)")
		gridContainerView.leadingAlign(view, predicate: "\(padding)")
		gridContainerView.trailingAlign(view, predicate: "-\(padding)")

		var horizanReferenceView = customViews.first!
		var verticalReferenceView = customViews.first!

		let wwwScale: CGFloat = CGFloat(1) / CGFloat(column)

		let view = gridContainerView
		for grid in grids {
			let index = grids.indexOf(grid)!

			let customView = customViews[index]

			let scale: CGFloat = CGFloat(1) / CGFloat(column * 2)
			let columnIndex = index % column
			let indexFloat: CGFloat = CGFloat(columnIndex + 1) * 2 - 1
			let predicateX: CGFloat = indexFloat * scale * 2

			if index == 0 {
				grid.topAlign(view, predicate: "0")
				horizanReferenceView = grid
				verticalReferenceView = grid
			} else {
				if index % column == 0 {
					grid.topConstrain(verticalReferenceView, predicate: "0")
					verticalReferenceView = grid
					horizanReferenceView = grid
				} else {
					grid.centerY(horizanReferenceView)
					horizanReferenceView = grid
				}

				if index == count - 1 {
					grid.bottomAlign(view, predicate: "0")
				}
			}

			grid.centerX(grid.superview!, predicate: "*\(predicateX)")

			grid.width(grid.superview!, predicate: "*\(wwwScale)")
			if index != 0 {
				grid.width(horizanReferenceView)
			}
			if let predicate = delegate?.heightPredicateForView?() {
				grid.heightConstrain(predicate)
			} else {
				grid.aspectRatio()
			}

			let customViewSuperView = customView.superview!
			customView.leadingAlign(customViewSuperView, predicate: "\(padding)")
			customView.trailingAlign(customViewSuperView, predicate: "-\(padding)")
			customView.topAlign(customViewSuperView, predicate: "\(padding)")
			customView.bottomAlign(customViewSuperView, predicate: "-\(padding)")

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
	public func gridPadding() -> Int {
		return 8
	}

	public func numberOfItem() -> Int {
		return 13
	}

	public func numberOfColumn() -> Int {
		return 2
	}

	public func viewAt(index: Int) -> UIView {
		let label = UILabel()
		label.text = "label \(index)"
		label.textAlignmentCenter()
		return label
	}

	public func heightPredicateForView() -> String {
		return "100"
	}
}
