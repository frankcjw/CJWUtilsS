//
//  QPUtils.swift
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

import UIKit
import SDWebImage
import NSDate_TimeAgo
import FLKAutoLayout
import SwiftyJSON
import PhoneNumberKit
import Alamofire

public let UIControlEventsTouchUpInside = UIControlEvents.TouchUpInside
public let UIControlStateNormal = UIControlState.Normal
public let UIControlStateSelected = UIControlState.Selected
public let UIControlStateHighlighted = UIControlState.Highlighted

public typealias QPNormalBlock = () -> ()

public class QPUtils: NSObject {

	public class var sharedInstance: QPUtils {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPUtils()
		}
		return Static.instance!
	}

	public var config = QPConfig()
}

public extension QPUtils {
	/**
	 获取系统图片缓存大小

	 - returns:
	 */
	public class func getSystemCacheSize() -> String {
		let units = ["B", "K", "M", "G"]
		let size = SDImageCache.sharedImageCache().getSize()
		var calc = NSNumber(unsignedLong: size).integerValue
		var value = ""
		var unitIndex = 0
		for _ in 0 ... units.count - 1 {
			if calc > 1024 * 2 {
				calc = calc / 1024
				unitIndex += 1
			} else {
				break
			}
		}
		value = "\(calc)\(units[unitIndex])"
		log.debug("缓存大小:\(value) \(size)")
		return value
	}

	class func clearSystemCache(block: () -> ()) {
		let tmpView = UIApplication.sharedApplication().keyWindow?.rootViewController?.view
		tmpView?.showHUDwith("正在清理缓存")
		QPExcuteDelay.excute(2, block: { () -> () in
			SDImageCache.sharedImageCache().clearDiskOnCompletion { () -> Void in
				tmpView!.showTemporary("清除成功")
				block()
			}
		})
	}

	class func isSMSRequestAvailable() -> Bool {
		// TODO:是否能发送短信
//        let key = "SMSTime"
//        if let time = QPKeyChainUtils.stringForKey(key) {
//            let fmt = NSDateFormatter()
//            fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let smsTime = fmt.dateFromString(time)
//            print("smsTime \(smsTime) \(NSDate())")
//            if smsTime?.minutesBeforeDate(NSDate()) >= 1 {
//                return true
//            }else{
//                return false
//            }
//        }else{
//            return true
//        }
		assertionFailure("library not been setup")
		return false
	}

	public class func updateSMSRequestTime() {
		// TODO:还不能用
		let key = "SMSTime"
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let time = fmt.stringFromDate(NSDate())
		QPKeyChainUtils.setString(time, forKey: key)
	}
}

let DATE_FORMAT = "HH:mm"

/// Array<NSDictionary>
public typealias NSInfoArray = Array<NSDictionary>

// MARK: - 计算view尺寸
public extension String {

	private var MAX_HEIGHT: CGFloat {
		return 9999
	}

	private var MAX_WIDTH: CGFloat {
		return SCREEN_WIDTH
	}

	public func calculateSizeHeight(font: UIFont, width: CGFloat) -> CGFloat {
		return calculateSize(font, width: width).height
	}

	public func calculateWidth(font: UIFont, height: CGFloat) -> CGFloat {
		var size = CGSizeMake(MAX_WIDTH, height)
		let dict = [NSFontAttributeName: font]
		size = self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict, context: nil).size
		return size.width
	}

	public func calculateSize(font: UIFont, width: CGFloat) -> CGSize {
		var size = CGSizeMake(width, MAX_HEIGHT)
		let dict = [NSFontAttributeName: font]
		size = self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict, context: nil).size
		return size
	}
}

public extension String {
	public func length() -> Int {
		return self.characters.count
	}
}

// MARK: - 时间转换
public extension Double {
	public func convertToDateString() -> String {
		let time = self / 1000 - NSTimeIntervalSince1970
		let date = NSDate(timeIntervalSinceReferenceDate: time)
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let realDate = fmt.stringFromDate(date)
		return realDate
	}

	public func convertToDateString(formatt: String) -> String {
		let time = self / 1000 - NSTimeIntervalSince1970
		let date = NSDate(timeIntervalSinceReferenceDate: time)
		let fmt = NSDateFormatter()
		fmt.dateFormat = formatt as String
		let realDate = fmt.stringFromDate(date)
		return realDate
	}

	public func convertToDateStringForComment() -> String {
		let now = NSDate()
		let time = self / 1000 - NSTimeIntervalSince1970
		let date = NSDate(timeIntervalSinceReferenceDate: time)
		let gap = now.timeIntervalSinceDate(date)
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd"
		if gap >= 60 {
			if fmt.stringFromDate(now) == fmt.stringFromDate(date) {
				fmt.dateFormat = "HH:mm"
			}
			let realDate = fmt.stringFromDate(date)
			return realDate
		}
		return "刚刚"
	}

	func convertToDateStringForActivity() -> String {
//        let now = NSDate()
//        let time = self / 1000 - NSTimeIntervalSince1970
//        let date = NSDate(timeIntervalSinceReferenceDate: time)
//        let gap = now.timeIntervalSinceDate(date)
//        let fmt = NSDateFormatter()
//        fmt.dateFormat = "yyyy-MM-dd"
//        let dateString = fmt.stringFromDate(date)
//        fmt.dateFormat = "HH:mm"
//        let timeString = fmt.stringFromDate(date)
//        var weekDay = ""
//        if date.weekday == 1{
//            weekDay = "星期日"
//        }else if date.weekday == 2{
//            weekDay = "星期一"
//        }else if date.weekday == 3{
//            weekDay = "星期二"
//        }else if date.weekday == 4{
//            weekDay = "星期三"
//        }else if date.weekday == 5{
//            weekDay = "星期四"
//        }else if date.weekday == 6{
//            weekDay = "星期五"
//        }else if date.weekday == 7{
//            weekDay = "星期六"
//        }
//        return dateString + " " + weekDay + " " + timeString
		assertionFailure("library not been setup")
		return ""
	}

	func convertToDateStringForChat() -> String {
		let now = NSDate()
		let time = self / 1000 - NSTimeIntervalSince1970
		let date = NSDate(timeIntervalSinceReferenceDate: time)
		let gap = now.timeIntervalSinceDate(date)
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy/MM/dd"
		if gap >= 60 {
//            if date.isEqualToDateIgnoringTime(NSDate(daysBeforeNow: 3)) && (gap <= 604800) {
//                if date.weekday == 1{
//                    return "星期日"
//                }else if date.weekday == 2{
//                    return "星期一"
//                }else if date.weekday == 3{
//                    return "星期二"
//                }else if date.weekday == 4{
//                    return "星期三"
//                }else if date.weekday == 5{
//                    return "星期四"
//                }else if date.weekday == 6{
//                    return "星期五"
//                }else if date.weekday == 7{
//                    return "星期六"
//                }
//            }
//            if date.isEqualToDateIgnoringTime(NSDate(daysBeforeNow: 2)){
//                return "前天"
//            }
//            if date.isYesterday(){
//                return "昨天"
//            }
			if fmt.stringFromDate(now) == fmt.stringFromDate(date) {
				fmt.dateFormat = "HH:mm"
			}
			let realDate = fmt.stringFromDate(date)
			return realDate
		}
		return "刚刚"
	}
}

public extension NSDate {
	public func convertToDateString() -> String {
		let date = self
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
		let realDate = fmt.stringFromDate(date)
		return realDate
	}

	public func convertToDateString2() -> String {
		let date = self
		let fmt = NSDateFormatter()
		fmt.dateFormat = "yyyy-MM-dd"
		let realDate = fmt.stringFromDate(date)
		return realDate
	}
}

public typealias QPDelayBlock = () -> ()

/// 延时执行
public class QPExcuteDelay: NSObject {

	public class func excute(timeDelay: NSTimeInterval, block: QPDelayBlock) {
		let ttt: Int64 = Int64(timeDelay)
		let time = dispatch_time(DISPATCH_TIME_NOW, ttt * (Int64)(1 * NSEC_PER_SEC))
		dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
			block()
		}
	}
}

/// 延时执行
public extension NSObject {
	/**
	 延时执行

	 - parameter timeDelay: 延时
	 - parameter block:     block
	 */
	public func excute(timeDelay: NSTimeInterval, block: QPDelayBlock) {
		QPExcuteDelay.excute(timeDelay, block: block)
	}
}

// MARK: - 数字转ascii字符
public extension Int {
	public func character() -> String {
		let character = Character(UnicodeScalar(65 + self))
		return "\(character)"
	}
}

public extension Int {
	/**
	 范围内随机数

	 - returns:
	 */
	public func random() -> Int {
		return Int(arc4random_uniform(UInt32(abs(self))))
	}

	public func indexRandom() -> [Int] {
		var newIndex = 0
		var shuffledIndex: [Int] = []
		while shuffledIndex.count < self {
			newIndex = Int(arc4random_uniform(UInt32(self)))
			if !(shuffledIndex.indexOf(newIndex)! + 1 > 0) {
				shuffledIndex.append(newIndex)
			}
		}
		return shuffledIndex
	}
}

public extension Array {
	/**
	 Array洗牌

	 - returns: <#return value description#>
	 */
	public func shuffle() -> [Element] {
		var shuffledContent: [Element] = []
		let shuffledIndex: [Int] = self.count.indexRandom()
		for i in 0 ... shuffledIndex.count - 1 {
			shuffledContent.append(self[shuffledIndex[i]])
		}
		return shuffledContent
	}
	public mutating func shuffled() {
		var shuffledContent: [Element] = []
		let shuffledIndex: [Int] = self.count.indexRandom()
		for i in 0 ... shuffledIndex.count - 1 {
			shuffledContent.append(self[shuffledIndex[i]])
		}
		self = shuffledContent
	}
	/**
	 随机选择其中一个元素

	 - returns:
	 */
	public func chooseOne() -> Element {
		return self[Int(arc4random_uniform(UInt32(self.count)))]
	}
	public func choose(x: Int) -> [Element] {
		var shuffledContent: [Element] = []
		let shuffledIndex: [Int] = x.indexRandom()
		for i in 0 ... shuffledIndex.count - 1 {
			shuffledContent.append(self[shuffledIndex[i]])
		}
		return shuffledContent
	}
}

public extension Array where Element: Equatable {

	/**
	 移除array里面的元素

	 - parameter element: 元素index

	 - returns:
	 */
	public mutating func removeElement(element: Element) -> Element? {
		if let index = indexOf(element) {
			return removeAtIndex(index)
		}
		return nil
	}

	public mutating func removeAllOccurrencesOfElement(element: Element) -> Int {
		var occurrences = 0
		while true {
			if let index = indexOf(element) {
				removeAtIndex(index)
				occurrences += 1
			} else {
				return occurrences
			}
		}
	}
}

public extension QPUtils {
	public class func passwordValidator(password: String) -> Bool {
		var letterCounter = 0
		var digitCount = 0
		let phrase = password
		for scalar in phrase.unicodeScalars {
			let value = scalar.value
			if (value >= 65 && value <= 90) || (value >= 97 && value <= 122) {
				letterCounter = letterCounter + 1
			}
			if (value >= 48 && value <= 57) {
				digitCount = digitCount + 1
			}
		}
		if digitCount > 0 && letterCounter > 0 && password.length() > 7 {
			return true
		} else {
			return false
		}
	}
}

public extension NSDictionary {
	public var id: Int {
		if let tmp = self["id"] as? Int {
			return tmp
		}
		return -1
	}
}

// MARK: - autoLayout
public extension UIView {

	// MARK: - leading
	public func leadingAlign(view: UIView) {
		self.leadingAlign(view, predicate: "8")
	}

	public func leadingAlign(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignLeadingEdgeWithView(view, predicate: predicate)
	}

	public func leadingConstrain(view: UIView) {
		leadingConstrain(view, predicate: "8")
	}

	public func leadingConstrain(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainLeadingSpaceToView(view, predicate: predicate)
	}

	// MARK: - trailing
	@available( *, deprecated, message = "use trailingAlign: instead", renamed = "trailingAlign")
	public func trailing(view: UIView, predicate: String = "-8") {
		self.trailingAlign(view, predicate: predicate)
	}

	public func trailingAlign(view: UIView) {
		trailingAlign(view, predicate: "-8")
	}

	public func trailingAlign(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignTrailingEdgeWithView(view, predicate: predicate)
	}

	public func trailingConstrain(view: UIView) {
		trailingConstrain(view, predicate: "-8")
	}

	public func trailingConstrain(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainTrailingSpaceToView(view, predicate: predicate)
	}

	// MARK: - top

	public func topAlign(view: UIView) {
		topAlign(view, predicate: "8")
	}

	public func topAlign(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignTopEdgeWithView(view, predicate: predicate)
	}

	@available( *, deprecated, message = "use topConstrain: instead", renamed = "topConstrain")
	public func top(view: UIView, predicate: String = "8") {
		self.topConstrain(view, predicate: predicate)
	}

	public func topConstrain(view: UIView) {
		topConstrain(view, predicate: "8")
	}

	public func topConstrain(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainTopSpaceToView(view, predicate: predicate)
	}

	// MARK: - bottom
	public func bottomAlign(view: UIView) {
		self.bottomAlign(view, predicate: "-8")
	}

	public func bottomAlign(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignBottomEdgeWithView(view, predicate: predicate)
	}

	@available( *, deprecated, message = "use bottomAlign: instead", renamed = "bottomAlign")
	public func bottom(view: UIView, predicate: String = "-8") {
		self.bottomAlign(view, predicate: predicate)
	}

	public func bottomConstrain(view: UIView) {
		self.bottomConstrain(view, predicate: "0")
	}

	public func bottomConstrain(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainBottomSpaceToView(view, predicate: predicate)
	}

	// MARK: - other
	public func centerX(view: UIView) {
		self.centerX(view, predicate: "0")
	}

	public func centerX(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignCenterXWithView(view, predicate: predicate)
	}

	public func centerY(view: UIView) {
		self.centerY(view, predicate: "0")
	}

	public func centerY(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.alignCenterYWithView(view, predicate: predicate)
	}

	public func width(view: UIView) {
		self.width(view, predicate: "0")
	}

	public func width(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainWidthToView(view, predicate: predicate)
	}

	public func widthConstrain(predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainWidth(predicate)
	}

	public func height(view: UIView) {
		self.height(view, predicate: "0")
	}

	public func height(view: UIView, predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainHeightToView(view, predicate: predicate)
	}

	public func heightConstrain(predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainHeight(predicate)
	}

	public func aspectRatio() {
		self.aspectRatio("0")
	}

	public func aspectRatio(predicate: String) {
		let predicate = predicate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
		self.constrainAspectRatio(predicate)
	}

	public func equalConstrain() {
		if let view = self.superview {
			self.leadingAlign(view, predicate: "0")
			self.trailingAlign(view, predicate: "0")
			self.topAlign(view, predicate: "0")
			self.bottomAlign(view, predicate: "0")
		}
	}

	/**
	 设置autoLayout
	 */
	public func autoLayout() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}

	public func setupConstraints() {
		self.setNeedsUpdateConstraints()
		self.updateConstraintsIfNeeded()
	}
}

class QPCurrentCity: NSObject {
	// TODO: 获取当前城市
	/// 获取当前城市

	class var sharedInstance: QPCurrentCity {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPCurrentCity? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPCurrentCity()
		}
		return Static.instance!
	}

	var gpsCity: String?
	var citys: NSArray = NSArray()

	class func getCurrentCity() -> String {
		if let city = getCurrentCityInfo() {
			if let name = city["name"] as? String {
				return name
			}
		}
		return ""
	}

	class func getCurrentCityInfo() -> NSDictionary? {
		if let city = QPCacheUtils.sharedInstance.cacheBy("currentCity") as? NSDictionary {
			return city
		}
		return nil
	}

	class func getCurrentCityId() -> Int? {
		if let city = getCurrentCityInfo() {
			if let id = city["id"] as? Int {
				return id
			}
		}
		return nil
	}

	/// 初始化当前城市,如果城市为空,保存;非空,则不执行任何操作
	class func initCity(city: NSDictionary) {
		if !QPCacheUtils.sharedInstance.cacheIsExist("currentCity") {
			QPCacheUtils.sharedInstance.cache(city, forKey: "currentCity")
		}
	}

	/// 保存当前城市
	class func saveCity(city: NSDictionary) {
		QPCacheUtils.sharedInstance.cache(city, forKey: "currentCity")
	}

	class func saveCityName(city: String) {
		for info in QPCurrentCity.sharedInstance.citys as! [NSDictionary] {
			if let name = info["name"] as? String {
				if name == city {
					saveCity(info)
				}
			}
		}
	}

	class func isCurrentCity(city: String) -> Bool {
		let currentCity = getCurrentCity()
		if currentCity == city {
			return true
		} else {
			return false
		}
	}
}

public extension String {
	public mutating func urlEncode() -> Bool {
		if let safeURL = self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
			self = safeURL
			return true
		}

		return false
	}

	public func openUrl() -> Bool {
		let flag = UIApplication.sharedApplication().openURL(NSURL(string: self)!)
		return flag
	}

	public func nsurl() -> NSURL? {
		return NSURL(string: self)
	}
}

public extension String {
	public func isMobile() -> Bool {
		// TODO: isMobile
//		log.warning("not been setup")
//        return "".isValidateMobile(self)

		do {
			let number = self
			let phoneNumber = try PhoneNumber(rawNumber: number, region: "CN")

//			log.debug("\(phoneNumber.isValidNumber) \(phoneNumberCustomDefaultRegion.isValidNumber)")
//			log.warning("\(phoneNumber.numberExtension) \(phoneNumber.type) \(phoneNumberCustomDefaultRegion.toE164())")
			if phoneNumber.type == .Mobile {
				return true
			}
			return false
		}
		catch {
			log.debug("Generic parser error")
		}

		return false
	}

	func isEmail() -> Bool {
		// TODO: isEmail
//        return "".isValidateEmail(self)
		log.warning("not been setup")
		return false
	}

	func isPhone() -> Bool {
		let phoneRegex = "(([0-9]{4})|([0-9]{3}))-([0-9]{8})"
		let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
		return phoneTest.evaluateWithObject(self)
	}
}

public extension String {
	public mutating func insert(string: String, ind: Int) -> String {
		let str = String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count - ind))
		self = str
		return str
	}
}

public extension UITextField {

	public func valid() -> Bool {
		if text != nil && text! != "" {
			return true
		}
		return false
	}

	func isMobile() -> Bool {
		if let txt = self.text {
			if txt != "" {
				if txt.isMobile() {
					return true
				}
			}
		}
		return false
	}
}
public extension UITextField {
	public var textValue: String {
		if let txt = text {
			return txt
		} else {
			return ""
		}
	}
}

public extension Double {
	/**
	 小数点后取几位

	 - parameter scale: 后几位

	 - returns:
	 */
	public func subDouble(scale: Int) -> Double {
		var dec = NSDecimalNumber(double: self)
		let behavior = NSDecimalNumberHandler(roundingMode: NSRoundingMode.RoundPlain, scale: NSNumber(integer: scale).shortValue, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
		dec = dec.decimalNumberByRoundingAccordingToBehavior(behavior)
		return dec.doubleValue
	}
}
public extension String {
	func valid() -> Bool {
		if self == "" || self.length() <= 0 {
			return false
		}
		return true
	}
}

public extension String {
	func dial() -> Bool {

		if valid() {
			let tel = "tel:\(self)"
			if let nsurl = NSURL(string: tel) {
				return UIApplication.sharedApplication().openURL(nsurl)
			}
		}
		return false
	}
}

public extension UIButton {
	public func addTarget(targte: AnyObject?, action: Selector) {
		self.addTarget(targte, action: action, forControlEvents: UIControlEvents.TouchUpInside)
	}
}

public extension NSDictionary {
	public func toJSON() -> JSON {
		return JSON(self)
	}

	public func toJsonString() -> String {
		do {
			let jsonData = try NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)
			if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String {
				return jsonString
			} else {
				log.error("json string error")
			}
		} catch let error as NSError {
			log.error("\(error)")
		}
		return ""
	}
}

public extension JSON {
	public func toJSONString() -> String {
		if let value = self.object as? String {
			return value
		} else if let value = self.object as? NSArray {
			return value.toJsonString()
		} else if let value = self.object as? NSDictionary {
			return value.toJsonString()
		} else {
			return ""
		}
	}
}

public extension NSArray {
	public func toJSON() -> JSON {
		let json = JSON(self)
		return json
	}

	public func toJsonString() -> String {
		do {
			let jsonData = try NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted)
			if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) as? String {
				return jsonString
			} else {
				log.error("json string error")
			}
		} catch let error as NSError {
			log.error("\(error)")
		}
		return ""
	}
}

public extension String {

	/**
	 截取string,例:"abc"[0...1]

	 - parameter r: 范围

	 - returns: 截取的string
	 */
	public subscript(r: Range<Int>) -> String {
		get {
			let startIndex = self.startIndex.advancedBy(r.startIndex)
			let endIndex = self.startIndex.advancedBy(r.endIndex)

			return self[Range(startIndex ..< endIndex)]
		}
	}

	/**
	 短String在长String中的范围

	 - parameter string: 短String

	 - returns: 范围的数组
	 */
	public func rangesOfString(string: String) -> Array<Range<Index>> {
		var array = Array<Range<Index>>()
		let range = self.rangeOfString(string)
		if range != nil {
			array.append(range!)
			let rangeEndIndex = range?.endIndex
			if rangeEndIndex < self.endIndex {
				let substring = self.substringFromIndex(rangeEndIndex!)
				let ranges = substring.rangesOfString(string)
				for substringRange in ranges {
					let startIntIndex: Int = self.startIndex.distanceTo(rangeEndIndex!) + substring.startIndex.distanceTo(substringRange.startIndex)
					let endIntIndex: Int = startIntIndex + substringRange.startIndex.distanceTo(substringRange.endIndex)
					let startIndex = self.startIndex.advancedBy(startIntIndex)
					let endIndex = self.startIndex.advancedBy(endIntIndex)
					array.append(Range(startIndex ..< endIndex))
				}
			}
			return array
		}
		return Array<Range<Index>>()
	}
}

public extension UIView {
	public var autoWidth: CGFloat {
		return self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).width
	}
	public var autoHeight: CGFloat {
		return self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
	}
}

public struct QPConfig {
	public var hidesBottomBarWhenPushed = true
	/// 高德地图api key
	public var gdMapApiKey = "2bab86f775329259bdbd7c68f520641c"
}

public extension String {
	/**
	 中文转拼音,未完全测试

	 - returns: 拼音字母
	 */
	public func toPY() -> String {
		let mutableString = NSMutableString(string: self) as CFMutableStringRef
		CFStringTransform(mutableString, nil, kCFStringTransformMandarinLatin, false)
		CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
		let string = mutableString as String
		return string.uppercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
	}
}

public extension String {
	func addParam(param: [String: AnyObject]?) -> String {
		if let param = param {
			let URL = NSURL(string: self)
			let mutableURLRequest = NSMutableURLRequest(URL: URL!)
			let paramUrl = Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: param).0.URLString
//			self = paramUrl
			return paramUrl
		} else {
			return self;
		}
	}
}

// MARK: - convert Struct to JSON
public protocol JSONRepresentable {
	var JSONRepresentation: AnyObject { get }
}

public protocol JSONSerializable: JSONRepresentable {
}

public extension JSONSerializable {
	var JSONRepresentation: AnyObject {
		var representation = [String: AnyObject]()

		for case let (label?, value) in Mirror(reflecting: self).children {
			switch value {
			case let value as JSONRepresentable:
				representation[label] = value.JSONRepresentation

			case let value as NSObject:
				representation[label] = value

			default:
				// Ignore any unserializable properties
				break
			}
		}

		return representation
	}
}

public extension JSONSerializable {
	public func toJSON() -> String? {
		let representation = JSONRepresentation

		guard NSJSONSerialization.isValidJSONObject(representation) else {
			return nil
		}

		do {
			let data = try NSJSONSerialization.dataWithJSONObject(representation, options: [])
			return String(data: data, encoding: NSUTF8StringEncoding)
		} catch {
			return nil
		}
	}
}

