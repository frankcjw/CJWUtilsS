//
//  QPFormModifyTableViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 12/2/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

class QPFormModifyTableViewController: QPTableViewController {

	var textInputFiled = UITextField()

	private var text = ""
	private var placeholder = ""

	typealias QPInputModifyBlock = (text: String) -> ()

	var block: QPInputModifyBlock?

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.registerClass(QPInputTextFieldCell.self, forCellReuseIdentifier: "QPInputTextFieldCell")
		self.addRightButton("更新", action: #selector(QPFormModifyTableViewController.onConfirm))
		self.title = placeholder
	}

	func onConfirm() {
		popViewController(true)
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("QPInputTextFieldCell") as! QPInputTextFieldCell
		cell.textField.text = self.text
		cell.textField.placeholder = self.placeholder
		self.textInputFiled = cell.textField
		return cell
	}

	override func popViewController(animated: Bool) {
		super.popViewController(animated)
		block?(text: textInputFiled.text ?? "")
	}

	func setupBlock(text: String, placeholder: String, block: QPInputModifyBlock) {
		self.text = text
		self.placeholder = placeholder
		self.block = block
	}

	func setupBlock(block: QPInputModifyBlock) {
		self.block = block
	}
}

class QPInputTextFieldCell: QPTableViewCell {
	let textField = UITextField()

	override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(textField)
		textField.clearButtonMode = UITextFieldViewMode.WhileEditing
		textField.leftPadding(8)
		textField.placeholder = "fuck"
	}

	override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		textField.leadingAlign(view, predicate: "16")
		textField.trailingAlign(view, predicate: "0")
		textField.topAlign(view, predicate: "0")
		textField.bottomAlign(view, predicate: "0")
		// textField.equalConstrain()
		textField.heightConstrain("44")
	}
}
