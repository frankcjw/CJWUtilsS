//
//  QPFeatureViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 01/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

public class QPFeatureViewController: UIViewController {

	public let CacheKey = "DiskVersion"

	public class func canShowNewFeature() -> Bool {
		// NSString *versionValueStringForSystemNow=[UIApplication sharedApplication].version;
		if let diskVersion = QPCacheUtils.getCacheBy("DiskVersion") as? String {
			let version = AppInfoManager.getVersion()
			if diskVersion == version {
				return false
			}
		}
		return true
	}

	let scrollView = UIScrollView()
	public var images: [String] = []
	let confirmButton = UIButton()
	var currentPage = 0
	let pageControl = UIPageControl()
	public typealias OnEndNewFeatureBlock = () -> ()
	var block: OnEndNewFeatureBlock?

	public var button = UIButton()

	public override func viewDidLoad() {
		super.viewDidLoad()
		scrollView.frame = CGRectMake(0, 0, view.width, view.height)
		self.view.addSubview(scrollView)
		self.view.addSubview(pageControl)

		var index = 0
		for img in images {
			let xPos = NSNumber(integer: index).CGFloatValue() * self.view.width
			let imgv = UIImageView(frame: CGRectMake(xPos, 0, view.width, view.height))
			imgv.image(img)
			imgv.scaleAspectFill()
			scrollView.addSubview(imgv)

			if index == images.count - 1 {
				imgv.addSubview(button)
				button.centerX(imgv)
				button.bottomAlign(imgv, predicate: "-40")
			}
			index += 1
		}

		button.setTitle("立即体验", forState: UIControlState.Normal)
		button.titleLabel?.font = UIFont.systemFontOfSize(21)
		button.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
		button.layer.cornerRadius = 15
		button.layer.borderWidth = 2
		button.layer.masksToBounds = true
		button.layer.borderColor = UIColor.whiteColor().CGColor

		scrollView.addTapGesture(self, action: #selector(QPFeatureViewController.onTap))
		scrollView.contentSize = CGSizeMake(NSNumber(integer: images.count).CGFloatValue() * self.view.width, self.view.width)
		scrollView.pagingEnabled = true
		scrollView.delegate = self
		scrollView.showsHorizontalScrollIndicator = false

		pageControl.bottomAlign(view, predicate: "-44")
		pageControl.centerX(view)
		pageControl.numberOfPages = images.count
		pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
		pageControl.pageIndicatorTintColor = UIColor.darkGrayColor()
	}

	public func setOnEndNewFeatureBlock(block: OnEndNewFeatureBlock) {
		self.block = block
	}

	private func saveVersion() {
		QPCacheUtils.cache(AppInfoManager.getVersion(), forKey: CacheKey, toDisk: true)
	}

	public class func clearNewFeatureStatus() {
		QPCacheUtils.cache("", forKey: "DiskVersion", toDisk: true)
	}

	func onTap() {
		if currentPage == images.count - 1 {
			saveVersion()
			block?()
			block = nil
			NSNotificationCenter.defaultCenter().postNotificationName("OnEndNewFeature", object: nil)
		}
	}

	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

extension QPFeatureViewController: UIScrollViewDelegate {
	public func scrollViewDidScroll(scrollView: UIScrollView) {
		let page = scrollView.getCurrentPage()
		self.currentPage = page
		pageControl.currentPage = page
	}
}