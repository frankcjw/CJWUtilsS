//
//  QPPushUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit

//class QPPushUtils: QPBasePushUtils, GeTuiSdkDelegate {
public class QPPushUtils: QPBasePushUtils {
//
//    let appid = ""
//    let appKey = ""
//    let appSecret = ""
//
//    var getui:GeTuiSdk!
//
//    class var sharedInstance : QPPushUtils {
//        struct Static {
//            static var onceToken : dispatch_once_t = 0
//            static var instance : QPPushUtils? = nil
//        }
//        dispatch_once(&Static.onceToken) {
//            Static.instance = QPPushUtils()
//        }
//        return Static.instance!
//    }
//
//    override func startPush(launchOptions:[NSObject:AnyObject]?){
//        print("startPush")
//        GeTuiSdk.lbsLocationEnable(false, andUserVerify: false)
//        GeTuiSdk.startSdkWithAppId(appid, appKey: appKey, appSecret: appSecret, delegate: self)
//        GeTuiSdk.setTags(["dev"])
//        super.startPush(launchOptions)
//    }
//
//    /** 远程通知注册成功委托 */
//    func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: NSData){
//        var token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"));
//        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
//
//        // [3]:向个推服务器注册deviceToken
//        GeTuiSdk.registerDeviceToken(token);
//        QPPushUtils.sharedInstance.deviceToken = token
//
//        NSLog("\n>>>[DeviceToken Success]:%@\n\n",token);
//    }
//
//    /** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
//    override func handleNotification(info:NSDictionary){
//        print("handleNotification:\(info)")
//        if let action = info["action"] as? String {
//            if action == "" {
//            }
//            NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_RECEIVE, object: nil)
//        }
//    }
//
//    override class func getPushID() ->  String {
//        let push = GeTuiSdk.clientId()
//        if push == nil {
//            print("push ID nil..........")
//            return ":1"
//        }
//        return GeTuiSdk.clientId() + ":1"
//    }
//
//    func GeTuiSdkDidReceivePayload(payloadId: String!, andTaskId taskId: String!, andMessageId aMsgId: String!, andOffLine offLine: Bool, fromApplication appId: String!) {
//        let data = GeTuiSdk.retrivePayloadById(payloadId)
//        if let str = NSString(data: data, encoding: NSUTF8StringEncoding) {
//            if let info = str.objectFromJSONString() as? NSDictionary {
//                handleNotification(info)
//            }
//        }
//    }
}

public class QPBasePushUtils: NSObject {

	public var deviceToken = ""

	private class func initPush() {
		let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil)
		UIApplication.sharedApplication().registerUserNotificationSettings(settings)
		UIApplication.sharedApplication().registerForRemoteNotifications()
	}

	public class func startPush(launchOptions: [NSObject: AnyObject]?) {
		initPush()
	}

//    public func startPush(launchOptions:[NSObject:AnyObject]?){
//        let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
//        UIApplication.sharedApplication().registerForRemoteNotifications()
//    }

	public class func getPushID() -> String {
		return ""
	}

	public class func registerDeviceToken(deviceToken: NSData) {
	}

	public class func handleRemoteNotification(userInfo: NSDictionary) {
	}

	public func handleNotification(info: NSDictionary) {
	}

	public class func handleActionWithIdentifier(identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
		log.info("handleActionWithIdentifier \(handleActionWithIdentifier)")
	}

	public class func didReceiveRemoteNotification(userInfo: NSDictionary) {
		log.debug("\(userInfo)")
	}

	public class func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
		log.debug("didFailToRegisterForRemoteNotificationsWithError \(error)")
	}

	public class func isFromBackground() -> Bool {
		let state = UIApplication.sharedApplication().applicationState
		switch state {
		case .Active:
			log.error("active")
		case .Background:
			log.error("Background")
		case .Inactive:
			log.error("Inactive")
			// 从后台进入
			return true;
		}
		return false;
	}

	public class func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
		log.info("didReceiveLocalNotification \(notification.userInfo)")
	}
}
