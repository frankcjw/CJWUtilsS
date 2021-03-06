//
//  QPInnerScrollViewCellTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 10/01/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

@objc
public protocol QPInnerScrollViewCellDelegate {
	func innerScrollViewViewAt(cell: QPTableViewCell, index: Int) -> UIView

	func innerScrollViewNumberOfItem(cell: QPTableViewCell) -> Int

	optional func innerScrollViewDidSelectAt(cell: QPTableViewCell, index: Int)
}

public class QPInnerScrollViewCell: QPTableViewCell {

	public let scrollView = UIScrollView()
	private var delegate: QPInnerScrollViewCellDelegate?

	override public func updateConstraints() {
		super.updateConstraints()
	}

	override public func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(scrollView)
	}

	public func heightForScrollView() -> CGFloat {
		return 120
	}

	public convenience init(delegate: QPInnerScrollViewCellDelegate) {
		self.init()
		setupScroll(delegate)
	}

	public func setupScroll(delegate: QPInnerScrollViewCellDelegate) {
		self.delegate = delegate
		let itemCount = delegate.innerScrollViewNumberOfItem(self)
		let oneThird: CGFloat = SCREEN_WIDTH / 3
		let width: CGFloat = oneThird * NSNumber(integer: itemCount).CGFloatValue()

		let size = CGSizeMake(width, self.frame.height)
		scrollView.contentSize = size
		for index in 0 ... itemCount - 1 {
			let view = delegate.innerScrollViewViewAt(self, index: index)
			view.tag = index
			let index: CGFloat = NSNumber(integer: index).CGFloatValue()
			let xPos = index * oneThird
			let frame = CGRectMake(xPos, 0, oneThird, heightForScrollView())
			view.frame = frame
			view.addTapGesture(self, action: #selector(QPInnerScrollViewCell.onTap(_:)))
			scrollView.addSubview(view)
		}
	}

	public func onTap(gesture: UIGestureRecognizer) {
		if let tag = gesture.view?.tag {
			delegate?.innerScrollViewDidSelectAt?(self, index: tag)
		}
	}

	public func padding() -> Int {
		return 8
	}

	override public func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		scrollView.topAlign(view, predicate: "\(padding())")
		scrollView.bottomAlign(view, predicate: "-\(padding())")
		scrollView.leadingAlign(view, predicate: "\(padding())")
		scrollView.trailingAlign(view, predicate: "-\(padding())")
		scrollView.constrainHeight("\(heightForScrollView())")
	}
}
