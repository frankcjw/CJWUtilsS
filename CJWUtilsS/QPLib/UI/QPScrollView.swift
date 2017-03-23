//
//  QPScrollView.swift
//  Pods
//
//  Created by Frank on 19/03/2017.
//
//

import UIKit

public class QPScrollView: UIView, UIScrollViewDelegate {

	public typealias QPScrollViewBlock = (page: Int, rect: CGRect) -> UIView

	var block: QPScrollViewBlock?

	public let pageControl = UIPageControl()
	public let scrollView = UIScrollView()

	public func setPageBlock(block: QPScrollViewBlock) {
		self.block = block
	}

	public override func updateConstraints() {
		super.updateConstraints()
	}

	public func setup(view: UIView) {
		view.addSubview(scrollView)
		view.addSubview(pageControl)
		view.backgroundColor = UIColor.lightGrayColor()
		scrollView.paddingConstrain(0)
		scrollView.backgroundColor = UIColor.redColor()

		pageControl.bottomAlign(self, predicate: "-50")
		pageControl.centerX(self)
		pageControl.numberOfPages = count
		scrollView.delegate = self
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.alwaysBounceVertical = false
		scrollView.alwaysBounceHorizontal = true
	}

	public func setupBlock() {
	}

	var count: Int = 1

	public convenience init (count: Int) {
		self.init(frame: CGRect.zero)
		self.count = count
		setup(self)

		pageControl.numberOfPages = count
		pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
		pageControl.currentPageIndicatorTintColor = UIColor.mainColor()
		scrollView.pagingEnabled = true

	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	public override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		let widCount = NSNumber(integer: self.count).CGFloatValue()
		scrollView.contentSize = CGSizeMake(self.width * widCount, self.height - 49)
		for index in 0 ... count - 1 {
			let xPos = NSNumber(integer: index).CGFloatValue() * self.width
			let containerView = UIView()
			containerView.frame = CGRectMake(xPos, 0, self.width, self.height)
			let rect = CGRectMake(0, 0, self.width, self.height)
			if let customView = block?(page: index, rect: rect) {
				containerView.addSubview(customView)
			}
			scrollView.addSubview(containerView)
		}
	}

	public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		let page = scrollView.getCurrentPage()
		self.pageControl.currentPage = page
	}

}
