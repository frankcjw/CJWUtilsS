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
	func viewAt(cell: QPTableViewCell, index: Int) -> UIView
	func numberOfColumn(cell: QPTableViewCell) -> Int
	/**
	 如果不固定grid的数量返回0!!!!!!

	 - returns: grids的数量
	 */
	func numberOfItem(cell: QPTableViewCell) -> Int
	optional func heightPredicateForView(cell: QPTableViewCell) -> String?
	optional func gridPadding(cell: QPTableViewCell) -> Int
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

	private var privateRowCount = 0;

	let gridContainerView = UIView()

	public convenience init(rowCount: Int, delegate: QPGridTableViewCellDelegate, tag: Int) {
		self.init()
		self.tag = tag
		self.delegate = delegate
		privateRowCount = rowCount
		grids = []
		for sv in contentView.subviews {
			sv.removeFromSuperview()
		}
		initCell()
	}

	public convenience init(rowCount: Int, delegate: QPGridTableViewCellDelegate) {
		self.init()
		self.delegate = delegate
		privateRowCount = rowCount
		grids = []
		for sv in contentView.subviews {
			sv.removeFromSuperview()
		}
		initCell()
	}

	override public func setupViews(view: UIView) {
		super.setupViews(view)
		if self.delegate == nil {
			self.delegate = self
		}
		column = delegate?.numberOfColumn(self) ?? 0

		var itemCount = 0
		if privateRowCount > 0 {
			itemCount = privateRowCount
		} else {
			itemCount = delegate?.numberOfItem(self) ?? 0
		}

		count = itemCount
		self.backgroundColor = COLOR_WHITE

		view.addSubview(gridContainerView)
		if count == 0 {
			return
		}
		for index in 0 ... count - 1 {

			let grid = UIView()
			grids.append(grid)
			gridContainerView.addSubview(grid)

			let customView = delegate?.viewAt(self, index: index) ?? UIView()
			customView.tag = index
			customViews.append(customView)
			grid.addSubview(customView)
		}
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
	}

	public func addTarget(target: AnyObject?, action: Selector) {
		for customView in customViews {
			customView.addTapGesture(target, action: action)
		}
	}

	override public func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		let tmpPadding = delegate?.gridPadding?(self) ?? 0
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

				if index == count - 1 {
					grid.bottomAlign(view, predicate: "0")
				}
			}

			grid.centerX(grid.superview!, predicate: "*\(predicateX)")

			grid.width(grid.superview!, predicate: "*\(wwwScale)")
			if index != 0 {
				grid.width(horizanReferenceView)
			}
			if let predicate = delegate?.heightPredicateForView?(self) {
				grid.heightConstrain(predicate)
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
}

extension QPGridTableViewCell: QPGridTableViewCellDelegate {
	public func gridPadding(cell: QPTableViewCell) -> Int {
		return 8
	}

	public func numberOfItem(cell: QPTableViewCell) -> Int {
		return 0
	}

	public func numberOfColumn(cell: QPTableViewCell) -> Int {
		return 4
	}

	public func viewAt(cell: QPTableViewCell, index: Int) -> UIView {
		let label = UILabel()
		label.text = "label \(index)"
		label.textAlignmentCenter()
		return label
	}
}
