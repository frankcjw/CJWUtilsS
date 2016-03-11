//
//  QPBaseTableViewCell.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

public typealias QPTableViewCell = QPBaseTableViewCell

public class QPBaseTableViewCell: UITableViewCell {

	/// 父view controller
	public var rootViewController : UIViewController?
	/// 这个cell的indexPath
	public var indexPath : NSIndexPath?
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
	private func setupAutoLayout() {
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
	private func initCell() {
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

	public func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}
}
