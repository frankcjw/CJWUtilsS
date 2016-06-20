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
		return log
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
				param["debugInfo"] = debugInfo ?? ""
				QPHttpUtils.sharedInstance.newHttpRequest(url, param: param, success: { (response) in
					//
				}) {
					//
				}
			}
		}
	}

	override public func logln(logLevel: XCGLogger.LogLevel, functionName: String, fileName: String, lineNumber: Int, @noescape closure: () -> String?) {
		super.logln(logLevel, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: closure)
		localDebug(logLevel, debugInfo: closure())
	}
}