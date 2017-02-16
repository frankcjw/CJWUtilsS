//
//  QPGridView.swift
//  CJWUtilsS
//
//  Created by Frank on 10/9/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPGridView: UIView {

	var gridCount = 0
	var column = 2

	public var customViews: [UIView] = []

	override public func updateConstraints() {
		super.updateConstraints()
		// var view = self
		// view.leadingAlign(self, predicate: "10")
		// view.trailingAlign(self, predicate: "-10")
		// view.topAlign(self, predicate: "10")
		// view.bottomAlign(self, predicate: "-10")
		// let hei = gridCount * 101
		// view.heightConstrain("\(hei)")
		// view.backgroundColor = UIColor.yellowColor()

		// let tmpPadding = 0
		let padding = 4

		gridContainerView.topAlign(self, predicate: "\(padding)")
		gridContainerView.bottomAlign(self, predicate: "-\(padding)")
		gridContainerView.leadingAlign(self, predicate: "\(padding)")
		gridContainerView.trailingAlign(self, predicate: "-\(padding)")

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
				if grids.count == 1 {
					grid.bottomAlign(view, predicate: "0")
				}
			} else {
				if index % column == 0 {
					grid.topConstrain(verticalReferenceView, predicate: "0")
					verticalReferenceView = grid
					horizanReferenceView = grid
				} else {
					grid.centerY(horizanReferenceView)
					horizanReferenceView = grid
				}

				if index == gridCount - 1 {
					grid.bottomAlign(view, predicate: "0")
				}
			}

			grid.centerX(grid.superview!, predicate: "*\(predicateX)")

			grid.width(grid.superview!, predicate: "*\(wwwScale)")
			if index != 0 {
				grid.width(horizanReferenceView)
			}
			// if let predicate = delegate?.heightPredicateForView?() {
			// grid.heightConstrain(predicate)
			// } else {
			// grid.aspectRatio()
			// }
			if let heightConstrain = gridHeightConstrain() {
				grid.heightConstrain(heightConstrain)
			} else {
				grid.aspectRatio()
			}

			let customViewSuperView = customView.superview!
			customView.leadingAlign(customViewSuperView, predicate: "\(padding)")
			customView.trailingAlign(customViewSuperView, predicate: "-\(padding)")
			customView.topAlign(customViewSuperView, predicate: "\(padding)")
			customView.bottomAlign(customViewSuperView, predicate: "-\(padding)")

		}

	}

	public typealias GridSelectionBlock = (index: Int) -> ()

	func onViewSelected(gesture: UIGestureRecognizer) {
		if let tag = gesture.view?.tag {
			self.onSelectBlock?(index: tag)
		}
	}
	var onSelectBlock: GridSelectionBlock?

	public func addTarget(block: GridSelectionBlock) {
		self.onSelectBlock = block
	}

	var heightConstrain: String?

	public func gridHeightConstrain() -> String? {
		return heightConstrain
	}

	var grids: [UIView] = []
	let gridContainerView = UIView()

	func setup() {
		// self.addSubview(view)
		if gridCount > 0 {
			addSubview(gridContainerView)
			for index in 0 ... gridCount - 1 {

				let grid = UIView()
				grids.append(grid)
				gridContainerView.addSubview(grid)

				// TODO:
				let userCustomView = customView(index)
				userCustomView.tag = index
				userCustomView.addTapGesture(self, action: "onViewSelected:")
				customViews.append(userCustomView)
				grid.addSubview(userCustomView)
			}
		}

	}

	convenience init () {
		self.init(frame: CGRect.zero)
		setup()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	public convenience init (count: Int, column: Int) {
		self.init(frame: CGRect.zero)
		self.gridCount = count
		self.column = column
		setup()
	}

	public convenience init (count: Int, column: Int, heightConstrain: String) {
		self.init(frame: CGRect.zero)
		self.heightConstrain = heightConstrain
		self.gridCount = count
		self.column = column
		setup()
	}

	public func customView(index: Int) -> UIView {
		return UIView()
	}

	public func numberOfColum() -> Int {
		return 2
	}

}
