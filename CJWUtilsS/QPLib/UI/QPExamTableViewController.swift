//
//  QPExamTableViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 17/02/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

class QPExamTableViewController: QPTableViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let button = UIButton()
		button.setTitle("hello", forState: UIControlState.Normal)
		self.floatView.addSubview(button)

		button.leadingAlign(self.floatView, predicate: "0")
		button.bottomAlign(self.floatView, predicate: "0")
		button.aspectRatio()
		button.debug(false)

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

	// MARK: - Table view data source

	override func cellForRow(atIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = QPTipsTableViewCell()
			cell.titleLabel.debug()
			return cell
		}
		let cell = QPImageTableViewCell()
		cell.contentImageView.debug()
		return cell
	}

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 3
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
}

class QPTipsTableViewCell: QPTableViewCell {

	let titleLabel = QPEmojiLabel()

	override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(titleLabel)
		view.backgroundColor = UIColor.lightGrayColor()
		titleLabel.textColor = UIColor.darkGrayColor()

		titleLabel.font = FONT_SMALL
		titleLabel.text = "[色]你可以转星星给别人\n你可以转星星给别人\nhttp://ww3.sinaimg.cn/mw690/005Ko17Djw1fctevehff5j315o6li4qr.jpg"
		titleLabel.numberOfLines = 0
		titleLabel.textAlignmentCenter()
	}

	override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		titleLabel.paddingConstrain()
	}
}

class QPImageTableViewCell: QPTableViewCell {
	let contentImageView = UIImageView()

	override func setupViews(view: UIView) {
		super.setupViews(view)
		view.addSubview(contentImageView)
	}

	override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		let scale: Float = Float(4) / Float(3)
		contentImageView.aspectRatio("*\(scale)")
		contentImageView.paddingConstrain()
//        imageView.as
	}
}