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

    public class func setup() -> XCGLogger{

        let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
        
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