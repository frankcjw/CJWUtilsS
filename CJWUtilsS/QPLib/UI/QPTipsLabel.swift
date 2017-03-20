//
//  QPTipsLabel.swift
//  CJWUtilsS
//
//  Created by Frank on 19/03/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

public class QPTipsLabel: UILabel {
	public convenience init () {
		self.init(frame: CGRect.zero)
		setup(self)
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup(self)
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup(self)
	}

	public override func updateConstraints() {
		super.updateConstraints()

	}

	public func setup(view: UIView) {
		font = UIFont.fontNormal()
		textColor = UIColor.darkGrayColor()
	}

}
