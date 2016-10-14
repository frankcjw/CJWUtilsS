//
//  QPSegmentViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 10/14/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import HMSegmentedControl

public class QPSegmentViewController: UITabBarController {

	public func numberOfTitles() -> Int {
		return 3
	}

	public func titleAt(index: Int) -> String {
		return "T\(index)"
	}

	public func viewControllerAt(index: Int) -> UIViewController {
		if index == 0 {
			return SegVC()
		} else if index == 1 {
			return SegVC2()
		} else if index == 2 {
			return SegVC3()
		}
		return UIViewController()
	}

	public var segmentTitles = ["", ""] {
		didSet {
			self.navigationItem.titleView = initSegmentView()
		}
	}

	private var segment: HMSegmentedControl!

	override public func viewDidLoad() {

		let count = numberOfTitles()
		var titles: [String] = []
		for index in 0...(count - 1) {
			titles.append(titleAt(index))
			let vc = viewControllerAt(index)
			self.addChildViewController(UINavigationController(rootViewController: vc))
		}
		self.segmentTitles = titles
		self.tabBar.hidden = true
		super.viewDidLoad()

	}

	func addVc(color: UIColor) {
		let vc = SegVC()
		vc.color = color
		self.addChildViewController(UINavigationController(rootViewController: SegVC()))
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override public func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBar.tintColor = UIColor.whiteColor()
		tabBar.barTintColor = UIColor.blackColor()
//		let titles = ["首页", "商家", "钱包"]
		let items = self.tabBar.items!
		for item in items {
			let index = items.indexOf(item)!
			item.title = titleAt(index)
		}
	}
}

public extension QPSegmentViewController {

	public func customSegment(segment: HMSegmentedControl) -> HMSegmentedControl {
		return segment
	}

	private func initSegmentView() -> UIView {
		let view = UIView(frame: CGRectMake(0, 0, 190, 44))
		let selectionViewSelectedColor = COLOR_WHITE
		let selectionViewDeselectedColor = UIColor(fromHexCode: "#fad5a2")
		let selectionViewFont = FONT_TITLE

		if segment == nil {
			segment = HMSegmentedControl(frame: CGRectMake(5, 10, 180, 28))
		}
		segment.backgroundColor = MAIN_COLOR
		segment.sectionTitles = segmentTitles

		segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.Down
		segment.selectionIndicatorColor = selectionViewSelectedColor
		segment.selectionIndicatorHeight = 1
		segment.selectionStyle = HMSegmentedControlSelectionStyle.FullWidthStripe
		segment.verticalDividerWidth = 0
		segment.verticalDividerEnabled = true
		segment.verticalDividerColor = UIColor(fromHexCode: "#DFE1E3")

		segment.titleTextAttributes = [NSFontAttributeName: selectionViewFont, NSForegroundColorAttributeName: selectionViewDeselectedColor]
		segment.selectionStyle = HMSegmentedControlSelectionStyle.TextWidthStripe

		segment.selectedTitleTextAttributes = [NSForegroundColorAttributeName: selectionViewSelectedColor, NSFontAttributeName: selectionViewFont]
		segment.addTarget(self, action: #selector(QPBaseTableViewController.segmentedControlChangedValue(_:)), forControlEvents: UIControlEvents.ValueChanged)
		segment = customSegment(segment)
		view.addSubview(segment)

		return view
	}

	func segmentedControlChangedValue(control: HMSegmentedControl) {
		if control.selectedSegmentIndex == 0 {
		}

		onSegmentChanged(control.selectedSegmentIndex)
	}

	public func onSegmentChanged(index: Int) {
		self.selectedIndex = index
	}
}

class SegVC: UIViewController {
	var color: UIColor!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.yellowColor()
//		self.view.backgroundColor = color
//		self.title = "\(NSDate())"
	}
}

class SegVC2: UIViewController {
	var color: UIColor!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.peterRiverColor()
		// self.view.backgroundColor = color
		// self.title = "\(NSDate())"
	}
}

class SegVC3: UIViewController {
	var color: UIColor!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.redColor()
		// self.view.backgroundColor = color
		// self.title = "\(NSDate())"
	}
}

class QPTabBarViewController: UITabBarController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.addChildViewController(UINavigationController(rootViewController: ViewController()))
		self.addChildViewController(UINavigationController(rootViewController: SecondeViewController()))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		self.tabBar.tintColor = UIColor.whiteColor()
		tabBar.barTintColor = UIColor.blackColor()
		let titles = ["首页", "商家", "钱包"]
		let images = ["CP_cardpool2", "CP_city2", "CP_wallet@3x 2"]
		let selectedImages = ["CP_cardpool", "CP_city", "CP_wallet"]

		let items = self.tabBar.items!
		for item in items {
			let index = items.indexOf(item)!
			item.title = titles[index]
		}
	}
}