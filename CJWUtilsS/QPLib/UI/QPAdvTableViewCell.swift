//
//  QPAdvTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 12/01/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit
import JXBAdPageView
import SwiftyJSON
//import SMPageControl

@objc
public protocol QPAdvTableViewCellDelegate {
	func numberOfItems(cell: QPTableViewCell) -> Int
	func imageAtIndex(cell: QPTableViewCell, index: Int) -> String
	optional func titleAtIndex(cell: QPTableViewCell, label: UILabel, index: Int)
	optional func didSelectAtIndex(cell: QPTableViewCell, index: Int)
}

public class QPAdvTableViewCell: QPTableViewCell {

	let advImage = UIImageView()

	public var canShowTitle = false
	var titleLabel = UILabel()
	var adView: JXBAdPageView!

	public var placeholderImage: String = ""
	public var delegate: QPAdvTableViewCellDelegate?

	override public func setupViews(view: UIView) {
		view.addSubview(advImage)
		advImage.backgroundColor = UIColor.lightGrayColor()
	}

//	public typealias QPAdvTableViewCellBlock = (index: Int, info: JSON) -> ()
//	func onAdvClicked(block: QPAdvTableViewCellBlock) {
//		self.block = block
//	}
//	public var block: QPAdvTableViewCellBlock?
//	var advs: [JSON] = []
//	let control = SMPageControl()

	override public func drawRect(rect: CGRect) {
		super.drawRect(rect)
		let pageControlHeight: CGFloat = heightForInfo()
		if adView == nil {
			adView = JXBAdPageView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height))
			self.addSubview(adView)
			adView.bWebImage = true
			adView.delegate = self
			adView.iDisplayTime = 5
			// adView.pageControl.frame = CGRectMake(adView.pageControl.frame.width * 0.6, adView.frame.height - pageControlHeight, adView.pageControl.frame.width * 0.4, pageControlHeight)

			let extraHeight: CGFloat = canShowTitle ? pageControlHeight : 0
			adView.pageControl.frame = CGRectMake(adView.pageControl.x, adView.frame.height - pageControlHeight - extraHeight, adView.pageControl.frame.width, pageControlHeight)
			adView.pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
			adView.pageControl.currentPageIndicatorTintColor = MAIN_COLOR
//			adView.pageControl.pageIndicatorTintColor = COLOR_CLEAR
			adView.pageControl.hidden = true
			adView.pageControl.userInteractionEnabled = false

			let frame = CGRectMake(0, self.frame.height - pageControlHeight, self.frame.width, pageControlHeight)
			titleLabel.frame = frame
			titleLabel.textColor = UIColor.whiteColor()
			titleLabel.font = UIFont.systemFontOfSize(14)
			titleLabel.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
			titleLabel.hidden = !canShowTitle

			customTitleLabel(titleLabel)

			self.addSubview(titleLabel)

//			control.frame = CGRectMake(0, self.frame.height - 50, self.frame.width, 30)
//			control.pageIndicatorImage = UIImage(named: "dot_selected")
//			control.currentPageIndicatorImage = UIImage(named: "dot_deselect")
//			control.minHeight = 10
//			control.userInteractionEnabled = false
//			self.addSubview(control)

			if let delegate = self.delegate {
				customPageControl(adView.pageControl)
				var imageUrls: [String] = []
				let count = delegate.numberOfItems(self)
				if count > 0 {
					for index in 0...count - 1 {
						let url = delegate.imageAtIndex(self, index: index)
						imageUrls.append(url)
					}
					updateAdv(imageUrls)
				}

			}

		}
	}

	public func customPageControl(pageControl: UIPageControl) {
	}

	public func customTitleLabel(label: UILabel) {
	}

	public func heightForInfo() -> CGFloat {
		return 30
	}

	private func updateAdv(images: [String]) {
		if self.adView != nil {
			self.adView.startAdsWithBlock(images) { (index) -> Void in
				self.delegate?.didSelectAtIndex?(self, index: index)
			}
		}
	}

	override public func layoutSubviews() {
		super.layoutSubviews()
	}

	override public func setupConstrains(view: UIView) {
		advImage.topAlign(view, predicate: "1")
		advImage.bottomAlign(view, predicate: "-1")
		advImage.leadingAlign(view, predicate: "1")
		advImage.trailingAlign(view, predicate: "-1")
		let asp: Float = Float(4) / Float(1)
		advImage.constrainAspectRatio("*\(asp)")
	}

}

extension QPAdvTableViewCell: JXBAdPageViewDelegate {
	public func setWebImage(imgView: UIImageView!, imgUrl: String!) {

		let index = adView.pageControl.currentPage
		imgView.backgroundColor = UIColor.lightGrayColor()
//		control.currentPage = index
		if let img = imgUrl {
			imgView.image(img, placeholder: placeholderImage)
		}
		imgView.contentMode = UIViewContentMode.ScaleAspectFill
		imgView.clipsToBounds = true

//		delegate?.imageAtIndex(self, imageView: imgView, index: index)

		if adView != nil {
//			let title = titles[index]
//			self.titleLabel.text = "\t\(title)"
			if canShowTitle {
				delegate?.titleAtIndex?(self, label: self.titleLabel, index: index)
			}
//			delegate?.titleAtIndex?(self, label: self.titleLabel, index: index)
		}

	}
}
