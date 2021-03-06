//
//  QPBaseTableViewCell.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import SwiftyJSON

public typealias QPTableViewCell = QPBaseTableViewCell

public class QPCollectionViewCell: UICollectionViewCell {
	/// 父view controller
	public var rootViewController: UIViewController?
	/// 这个cell的indexPath
	public var indexPath: NSIndexPath?
	public var didSetupConstraints = false
	/// cell的数据
	public var cellInfo = NSDictionary()

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initCell()
	}

	/**
     为contentView添加autoLayout
     */
	func setupAutoLayout() {
		self.contentView.setToAutoLayout()
		contentView.alignLeading("0", trailing: "0", toView: self)
	}

	/**
     初始化cell
     
     - returns: nil
     */
	func initCell() {
		setupViews(contentView)
		setupAutoLayout()
	}

	/**
     更新Constrains
     */
	override public func updateConstraints() {

		// if !didSetupConstraints {
		// setupConstrains(contentView)
		// didSetupConstraints = true
		// }
		setupConstrains(contentView)

		super.updateConstraints()
	}

	/**
     构造Constrains
     
     - parameter view: cell.contentView
     */
	public func setupConstrains(view: UIView) {
	}

	/**
     初始化cell内的view
     
     - parameter view: cell.contentView
     */
	public func setupViews(view: UIView) {
	}

	/**
     添加cell内容
     
     - parameter info: info
     */
	public func setInfo(info: NSDictionary) {
		self.cellInfo = info
		setupConstrains(contentView)
	}

	public func setJson(json: JSON) {
		setupConstrains(contentView)
	}

	public func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}

}

public class QPBaseTableViewCell: UITableViewCell {

	/// 父view controller
	public var rootViewController: UIViewController?
	/// 这个cell的indexPath
	public var indexPath: NSIndexPath?
	public var didSetupConstraints = false
	/// cell的数据
	public var cellInfo = NSDictionary()

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initCell()
	}

	override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initCell()
	}

	/**
	 为contentView添加autoLayout
	 */
	public func setupAutoLayout() {
		self.contentView.setToAutoLayout()
		contentView.alignLeading("0", trailing: "0", toView: self)
	}

	/**
	 初始化cell

	 - returns: nil
	 */
	public func initCell() {
		setupViews(contentView)
		setupAutoLayout()
		self.selectionStyle = UITableViewCellSelectionStyle.None
	}

	/**
	 更新Constrains
	 */
	override public func updateConstraints() {

		// if !didSetupConstraints {
		// setupConstrains(contentView)
		// didSetupConstraints = true
		// }
		setupConstrains(contentView)

		super.updateConstraints()
	}

	/**
	 构造Constrains

	 - parameter view: cell.contentView
	 */
	public func setupConstrains(view: UIView) {
	}

	/**
	 初始化cell内的view

	 - parameter view: cell.contentView
	 */
	public func setupViews(view: UIView) {
	}

	/**
	 添加cell内容

	 - parameter info: info
	 */
	public func setInfo(info: NSDictionary) {
		self.cellInfo = info
		setupConstrains(contentView)
	}

	public func setJson(json: JSON) {
		setupConstrains(contentView)
	}

	public func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}

}

public extension UITableView {
	public func disableSeparator() {
		separatorStyle = UITableViewCellSeparatorStyle.None
	}
}

public extension UITableViewCell {
	/**
	 隐藏分割线
	 */
	public func disableSeparator() {
		separatorInset = UIEdgeInsetsMake(0, bounds.size.width * 2, 0, 0);
	}
}

public class QPSubmitTableViewCell: QPTableViewCell {

	public let titleLabel = UILabel()

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(titleLabel)
		titleLabel.cornorRadius(5)
		titleLabel.backgroundColor = UIColor.mainColor()
		titleLabel.textAlignmentCenter()
		titleLabel.textColor = UIColor.whiteColor()
		titleLabel.font = UIFont.fontNormal()
		self.disableSeparator()
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		titleLabel.leadingAlign(view)
		titleLabel.trailingAlign(view)
		titleLabel.bottomAlign(view)
		titleLabel.topAlign(view)
		titleLabel.heightConstrain("44")
	}

}

public class QPConfirmTableViewCell: QPTableViewCell {
	public let button = UIButton()
	private let label = UILabel()

	override public func setupViews(view: UIView) {
		super.setupViews(view)

		view.addSubview(button)
		view.addSubview(label)

		button.backgroundColor = MAIN_COLOR
		button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
		backgroundColorClear()

		separatorInset = UIEdgeInsetsMake(0, bounds.size.width * 2, 0, 0);

	}

	override public func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		label.heightConstrain("40")
		label.leadingAlign(view, predicate: "16")
		label.topAlign(view, predicate: "20")
		label.trailingAlign(view, predicate: "-16")
		label.bottomAlign(view, predicate: "-4")

		button.heightConstrain("40")
		button.leadingAlign(view, predicate: "16")
		button.topAlign(view, predicate: "20")
		button.trailingAlign(view, predicate: "-16")
		button.bottomAlign(view, predicate: "-4")

	}

}

// MARK: - QPNormalTableViewCell
public class QPNormalTableViewCell: UITableViewCell {
	/// 父view controller
	public var rootViewController: UIViewController?
	/// 这个cell的indexPath
	public var indexPath: NSIndexPath?
	public var didSetupConstraints = false
	/// cell的数据
	public var cellInfo = NSDictionary()

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initCell()
	}

	/**
     为contentView添加autoLayout
     */
	func setupAutoLayout() {
		self.contentView.setToAutoLayout()
		contentView.alignLeading("0", trailing: "0", toView: self)
	}

	override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initCell()
	}

	/**
     初始化cell
     
     - returns: nil
     */
	func initCell() {
		setupViews(contentView)
		// setupAutoLayout()
		self.selectionStyle = UITableViewCellSelectionStyle.None
	}

	/**
     更新Constrains
     */
	override public func updateConstraints() {

		// if !didSetupConstraints {
		// setupConstrains(contentView)
		// didSetupConstraints = true
		// }
		setupConstrains(contentView)

		super.updateConstraints()
	}

	/**
     构造Constrains
     
     - parameter view: cell.contentView
     */
	public func setupConstrains(view: UIView) {
	}

	/**
     初始化cell内的view
     
     - parameter view: cell.contentView
     */
	public func setupViews(view: UIView) {
	}

	/**
     添加cell内容
     
     - parameter info: info
     */
	public func setInfo(info: NSDictionary) {
		self.cellInfo = info
		setupConstrains(contentView)
	}

	public func setJson(json: JSON) {
		setupConstrains(contentView)
	}

	public func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}
}

public extension UITableView {
	public func registerQPInputCell() {
		self.registerClass(QPInputTableViewCell.self, forCellReuseIdentifier: "QPInputTableViewCell")
	}

	public func registerQPNumberCell() {
		self.registerClass(QPInputNumberTableViewCell.self, forCellReuseIdentifier: "QPInputNumberTableViewCell")
	}

	public func registerQPInputMobileCell() {
		self.registerClass(QPInputMobileTableViewCell.self, forCellReuseIdentifier: "QPInputMobileTableViewCell")
	}

	public func registerQPInputPasswordCell() {
		self.registerClass(QPInputPasswordTableViewCell.self, forCellReuseIdentifier: "QPInputPasswordTableViewCell")
	}

	public func registerQPInputCell2() {
		self.registerClass(QPInputTableViewCell2.self, forCellReuseIdentifier: "QPInputTableViewCell2")
	}

	public func registerQPLabelCell() {
		self.registerClass(QPLabelTableViewCell.self, forCellReuseIdentifier: "QPLabelTableViewCell")
	}
}

