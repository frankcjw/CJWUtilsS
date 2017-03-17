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
import HMSegmentedControl

//private let imageError = UIImage(color: COLOR_CLEAR)//UIImage(named: "Cry")
//private let imageLoading = UIImage(color: COLOR_CLEAR)//UIImage(named: "Loading")

private let imageError = UIImage(named: "Cry") // UIImage(named: "Cry")
private let imageLoading = UIImage(named: "Loading")

let TIPS_LOADING = "加载中" // "加载中..."
let TIPS_LOAD_FAIL = "加载失败" // "加载失败"
let TIPS_TAP_RELOAD = "点击加载" // "点击重新加载"
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

	/// 推过来之前的vc
	public var pushedViewController: UIViewController?

	public var page = 1
	private var shouldShowEmptyStatus: Bool = true
	private var statusText = TIPS_LOADING
	private var statusDesciption = TIPS_TAP_RELOAD
	private var statusImage = imageLoading

	public var shouldHideNavigationBar: Bool = false

	/// 是否每次进入页面都请求服务器
	public var alwaysRequest = false

	/// tableview header segment
	public var segmentTitles = ["商会活动", "我的活动"] {
		didSet {
			self.navigationItem.titleView = initSegmentView()
		}
	}
	private var segment: HMSegmentedControl!

	/// 浮动在vc上的view
	public let floatView = QPFloatView()

	private func updateFloatViewFrame() {
		floatView.frame = CGRectMake(0, self.tableView.contentOffset.y, view.width, view.height)
	}

	public override func request() {
		super.request()
	}

	public override func viewWillAppear(animated: Bool) {

		// IQKeyboardManager.sharedManager().enable = false
		// IQKeyboardManager.sharedManager().enableAutoToolbar = false

		if shouldHideNavigationBar {
			self.navigationController?.setNavigationBarHidden(true, animated: animated)
		} else {

			fixNavigationBarColor(animated)
		}
		super.viewWillAppear(animated)
		if alwaysRequest {
			request()
		}
	}

	override public func viewDidAppear(animated: Bool) {
		updateFloatViewFrame()
		super.viewDidAppear(animated)
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
		view.addSubview(floatView)
		self.tableView.emptyDataSetSource = self;
		self.tableView.emptyDataSetDelegate = self;
		self.tableView.clearExtraLines()
//		self.setBackTitle("")
		if !alwaysRequest {
			request()
		}
		load()
		updateFloatViewFrame()
		self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.OnDrag
	}

	override public func preferredStatusBarStyle() -> UIStatusBarStyle {
		return UIStatusBarStyle.LightContent
	}

	public func addRefreshHeader(target: AnyObject!, action: Selector) {
		self.tableView.addRefreshHeader(target, action: action)
	}

	public func addRefreshFooter(target: AnyObject!, action: Selector) {
		self.tableView.addRefreshFooter(target, action: action)
	}

	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		tableView.deselectRowAtIndexPath(indexPath, animated: true)
	}

	public func reloadData() {
		self.tableView.reloadData()
	}

	override public func scrollViewDidScroll(scrollView: UIScrollView) {
		// self.view.endEditing(true)
//		super.scrollViewDidScroll(scrollView)
		floatView.frame = CGRectMake(0, scrollView.contentOffset.y, view.width, view.height)
		scrollView.bringSubviewToFront(floatView)
	}

	override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//		return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
		let cell = cellForRow(atIndexPath: indexPath)
		if let qpCell = cell as? QPTableViewCell {
			qpCell.setup()
			qpCell.rootViewController = self
			qpCell.indexPath = indexPath
			smoothUpdate(qpCell, indexPath: indexPath)
			return qpCell
		}
		smoothUpdate(cell, indexPath: indexPath)
		return cellForRow(atIndexPath: indexPath)
	}

	/**
     平滑的更新cell
     
     - parameter cell:      要更新的cell
     - parameter indexPath: NSIndexPath
     */
	public func smoothUpdate(cell: UITableViewCell, indexPath: NSIndexPath) {
	}

	/**
     平滑的更新cell
     前提是要先实现smoothUpdate,在这个方法里面实现cell内容的设置.✨
     强烈推荐使用,不会导致页面跳动.不过稍微麻烦一点点
     待测试
     
     - parameter indexPath: NSIndexPath
     */
	public func smoothReload(indexPath: NSIndexPath) {
		if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
			smoothUpdate(cell, indexPath: indexPath)
		}
	}
	/**
	 新版版使用这个方法加载cell

	 - parameter indexPath: indexPath

	 - returns: UITableViewCell
	 */
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

extension QPBaseTableViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
	public func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
		return EmptyLoadingImage()
	}

	public func EmptyErrorImage() -> UIImage {
		return UIImage.fromColor()
	}

	public func EmptyLoadingImage() -> UIImage {
		return UIImage.fromColor()
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

	/**
	 隐藏空页面
	 */
	public func hideTableViewEmptyStatus() {
		shouldShowEmptyStatus = false
		self.tableView.reloadEmptyDataSet()
	}

	/**
	 显示空页面
	 */
	public func showTableViewEmptyStatus() {
		shouldShowEmptyStatus = true
		self.tableView.reloadEmptyDataSet()
	}

	/**
	 没有数据
	 */
	public func tableViewNoData() {
		setTableViewEmptyStatus("没有数据", description: nil, imageType: ImageType.Loading)
		self.tableView.hideHeader()
		self.tableView.hideFooter()
	}

	/**
	 加载中
	 */
	public func tableViewLoading() {
		setTableViewEmptyStatus(TIPS_LOADING, description: nil, imageType: ImageType.Loading)
		self.tableView.startLoadData()
	}

	/**
	 加载失败
	 */
	public func tableViewLoadFail() {
		statusImage = EmptyErrorImage()
		setTableViewEmptyStatus(TIPS_LOAD_FAIL, description: TIPS_TAP_RELOAD, imageType: ImageType.Error)
		self.tableView.noticeNoMoreData()
	}

	/**
	 网络错误
	 */
	public func tableViewNetworkException() {
		setTableViewEmptyStatus(TIPS_NETWORK_EXCEPTION, description: TIPS_TAP_RELOAD, imageType: ImageType.Error)
		self.tableView.noticeNoMoreData()
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

public extension QPBaseTableViewController {

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
	}
}

public extension UITableView {
	/**
     重新刷新数据,防止tableview 乱跳
     !!!!有待测试
     */
	public func reloadDateWithoutScroll() {
		let inset = self.contentOffset
		self.reloadData()
		self.layoutIfNeeded()
		self.setContentOffset(inset, animated: false)
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

public extension UITableView {
	public func reloadIndexPath(indexPath: NSIndexPath) {
		dispatch_async(dispatch_get_main_queue()) { () -> Void in
			self.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
		}
	}

	public func reloadVisibleData() {
		if let indexPaths = self.indexPathsForVisibleRows {
			dispatch_async(dispatch_get_main_queue()) { () -> Void in
				self.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.None)
			}
		}
	}
}

public extension Int {
	public mutating func pageReset() {
		self = 1
	}
}