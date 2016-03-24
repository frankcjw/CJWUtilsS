//
//  QPBaseTableTableViewController.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import FlatUIKit
import DZNEmptyDataSet

//private let imageError = UIImage(color: COLOR_CLEAR)//UIImage(named: "Cry")
//private let imageLoading = UIImage(color: COLOR_CLEAR)//UIImage(named: "Loading")

private let imageError = UIImage(named: "Cry") // UIImage(named: "Cry")
private let imageLoading = UIImage(named: "Loading")

let TIPS_LOADING = "加载中"// "加载中..."
let TIPS_LOAD_FAIL = "加载失败"// "加载失败"
let TIPS_TAP_RELOAD = "点击加载"// "点击重新加载"
let TIPS_NETWORK_EXCEPTION = "网络不是很给力,加载就失败了.."
let TIPS_CLEANING_CACHE = "正在清除缓存,请稍候"

public enum ImageType {
	case Loading
	case Error
}

extension UIViewController {
	func fixNavigationBarColor(animated: Bool) {
//        assertionFailure("lib not been imported")

		// FIXME:
//        self.navigationController?.navigationBar.translucentWith(COLOR_WHITE)
//        self.navigationController?.navigationBar.translucent = false
//
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
	}
}

public typealias QPTableViewController = QPBaseTableViewController

public class QPBaseTableViewController: UITableViewController {

	public var controllerInfo = NSDictionary()

	public var page = 1
	private var shouldShowEmptyStatus: Bool = true
	private var statusText = TIPS_LOADING
	private var statusDesciption = TIPS_TAP_RELOAD
	private var statusImage = imageLoading

	public var shouldHideNavigationBar : Bool = false

	public override func viewWillAppear(animated: Bool) {

		// IQKeyboardManager.sharedManager().enable = false
		// IQKeyboardManager.sharedManager().enableAutoToolbar = false

		if shouldHideNavigationBar {

			self.navigationController?.setNavigationBarHidden(true, animated: animated)
		} else {

			fixNavigationBarColor(animated)
		}
		super.viewWillAppear(animated)
	}

	public override func viewWillDisappear(animated: Bool) {
		// if shouldHideNavigationBar {
		// self.navigationController?.setNavigationBarHidden(false, animated: animated)
		// self.navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
		//
		// }
		super.viewWillDisappear(animated)
	}

	override public func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
	}

	public func load() {
	}

	public override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.emptyDataSetSource = self;
		self.tableView.emptyDataSetDelegate = self;
		self.tableView.clearExtraLines()
//		self.setBackTitle("")
		request()
		load()
	}

	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	public func reloadData() {
		self.tableView.reloadData()
	}

	override public func scrollViewDidScroll(scrollView: UIScrollView) {
		self.view.endEditing(true)
	}

	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
		let cell = cellForRow(atIndexPath: indexPath)
		if let qpCell = cell as? QPTableViewCell {
			qpCell.setup()
			qpCell.rootViewController = self
			qpCell.indexPath = indexPath
			return qpCell
		}
		return cellForRow(atIndexPath: indexPath)
	}

	public func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		return UITableViewCell()
	}

	override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	override public func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}

extension QPBaseTableViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
	public func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
		return EmptyLoadingImage()
	}

	public func EmptyErrorImage() -> UIImage {
		return UIImage()
	}

	public func EmptyLoadingImage() -> UIImage {
		return UIImage()
	}

	public func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		let att = [NSFontAttributeName: UIFont.systemFontOfSize(17), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
		return NSAttributedString(string: statusText, attributes: att)
	}

	public func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
		let att = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.lightGrayColor()]
		return NSAttributedString(string: statusDesciption, attributes: att)
	}

	public func emptyDataSetShouldDisplay(scrollView: UIScrollView!) -> Bool {
		return shouldShowEmptyStatus
	}

	public func emptyDataSetDidTapView(scrollView: UIScrollView!) {
		request()
	}

	public func tableViewLoading() {
		setTableViewEmptyStatus(TIPS_TAP_RELOAD, description: nil, imageType: ImageType.Loading)
	}

	public func setTableViewEmptyStatus(tableView: UITableView, title: String, description: String?, imageType: ImageType?) {
	}

	public func setTableViewEmptyStatus(title: String, description: String?, imageType: ImageType?) {
		if description == nil {
			statusDesciption = ""
		} else {
			statusDesciption = description!
		}

		if imageType != nil {
			switch imageType! {
			case .Error:
				statusImage = EmptyErrorImage()
			case .Loading:
				statusImage = EmptyLoadingImage()
				// default:
				// statusImage = imageLoading
			}
		}

		statusText = title
		self.tableView.reloadEmptyDataSet()
	}

	public func hideTableViewEmptyStatus() {
		shouldShowEmptyStatus = false
		self.tableView.reloadEmptyDataSet()
	}

	public func showTableViewEmptyStatus() {
		shouldShowEmptyStatus = true
		self.tableView.reloadEmptyDataSet()
	}

	public func tableViewLoadFail() {
		statusImage = EmptyErrorImage()
		setTableViewEmptyStatus(TIPS_LOAD_FAIL, description: TIPS_TAP_RELOAD, imageType: ImageType.Error)
	}

	public func tableViewNetworkException() {
		setTableViewEmptyStatus(TIPS_NETWORK_EXCEPTION, description: TIPS_TAP_RELOAD, imageType: ImageType.Error)
	}

	public func offsetForEmptyDataSet(scrollView: UIScrollView!) -> CGPoint {
		return CGPointMake(0, -30)
	}
}

public extension UITableViewController {
	public func registerTableViewCell(nibName: String, bundle: NSBundle?, forCellReuseIdentifier: String) {
		self.tableView.registerTableViewCell(nibName, bundle: bundle, forCellReuseIdentifier: forCellReuseIdentifier)
	}

	public func registerTableViewCell(nibName: String, bundle: NSBundle?) {
		self.tableView.registerTableViewCell(nibName, bundle: bundle, forCellReuseIdentifier: nibName)
	}

	public func registerTableViewCell(nibName: String) {
		self.tableView.registerTableViewCell(nibName, bundle: nil, forCellReuseIdentifier: nibName)
	}
}

public extension UITableView {
	public func clearExtraLines() {
		let size = CGRectZero
		self.tableFooterView = UIView(frame: size)
	}

	public func setInsetsTop(top: CGFloat) {

		let insets = UIEdgeInsets(top: top, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right)
		setInsets(insets)
	}

	public func setInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
		let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
		setInsets(insets)
	}

	/**
	 修正顶栏位置

	 - parameter insets: top: 0, left: 0, bottom: 0, right: 0
	 */
	public func setInsets(insets: UIEdgeInsets) {
		self.contentInset = insets;
		self.scrollIndicatorInsets = insets;
	}
}