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

	public var rootViewController : UIViewController?

	public var didSetupConstraints = false
	public var cellInfo = NSDictionary()

	override public func awakeFromNib() {
		super.awakeFromNib()
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		initCell()
	}

	private func setupAutoLayout() {
		self.contentView.setToAutoLayout()
		contentView.alignLeading("0", trailing: "0", toView: self)
	}

	override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initCell()
	}

	private func initCell() {
		setupViews(contentView)
		setupAutoLayout()
		self.selectionStyle = UITableViewCellSelectionStyle.None
	}

	override public func updateConstraints() {

		// if !didSetupConstraints {
		// setupConstrains(contentView)
		// didSetupConstraints = true
		// }
		setupConstrains(contentView)

		super.updateConstraints()
	}

	public func setupConstrains(view: UIView) {
	}

	public func setupViews(view: UIView) {
	}

	public func setInfo(info: NSDictionary) {
		self.cellInfo = info
		setupConstrains(contentView)
	}

	public func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}
}
