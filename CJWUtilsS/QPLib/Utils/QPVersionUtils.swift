//
//  QPVersionUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 25/02/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit
import iRate
import iVersion

public class QPVersionUtils: NSObject {

	class func isForceUpdate() {
		if let bundleId = NSBundle.mainBundle().infoDictionary?["CFBundleIdentifier"] as? String {
			print("\(bundleId)")
			let checkUrl = "http://98.cenjiawen.com:666/service/appversion/check";
			let lastUrl = "http://98.cenjiawen.com:666/service/appversion/latest";
			let build = AppInfoManager.getBuild();
			let version = AppInfoManager.getVersion();
			let param = ["versionPackage": "\(bundleId)", "id": "6", "versionType": "1", "versionCode": "\(build)", "version": "\(version)"]
			QPHttpUtils.sharedInstance.newHttpRequest(checkUrl, param: param, success: { (response) in
				log.info("\(response)")
				}, fail: {
				//
			})
			QPHttpUtils.sharedInstance.newHttpRequest(checkUrl, param: param, success: { (response) in
				log.info("\(response)")
				}, fail: {
				//
			})
		} else {
			log.error("fail to get bundle id")
		}
	}
	public class func setup() {
		let version = iVersion.sharedInstance()
		version.inThisVersionTitle = "版本更新"
		version.updateAvailableTitle = "版本更新"
		// version.versionLabelFormat = "什么鬼"
		version.okButtonLabel = "立即更新"
		version.downloadButtonLabel = "立即更新"
		version.ignoreButtonLabel = "稍后提醒"
		version.remindButtonLabel = "稍候提醒我"
		version.remindPeriod = 1
		version.checkPeriod = 1
		version.viewedVersionDetails = true
//		version.previewMode = true
		// version.delegate = self
		version.checkForNewVersion()

		let rate = iRate.sharedInstance()
		rate.daysUntilPrompt = 3
		rate.usesUntilPrompt = 5
		rate.usesPerWeekForPrompt = 2
		rate.remindPeriod = 3
		rate.promptForNewVersionIfUserRated = true
		rate.messageTitle = "去AppStore给个5星吧!"
		/*
		 NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
		 CFShow(infoDictionary);
		 // app名称
		 NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];

		 */

		var appName = "我们"
		if let info = NSBundle.mainBundle().infoDictionary {
			if let name = info["CFBundleDisplayName"] as? String {
				appName = name
			}
		}
		rate.message = "如果您喜欢\(appName)，请给它一个评价吧。这不会占用您很多的时间，感谢您的支持！"
//		rate.previewMode = true
		rate.rateButtonLabel = "去评价"
		rate.remindButtonLabel = "稍后提醒我"
		rate.cancelButtonLabel = "下次"
	}
}
