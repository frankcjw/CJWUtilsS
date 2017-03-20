//
//  QPInputTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 19/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

public class QPInputTableViewCell: QPTableViewCell, UITextFieldDelegate {

	public let tipsLabel = QPTipsLabel()
	public let textField = UITextField()

	public typealias QPInputTableViewCellBlock = (text: String) -> ()

	var block: QPInputTableViewCellBlock?

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(tipsLabel)
		view.addSubview(textField)
		textField.clearButtonMode = UITextFieldViewMode.WhileEditing
		tipsLabel.font = UIFont.fontNormal()
		textField.font = UIFont.fontNormal()
		tipsLabel.textColor = UIColor.darkGrayColor()
		textField.delegate = self
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		tipsLabel.leadingAlign(view, predicate: "16")
		tipsLabel.topAlign(view, predicate: "16")
		tipsLabel.bottomAlign(view, predicate: "-16")
		tipsLabel.centerY(view)

		textField.leadingAlign(view, predicate: "100")
		textField.trailingAlign(view)
		textField.centerY(view)
		textField.trailingAlign(view)
	}

	public func onTextChanged(block: QPInputTableViewCellBlock) {
		self.block = block
	}

	public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		let text = QPUtils.getTextFiedlChangedText(textField, shouldChangeCharactersInRange: range, replacementString: string)
		block?(text: text)
		return true
	}

	public func textFieldShouldClear(textField: UITextField) -> Bool {
		block?(text: "")
		return true
	}
}

public class QPInputNumberTableViewCell: QPInputTableViewCell {
	public override func setupViews(view: UIView) {
		super.setupViews(view)
		textField.keyboardType = UIKeyboardType.NumberPad
	}
}

public class QPInputMobileTableViewCell: QPInputTableViewCell {
	public override func setupViews(view: UIView) {
		super.setupViews(view)
		textField.keyboardType = UIKeyboardType.PhonePad
	}
}

public class QPInputPasswordTableViewCell: QPInputTableViewCell {
	public override func setupViews(view: UIView) {
		super.setupViews(view)
		textField.secureTextEntry = true
	}
}

public class QPInputTableViewCell2: QPTableViewCell {
	public let tipsLabel = QPTipsLabel()
	public let textField = UITextField()
	public let infoLabel = UILabel()

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(tipsLabel)
		view.addSubview(textField)
		view.addSubview(infoLabel)

		textField.clearButtonMode = UITextFieldViewMode.WhileEditing
		tipsLabel.font = UIFont.fontNormal()
		textField.font = UIFont.fontNormal()

		infoLabel.font = UIFont.fontSmall()
		infoLabel.textColor = UIColor.whiteColor()
		infoLabel.backgroundColor = UIColor.mainColor()
		infoLabel.textAlignmentCenter()
		infoLabel.cornorRadius(5)

		tipsLabel.textColor = UIColor.darkGrayColor()
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		tipsLabel.leadingAlign(view, predicate: "16")
		tipsLabel.topAlign(view, predicate: "16")
		tipsLabel.bottomAlign(view, predicate: "-16")
		tipsLabel.centerY(view)

		textField.leadingAlign(view, predicate: "100")
		textField.trailingConstrain(infoLabel)
		textField.centerY(view)

		infoLabel.centerY(view)
		infoLabel.trailingAlign(view)
		infoLabel.widthConstrain("100")
		infoLabel.heightConstrain("25")
	}
}

public class QPLabelTableViewCell: QPTableViewCell {

	public let tipsLabel = QPTipsLabel()
	public let titleLabel = UILabel()

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(tipsLabel)
		view.addSubview(titleLabel)
		tipsLabel.font = UIFont.fontNormal()
		titleLabel.font = UIFont.fontNormal()
		tipsLabel.textColor = UIColor.darkGrayColor()
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		tipsLabel.leadingAlign(view, predicate: "16")
		tipsLabel.topAlign(view, predicate: "16")
		tipsLabel.bottomAlign(view, predicate: "-16")
		tipsLabel.centerY(view)

		titleLabel.leadingAlign(view, predicate: "100")
		titleLabel.trailingAlign(view)
		titleLabel.centerY(view)
		titleLabel.trailingAlign(view)
	}
}

