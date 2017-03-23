//
//  LGView.swift
//  CJWUtilsS
//
//  Created by Frank on 21/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

class LGView: UIView {

}

public class LGColumnsCell: QPTableViewCell {

	public var columnView: QPColumnsView!

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		let count = numberOfColumn()
		columnView = QPColumnsView(count: count)
		view.addSubview(columnView)
		columnView.custom { (label, index) in
			label.textColor = UIColor.darkGrayColor()
		}
		columnView.hideLines()
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		columnView.equalConstrain()
		columnView.heightConstrain("\(heightPredicate())")
	}

	public func heightPredicate() -> String {
		return ">=44"
	}

	public func numberOfColumn() -> Int {
		return 1
	}
}

public class LGColumnsCell2: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 2
	}
}

public class LGColumnsCell3: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 3
	}
}

public class LGColumnsCell4: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 4
	}
}

public class LGColumnsCell5: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 5
	}
}

public class LGColumnsCell6: LGColumnsCell {
	public override func numberOfColumn() -> Int {
		return 6
	}
}

/// 标题 大标题
public class LGColumnsTitleCell: QPTableViewCell {

	public var columnView: QPColumnsView!

	public override func setupViews(view: UIView) {
		super.setupViews(view)
		let count = numberOfColumn()
		columnView = QPColumnsView(count: count)
		view.addSubview(columnView)
	}

	public override func setupConstrains(view: UIView) {
		super.setupConstrains(view)
		columnView.equalConstrain()
		columnView.heightConstrain(">=150")
	}

	public func numberOfColumn() -> Int {
		return 1
	}

	public override func drawRect(rect: CGRect) {
		super.drawRect(rect)
	}

	public func setTitle(title: String, subtitle: String, label: UILabel) {
		label.text = "\(title)\n\n\(subtitle)"
		let range = NSMakeRange(0, title.length())
		label.setTextFont(UIFont.systemFontOfSize(40), atRange: range)
		label.textColor = UIColor.whiteColor()
		label.setTextColor(UIColor.mainColor(), atRange: range)
	}
}

public class LGColumnsTitleCell2: LGColumnsTitleCell {
	public override func numberOfColumn() -> Int {
		return 2
	}
}

public class LGColumnsTitleCell3: LGColumnsTitleCell {
	public override func numberOfColumn() -> Int {
		return 3
	}
}
