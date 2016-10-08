//
//  QPLogUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/21/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import XCGLogger
import FCFileManager
import CryptoSwift
import SwiftyJSON

public let log = QPLogUtils.setup()

public class QPLogUtils: NSObject {

	public class func setup() -> Log {

		let log = Log(identifier: "advancedLogger", includeDefaultDestinations: false)

		// Create a destination for the system console log (via NSLog)
		let systemLogDestination = XCGNSLogDestination(owner: log, identifier: "advancedLogger.systemLogDestination")

		// Optionally set some configuration options
		systemLogDestination.outputLogLevel = .Warning
		systemLogDestination.showLogIdentifier = false
		systemLogDestination.showFunctionName = true
		systemLogDestination.showThreadName = true
		systemLogDestination.showLogLevel = true
		systemLogDestination.showFileName = true
		systemLogDestination.showLineNumber = true
		systemLogDestination.showDate = true

		// Add the destination to the logger
		log.addLogDestination(systemLogDestination)

		let fileDate = NSDate()
		let logPath = FCFileManager.pathForDocumentsDirectoryWithPath("QPLog\(fileDate)")
		print(logPath)

		// Create a file log destination
		let fileLogDestination = XCGFileLogDestination(owner: log, writeToFile: logPath, identifier: "advancedLogger.fileLogDestination")

		// Optionally set some configuration options
		fileLogDestination.outputLogLevel = .Debug
		fileLogDestination.showLogIdentifier = false
		fileLogDestination.showFunctionName = true
		fileLogDestination.showThreadName = true
		fileLogDestination.showLogLevel = true
		fileLogDestination.showFileName = true
		fileLogDestination.showLineNumber = true
		fileLogDestination.showDate = true

		// Process this destination in the background
		fileLogDestination.logQueue = XCGLogger.logQueue

		// Add the destination to the logger
		log.addLogDestination(fileLogDestination)

		// Add basic app info, version info etc, to the start of the logs
		log.logAppDetails()
		log.xcodeColorsEnabled = true
//		let des = FirelogDestination(FirelogDestination(owner: log, identifier: "Firelog"))
//		log.addLogDestination(des)

//		let des = XCGNSLogDestination(owner: log, identifier: "Firelog")
//		log.addLogDestination(des)
		return log
	}
}

class FirelogDestination: XCGBaseLogDestination {
	override func output(logDetails: XCGLogDetails, text: String) {
		var data = [String: NSObject]()
		data["logLevel"] = logDetails.logLevel.description
		data["date"] = NSNumber(double: round(logDetails.date.timeIntervalSince1970 * 1000))
		data["logMessage"] = logDetails.logMessage
		data["functionName"] = logDetails.functionName
		data["fileName"] = logDetails.fileName
		data["lineNumber"] = logDetails.lineNumber
//		logRef.childByAutoId().set(data)
//        childby
	}
}

public class Log: XCGLogger {

	/// 设备的标记
	public var deviceIdentifier: String?

	/// 远程调试url地址
	public var remoteUrl: String? {
		didSet {
			remoteDebugEnable = remoteUrl == nil ? false : true
		}
	}

	/// 是否允许远程调试
	public var remoteDebugEnable = false

	public typealias LogBlock = (logLevel: XCGLogger.LogLevel, debugInfo: String?) -> ()

	var block: LogBlock?

	public func onLog(block: LogBlock) {
		self.block = block
	}

	private func localDebug(logLevel: XCGLogger.LogLevel, debugInfo: String?) {
		block?(logLevel: logLevel, debugInfo: debugInfo)

		if remoteDebugEnable {

			if let url = remoteUrl {
				var param: [String: AnyObject] = [:]
				param["logLevel"] = "\(logLevel)"
				if let deviceIdentifier = deviceIdentifier {
					param["deviceIdentifier"] = deviceIdentifier
				}

				let bundle = NSBundle.mainBundle().bundleIdentifier
//				if let debugInfo = debugInfo {
//					let result = debugInfo.EncryptAES("passwordpassword")
//					param["debugInfo"] = result ?? ""
//				}
				param["debugInfo"] = debugInfo ?? ""

				param["project"] = bundle ?? ""

				let json = JSON(param).toJSONString()
				if let result = json.EncryptAES("passwordpassword") {
					let enParam = ["info": result]
					QPHttpUtils.sharedInstance.newHttpRequest(url, param: enParam, success: { (response) in
						//
					}) {
						//
					}
				}

			}
		}
	}

	override public func logln(logLevel: XCGLogger.LogLevel, functionName: String, fileName: String, lineNumber: Int, @noescape closure: () -> String?) {
		super.logln(logLevel, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: closure)
		localDebug(logLevel, debugInfo: closure())
	}
}