//
//  QPHttpUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AFNetworking

let HOST = ""

let BASE_URL = HOST + "service/"

private let URL_LOGIN = BASE_URL + "login"
private let URL_LOGOUT = BASE_URL + "logout/"

let maxPageSize = NSNumber(int: Int32.max).integerValue
let pageSize = 50

public class QPHttpUtils: NSObject {

	var sessionKey = ""

//    var httpManager = AFHTTPRequestOperationManager()

	public class var sharedInstance : QPHttpUtils {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : QPHttpUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPHttpUtils()
		}
		return Static.instance!
	}

	public typealias QPSuccessBlock = (response: JSON) -> ()
	public typealias QPFailBlock = () -> ()

	public typealias QPOldSuccessBlock = (response: AnyObject?) -> ()

	public class func request(url: String, param: [String : AnyObject]!, success: QPSuccessBlock!, fail: QPFailBlock!) -> () {
//		return QPHttpUtils.sharedInstance.newHttpRequest(url, param: param, success: success, fail: fail)
	}

	/**
	 过去的http方法,不推荐使用

	 - parameter url:     url
	 - parameter param:   参数
	 - parameter success: 成功返回:anyobject
	 - parameter fail:    失败返回
	 */
	public func oldHttpRequest(url: String, param: [String : AnyObject]!, success: QPOldSuccessBlock!, fail: QPFailBlock!) {
		Alamofire.request(.POST, url, parameters: param).responseJSON { response in
			if response.response?.statusCode >= 200 && response.response?.statusCode < 300 {
				if response.result.isSuccess {
					success(response: response.result.value)
				} else {
					if let str = String(data: response.data!, encoding: NSUTF8StringEncoding) {
//						let json = JSON(str)
						success(response: str)
					} else {
						fail()
					}
				}
			} else {
				debugPrint(response)
				fail()
			}
		}
	}

	/**
	 新的http方法,推荐使用

	 - parameter url:     url
	 - parameter param:   参数
	 - parameter success: 成功 JSON
	 - parameter fail:    失败
	 */
	public func newHttpRequest(url: String, param: [String : AnyObject]!, success: QPSuccessBlock!, fail: QPFailBlock!) -> () {

		let sss = AFHTTPRequestSerializer()
		let req = NSURLRequest(URL: NSURL(string: url)!)
//		sss.requestBySerializingRequest(req, withParameters: param, error: nil)
		sss.requestWithMethod("POST", URLString: url, parameters: param, error: nil)

		let mgr = AFHTTPSessionManager()

		mgr.dataTaskWithRequest(req) { (response, obj, error) -> Void in
			print("\(response) \(obj) \(error)")
		}
//		mgr.responseSerializer.acceptableContentTypes?.insert("text/plain;charset=UTF-8")
//		mgr.responseSerializer.acceptableContentTypes?.insert("text/plain")
//		mgr.POST(url, parameters: param, constructingBodyWithBlock: { (mutipartData) -> Void in
//
//			let image = UIImage(named: "testing")!
//			let dataObj = UIImageJPEGRepresentation(image, 1.0)!
////			mutipartData.appendPartWithFileData(dataObj, name: "cj2", fileName: "image.png", mimeType: "multipart/form-data")
//			}, progress: { (progess) -> Void in
//			print("\(progess)")
//			}, success: { (task, object) -> Void in
//			print("\(object)")
//			if let obj = object {
//				let json = JSON(obj)
//				let type = json["title"].stringValue
//				print(type)
//			}
//			}, failure: { (task, error) -> Void in
//			task?.response
//			print("\(error)")
//		})

		/*
		 public void testing(){
		 HashMap<String, String> map = new HashMap<>();
		 try {
		 File file = getFileParam("imageFile", "image/dg");
		 if (file == null ){
		 map.put("fail", "fail");
		 renderJson(map);
		 }else{
		 map.put("success", "success");
		 renderJson(map);
		 }
		 } catch (Exception e) {
		 map.put("error", "error "+ e);
		 renderJson(map);
		 }
		 }
		 */

		let request = Alamofire.request(.POST, url, parameters: param).responseJSON { response in
			if response.response?.statusCode >= 200 && response.response?.statusCode < 300 {
				if response.result.isSuccess {
					if let value = response.result.value {
						let json = JSON(value)
						success(response: json)
						log.outputLogLevel = .Verbose
					} else {
						// TODO:
						log.error("network exception which I haven't deal with it")
						assertionFailure("network exception which I haven't deal with it")
						fail()
					}
				} else {
					if let str = String(data: response.data!, encoding: NSUTF8StringEncoding) {
						let json = JSON(str)
						success(response: json)
					} else {
						fail()
					}
				}
			} else {
				debugPrint(response)
				fail()
			}
		}
//		return request
	}

	func uploadFile(url: String, images: Array<UIImage>) {
		// TODO:
		Alamofire.upload(.POST, "", multipartFormData: { (multipartFormData) -> Void in
			for image in images {
				let index = images.indexOf(image)
				let name = "pic\(index)"
				print("name \(name)")
				let dataObj = UIImageJPEGRepresentation(image, 1.0)!
				multipartFormData.appendBodyPart(data: dataObj, name: name)
			}
			}, encodingCompletion: { (encodingResult) -> Void in
			switch encodingResult {
			case .Success(let upload, _, _):
				upload.responseJSON { response in
					debugPrint(response)
				}.progress({ (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) -> Void in
					print("\(bytesWritten) \(totalBytesWritten) \(totalBytesExpectedToWrite)")
				})
			case .Failure(let encodingError):
				print(encodingError)
			}
		})
	}

//    private func newHttpRequet(url: String, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, fail: CJWFailBlock!){
////        CJWNetworkActivityIndicator.startIndicator()
//        print("url \(url) param \(param)")
//        httpManager.POST(url, parameters: param, success: { (operation, responseObject) -> Void in
//            CJWNetworkActivityIndicator.stopIndicator   ()
//            success(responseObject)
//            }) { (operation, error) -> Void in
//                CJWNetworkActivityIndicator.stopIndicator()
//                if let statusCode = operation!.response?.statusCode {
//                    if statusCode == 200 {
//                        success(operation!.responseString)
//                        return
//                    }
//                }
//                print("url:\(url)\n\(error) \(operation!.responseString)")
//                fail()
//        }
//
//    }
//    func requestUrlWithCache(url: String!, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, failure: CJWFailBlock!){
//        let key = "\(url)-\(param)"
//        var compare : AnyObject = ""
//        if let result = QPCacheUtils.getCacheBy(key) {
//            compare = result
//            success(result)
//        }else{
//            print("object from cache fail \(key)")
//        }
//        requestUrl(url, param: param, success: { (resp) -> Void in
//            if compare.isEqual(resp){
//            }else{
//                success(resp)
//                QPCacheUtils.cache(resp, forKey: key, toDisk: true)
//            }
//
//            }) { () -> Void in
//                failure()
//        }
//    }
//
//    func requestUrl(url: String!, param: [NSObject : AnyObject]!, success: CJWSuccessBlock!, fail: CJWFailBlock!) {
//        var newParam = addAuth(param)
//        if url == URL_LOGIN {
//            newParam = param
//        }
//        //        self.newHttpRequet(url, param: newParam, success: success, fail: fail)
//        self.newHttpRequet(url, param: newParam, success: { (resp) -> Void in
//            if let result = resp as? NSDictionary {
//                if let error = result["error"] as? String {
//                    print("error \(error)")
//                    if error == "logout" {
//                        //                        AppDelegate.toHome()
//                        NSNotificationCenter.defaultCenter().postNotificationName("GoLogin", object: nil)
//                        UIApplication.sharedApplication().keyWindow?.rootViewController?.view.showTemporary("您的账号已在别处登录")
//                        fail()
//                        return
//                    }else if error == "nologin" {
////                        self.http.login({ () -> () in
////                            self.newHttpRequet(url, param: self.addAuth(param), success: { (reps) -> Void in
////                                success(resp)
////                                }, fail: { () -> Void in
////                                    fail()
////                            })
////                            }, loginFailBlock: { (text) -> () in
////                                fail()
////                            }, failure: { () -> Void in
////                                fail()
////                        })
//                        return
//                    }
//                }
//            }
//            success(resp)
//            }) { () -> Void in
//                fail()
//        }
//
//    }
//
//    private func pushId() -> String{
//        return QPPushUtils.getPushID()
//    }
//
//    func addAuth(param: [NSObject : AnyObject]!) -> [NSObject : AnyObject]!{
//        if param == nil {
//            return param
//        }else{
//            let newParam = NSMutableDictionary(dictionary: param as NSDictionary)
//            if QPMemberUtils.sharedInstance.memberId != -1 {
//                let uid = QPMemberUtils.sharedInstance.memberId
//                let session = QPHttpUtils.sharedInstance.sessionKey
//                let str = "\(uid)-\(pushId())"
//                let auth = CJWDesEncrypt.encrypt(str, key: session)
//                print("\(str) \(auth) \(session)")
//                newParam.setValue(auth, forKey: "auth")
//                return newParam as [NSObject : AnyObject]
//            }
//            return newParam as [NSObject : AnyObject]
//        }
//    }
}

public extension NSObject {
//	public var http : QPHttpUtils {
//		return QPHttpUtils.sharedInstance
//	}
}
