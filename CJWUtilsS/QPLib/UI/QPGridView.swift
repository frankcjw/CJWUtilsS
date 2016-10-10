//
//  QPGridView.swift
//  CJWUtilsS
//
//  Created by Frank on 10/9/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

class QPGridView: UIView {

	override func updateConstraints() {
		super.updateConstraints()
		view.leadingAlign(self, predicate: "0")
		view.trailingAlign(self, predicate: "0")
		view.topAlign(self, predicate: "0")
		view.bottomAlign(self, predicate: "0")
//		view.width(self)
//		view.heightConstrain("\(hei)")
//		view.backgroundColor = UIColor.yellowColor()
	}

	let view = UIView()

	func setup() {
		let hei = gridCount * 10
		self.addSubview(view)
	}

	convenience init () {
		self.init(frame: CGRect.zero)
		setup()
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}

	var gridCount = 0
	convenience init (count: Int) {
		self.init(frame: CGRect.zero)
		self.gridCount = count
		setup()
	}
}
