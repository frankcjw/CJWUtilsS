//
//  QPFormTableViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 12/2/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SwiftyJSON

public class QPFormTableViewController: QPTableViewController {

	private var sections: [JSON] = []

	/// 提交表单form信息
	var formInfo = NSMutableDictionary()

	/// 表单请求url
	var formUrl: String? = "http://qp.cenjiawen.com:9090/qp/form"

	var formJSON: String?

	override public func viewDidLoad() {
		super.viewDidLoad()
		self.addRightButton("提交", action: #selector(QPFormTableViewController.onSubmit))
	}

	public override func onSubmit() {

	}

	public override func request() {
		if let json = formJSON {
			let response = JSON.parse(json)
			self.sections = response.arrayValue
			self.reloadData()
		} else if let url = formUrl {
			QPHttpUtils.sharedInstance.newHttpRequest(url, param: nil, success: { (response) in
				self.sections = response.arrayValue
				self.reloadData()
			}) {
			}
		}
	}

	// MARK: - Table view data source

	override public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return sections.count
	}

	override public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let section = self.sections[section]
		let title = section["title"].stringValue
		return title
	}

	override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = self.sections[section]
		let selections = section["selections"].arrayValue
		return selections.count
	}

	public func cellForSelectionCell(atIndexPath indexPath: NSIndexPath, type: Int, valueText: String, selectionInfo: JSON) -> UITableViewCell {
		let name = selectionInfo["name"].stringValue
		let key = selectionInfo["key"].stringValue

		let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
		cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
		cell.textLabel?.text = "\(name):\(valueText)"
		cell.detailTextLabel?.text = "\(key) \(type)"
		switch type {
		case 1:
			break;
		case 2:
			cell.textLabel?.text = "\(name):\(valueText)"
			if let id = Int(valueText) {
				let items = selectionInfo["items"].arrayValue
				for item in items {
					let itemId = item["value"].intValue
					if itemId == id {
						let itemName = item["name"].stringValue
						cell.textLabel?.text = "\(name):\(itemName)"
					}
				}
			}
			cell.detailTextLabel?.text = "valueText: \(valueText)"
		case 3:

			if valueText == "" {
				cell.textLabel?.text = "\(name):\(0)"
			} else {
				cell.textLabel?.text = "\(name):\(valueText)"
			}
		default:
			break
		}
		return cell
	}

	override public func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let selectionInfo = getSelectionInfo(indexPath)
		let type = selectionInfo["type"].intValue
		let key = selectionInfo["key"].stringValue
		let valueText = getFormValue(key)
		return cellForSelectionCell(atIndexPath: indexPath, type: type, valueText: valueText, selectionInfo: selectionInfo)
	}

	public func getFormValue(key: String) -> String {
		var valueText = ""
		if let value = self.formInfo[key] as? String {
			valueText = value
		}
		return valueText
	}

	override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
		let selectionInfo = getSelectionInfo(indexPath)
		let type = selectionInfo["type"].intValue
		didSelectCell(type, indexPath: indexPath, selectionInfo: selectionInfo)
	}

	public func didSelectCell(type: Int, indexPath: NSIndexPath, selectionInfo: JSON) {
		switch type {
		case 1:
			didSelectedTextSelection(indexPath)
		case 2:
			didSelectedItemSelection(indexPath)
		case 3:
			didSelectedCheckBoxSelection(indexPath)
		default:
			break;
		}
	}

	public func didSelectedTextSelection(indexPath: NSIndexPath) {
		let selectionInfo = getSelectionInfo(indexPath)
		let key = selectionInfo["key"].stringValue
		let name = selectionInfo["name"].stringValue
//		let placeholder = selectionInfo["placeholder"].stringValue
		let valueText = getFormValue(key)
		let vc = QPFormModifyTableViewController()
		vc.setupBlock(valueText, placeholder: name) { (text) in
			self.formInfo.setValue(text, forKey: key)
			self.reloadData()
		}
		self.pushViewController(vc)
	}

	public func didSelectedCheckBoxSelection(indexPath: NSIndexPath) {
		let selectionInfo = getSelectionInfo(indexPath)
		let key = selectionInfo["key"].stringValue
		var oldValue = 0
		if let value = self.formInfo[key] as? String {
			if let value = Int(value) {
				oldValue = value
			}
		}
		let newValue = oldValue == 1 ? 0 : 1
		self.formInfo.setValue("\(newValue)", forKey: key)
		self.reloadData()
	}

	public func didSelectedItemSelection(indexPath: NSIndexPath) {
		let selectionInfo = getSelectionInfo(indexPath)
		let name = selectionInfo["name"].stringValue
		let items = selectionInfo["items"].arrayValue
		let key = selectionInfo["key"].stringValue
		var names: [String] = []
		for item in items {
			let name = item["name"].stringValue
			names.append(name)
		}
		self.showActionSheet(name, message: "", buttons: names, block: { (index) in
			let item = items[index]
			let value = item["value"].intValue
			self.formInfo.setValue("\(value)", forKey: key)
			self.reloadData()
		})
	}

	override public func reloadData() {
		super.reloadData()
	}

	public func getSelectionInfo(indexPath: NSIndexPath) -> JSON {
		let section = indexPath.section
		let row = indexPath.row
		let sectionInfo = self.sections[section]
		let selections = sectionInfo["selections"].arrayValue
		let selectionInfo = selections[row]
		return selectionInfo
	}

}
