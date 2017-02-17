//
//  QPEmojiLabel.swift
//  CJWUtilsS
//
//  Created by Frank on 17/02/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit

class QPEmojiLabel: MLEmojiLabel {

	override func setText(text: AnyObject!) {
		super.setText(text)
		if let ttt = text as? String {
			self.disableThreeCommon = false
			self.customEmojiRegex = "\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
			self.customEmojiPlistName = "expressionImage_custom.plist";
			self.emojiText = ttt
			self.emojiDelegate = self
		}
	}
}

extension QPEmojiLabel: MLEmojiLabelDelegate {
	// TODO:加入点击电话,连接,邮箱时间
	func mlEmojiLabel(emojiLabel: MLEmojiLabel!, didSelectLink link: String!, withType type: MLEmojiLabelLinkType) {
		switch type {
		case MLEmojiLabelLinkType.PhoneNumber:
			let url = "tel://\(link)"
			UIApplication.sharedApplication().openURL(NSURL(string: url)!)
			break
		case MLEmojiLabelLinkType.Email:
//			let url = "tel://\(link)"
			// UIApplication.sharedApplication().openURL(NSURL(string: url)!)
			break
		case MLEmojiLabelLinkType.URL:
			let url = "\(link)"
			// UIApplication.sharedApplication().openURL(NSURL(string: url)!)
			let vc = QPWebViewController()
			vc.url = url
			vc.presentViewControllerFromKeyWindow()
			break
		default:
			break
		}
	}
}