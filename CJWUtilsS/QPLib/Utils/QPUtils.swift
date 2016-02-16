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

public let UIControlEventsTouchUpInside = UIControlEvents.TouchUpInside
public let UIControlStateNormal = UIControlState.Normal
public let UIControlStateSelected = UIControlState.Selected
public let UIControlStateHighlighted = UIControlState.Highlighted

public typealias QPNormalBlock = () -> ()

public class QPUtils: NSObject {

	public class var sharedInstance : QPUtils {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : QPUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPUtils()
		}
		return Static.instance!
	}
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
				unitIndex++
			} else {
				break
			}
		}
		value = "\(calc)\(units[unitIndex])"
		log.debug("缓存大小:\(value) \(size)")
		return value
	}

	class func clearSystemCache(block: () -> ()) {
		// TODO:清理系统缓存
		// let tmpView = UIApplication.sharedApplication().keyWindow?.rootViewController?.view
//        tmpView?.showHUDwith("正在清理缓存")
//        QPExcuteDelay.excute(2, block: { () -> () in
//            SDImageCache.sharedImageCache().clearDiskOnCompletion { () -> Void in
//                tmpView!.showTemporary("清除成功")
//                block()
//            }
//        })
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

	private var MAX_WIDTH : CGFloat {
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
public class QPExcuteDelay : NSObject {

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
				occurrences++
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
				letterCounter++
			}
			if (value >= 48 && value <= 57) {
				digitCount++
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
	public var id : Int {
		if let tmp = self["id"] as? Int {
			return tmp
		}
		return -1
	}
}

// MARK: - autoLayout
public extension UIView {
	// view:UIView,predicate:String
	public func leadingAlign(view: UIView, predicate: String? = "8") {
		self.alignLeadingEdgeWithView(view, predicate: predicate)
	}

	public func leadingConstrain(view: UIView, predicate: String? = "8") {
		self.constrainLeadingSpaceToView(view, predicate: predicate)
	}

	public func trailing(view: UIView, predicate: String? = "-8") {
		self.alignTrailingEdgeWithView(view, predicate: predicate)
	}

	public func topAlign(view: UIView, predicate: String? = "8") {
		self.alignTopEdgeWithView(view, predicate: predicate)
	}

	public func top(view: UIView, predicate: String? = "8") {
		self.constrainTopSpaceToView(view, predicate: predicate)
	}

	public func bottom(view: UIView, predicate: String? = "-8") {
		self.alignBottomEdgeWithView(view, predicate: predicate)
	}

	public func centerX(view: UIView, predicate: String? = "0") {
		self.alignCenterXWithView(view, predicate: predicate)
	}

	public func centerY(view: UIView, predicate: String? = "0") {
		self.alignCenterYWithView(view, predicate: predicate)
	}

	public func width(view: UIView, predicate: String? = "0") {
		self.constrainWidthToView(view, predicate: predicate)
	}

	public func widthConstrain(predicate: String) {
		self.constrainWidth(predicate)
	}

	public func height(view: UIView, predicate: String? = "0") {
		self.constrainHeightToView(view, predicate: predicate)
	}

	public func heightConstrain(predicate: String) {
		self.constrainHeight(predicate)
	}

	public func aspectRatio(predicate: String? = "") {
		self.constrainAspectRatio(predicate)
	}
}

class QPCurrentCity : NSObject {
	// TODO: 获取当前城市
	/// 获取当前城市

	class var sharedInstance : QPCurrentCity {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : QPCurrentCity? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPCurrentCity()
		}
		return Static.instance!
	}

	var gpsCity : String?
	var citys : NSArray = NSArray()

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

extension String {
	func isMobile() -> Bool {
		// TODO: isMobile
		log.warning("not been setup")
//        return "".isValidateMobile(self)
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
