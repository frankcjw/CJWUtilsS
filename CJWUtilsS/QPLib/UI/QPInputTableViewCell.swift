//
//  QPInputTableViewCell.swift
//  CJWUtilsS
//
//  Created by Frank on 19/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

public typealias QPInputTableViewCellBlock = (text: String) -> ()

public class QPInputTableViewCell: QPTableViewCell, UITextFieldDelegate {

	public let tipsLabel = QPTipsLabel()
	public let textField = UITextField()

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
		textField.placeholder = "请输入"
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)

		tipsLabel.leadingAlign(view, predicate: "16")
		tipsLabel.topAlign(view, predicate: "16")
		tipsLabel.bottomAlign(view, predicate: "-16")
		tipsLabel.centerY(view)

		textField.leadingAlign(view, predicate: "100")
//        textField.leadingConstrain(tipsLabel, predicate: ">=16")
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
		textField.placeholder = "请输入手机号码"
	}
}

public class QPInputPasswordTableViewCell: QPInputTableViewCell {
	public override func setupViews(view: UIView) {
		super.setupViews(view)
		textField.secureTextEntry = true
	}
}

public class QPInputVerifyCodeTableViewCell: QPInputTableViewCell2 {
	public override func setupViews(view: UIView) {
		super.setupViews(view)
		textField.placeholder = "请输入手机号码"
		infoLabel.text = "获取验证码"
	}
}

public class QPInputTableViewCell2: QPTableViewCell, UITextFieldDelegate {
	public let tipsLabel = QPTipsLabel()
	public let textField = UITextField()
	public let infoLabel = UILabel()
	var block: QPInputTableViewCellBlock?

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(tipsLabel)
		view.addSubview(textField)
		view.addSubview(infoLabel)
		textField.delegate = self

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

		titleLabel.leadingAlign(view, predicate: ">=100")
		titleLabel.leadingConstrain(tipsLabel, predicate: ">=16")
//        titleLabel.trailingAlign(view)
		titleLabel.centerY(view)
//        titleLabel.trailingAlign(view)

		tipsLabel.leadingAlign(view, predicate: "16")
		tipsLabel.topAlign(view, predicate: "16")
		tipsLabel.bottomAlign(view, predicate: "-16")
		tipsLabel.centerY(view)

	}
}

