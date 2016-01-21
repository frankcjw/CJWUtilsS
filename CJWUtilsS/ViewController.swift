//
//  ViewController.swift
//  CJWUtilsS
//
//  Created by cen on 8/12/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UITableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.registerClass(CJWCell.self, forCellReuseIdentifier: "CJWCell")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("CJWCell") as! CJWCell
		cell.setup()
		cell.label.setNeedsUpdateConstraints()
		cell.label.updateConstraintsIfNeeded()
		log.warning("sdsd \(cell.label.numberOfLines)")
		return cell
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

//        QPKeyChainUtils.sharedInstance.cache("aaaa", forKey: "cjw")
//        cacheToDisk("aaaa", forKey: "cjw")
		if let value = QPKeyChainUtils.sharedInstance.cacheBy("cjw") {
			print("value \(value)")
		}
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
	}

	override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}

	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return UITableViewAutomaticDimension
	}
}

class CJWCell : QPCell {
	let label = UILabel()
	let label2 = UILabel()

	override func setupViews(view: UIView) {
		view.addSubview(label)
		label.text = ".php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/.php?url=github.com/frankcjw/CJWOCLib/"
		label.backgroundColor = UIColor.yellowColor()
        label.numberOfLines = 0

		view.addSubview(label2)
		label2.backgroundColor = UIColor.lightGrayColor()
		label2.numberOfLines = 0
		label2.text = "CJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLibCJWOCLib"
	}

	override func setupConstrains(view: UIView) {
		label.alignTop("20", leading: "20", bottom: "<=-20", trailing: "-20", toView: view)
//		label.alignLeading("30", trailing: "-30", toView: view)
//		label.alignTopEdgeWithView(view, predicate: "30")
//		label.heightConstrain(">=200")
		label2.constrainTopSpaceToView(label, predicate: "30")

		label2.leadingAlign(view, predicate: "0")
		label2.trailing(view, predicate: "-30")
		label2.bottom(view, predicate: "-20")

	}
}

class QPCell : UITableViewCell {
	var rootViewController : UIViewController?

	var didSetupConstraints = false
	var cellInfo = NSDictionary()

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)

		initCell()
	}

	private func setupAutoLayout() {
		self.contentView.setToAutoLayout()
		contentView.alignLeading("0", trailing: "0", toView: self)
	}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initCell()
	}

	private func initCell() {
		setupViews(contentView)
		setupAutoLayout()
		self.selectionStyle = UITableViewCellSelectionStyle.None
	}

	override func updateConstraints() {

		// if !didSetupConstraints {
		// setupConstrains(contentView)
		// didSetupConstraints = true
		// }
		setupConstrains(contentView)

		super.updateConstraints()
	}

	func setupConstrains(view: UIView) {
	}

	func setupViews(view: UIView) {
	}

	func setInfo(info: NSDictionary) {
		self.cellInfo = info
		setupConstrains(contentView)
	}

	func setup() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}
}
