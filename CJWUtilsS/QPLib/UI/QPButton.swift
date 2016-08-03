//
//  QPButton.swift
//  CJWUtilsS
//
//  Created by Frank on 7/29/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPButton: UIButton {
	public override func updateConstraints() {
		super.updateConstraints()
	}

	public func setup() {
	}

	public convenience init () {
		self.init(frame: CGRect.zero)
		setup()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	public override func layoutSubviews() {
		super.layoutSubviews()
	}

}

public class QPTopIconButton: QPButton {

	public override func layoutSubviews() {
		super.layoutSubviews()
		self.titleLabel?.numberOfLines = 0
		verticalCenterImageAndTitle(10)
	}
}

public extension UIButton {
	public func verticalCenterImageAndTitle(spacing: CGFloat) {
		if let imageView = self.imageView {
			let sizeZero = CGSizeMake(0, 0)
			// get the size of the elements here for readability
			let imageSize = imageView.frame.size ;
			var titleSize = self.titleLabel?.frame.size ?? sizeZero

			// lower the text and push it left to center it
			self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing / 2), 0.0);

			// the text width might have changed (in case it was shortened before due to
			// lack of space and isn't anymore now), so we get the frame size again
			titleSize = self.titleLabel?.frame.size ?? sizeZero;

			// raise the image and push it right to center it
			self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing / 2), 0.0, 0.0, -titleSize.width);
		}
	}
}
