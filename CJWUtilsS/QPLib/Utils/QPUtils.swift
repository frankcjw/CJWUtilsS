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

let UIControlEventsTouchUpInside = UIControlEvents.TouchUpInside
let UIControlStateNormal = UIControlState.Normal
let UIControlStateSelected = UIControlState.Selected
let UIControlStateHighlighted = UIControlState.Highlighted

class QPUtils: NSObject {
    var chatting = false
    var chattingViewController = UIViewController()
    
    var cacheObject : AnyObject?
    
    class var sharedInstance : QPUtils {
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

extension QPUtils {
    class func getSystemCacheSize() -> String {
        let units = ["B","K","M","G"]
        let size = SDImageCache.sharedImageCache().getSize()
        var calc = NSNumber(unsignedLong: size).integerValue
        var value = ""
        var unitIndex = 0
        for _ in 0...units.count - 1 {
            if calc > 1024 * 2 {
                calc = calc / 1024
                unitIndex++
            }else{
                break
            }
        }
        value = "\(calc)\(units[unitIndex])"
        print("缓存大小:\(value) \(size)")
        return value
    }
    
    class func clearSystemCache(block:()->()){
        assertionFailure("library not been setup")
//        let tmpView = UIApplication.sharedApplication().keyWindow?.rootViewController?.view
//        tmpView?.showHUDwith("正在清理缓存")
//        QPExcuteDelay.excute(2, block: { () -> () in
//            SDImageCache.sharedImageCache().clearDiskOnCompletion { () -> Void in
//                tmpView!.showTemporary("清除成功")
//                block()
//            }
//        })
    }
    
    class func isSMSRequestAvailable() -> Bool{
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
    
    class func updateSMSRequestTime(){
        let key = "SMSTime"
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let time = fmt.stringFromDate(NSDate())
        QPKeyChainUtils.setString(time, forKey: key)
    }
}

let DATE_FORMAT = "HH:mm"

/// Array<NSDictionary>
typealias NSInfoArray = Array<NSDictionary>

extension String {
    
    private var MAX_HEIGHT:CGFloat {
        return 9999
    }
    
    private var MAX_WIDTH : CGFloat {
        return SCREEN_WIDTH
    }
    
    func calculateSizeHeight(font:UIFont,width:CGFloat) -> CGFloat{
        return calculateSize(font, width: width).height
    }
    
    func calculateWidth(font:UIFont,height:CGFloat) -> CGFloat{
        var size = CGSizeMake(MAX_WIDTH, height)
        let dict = [NSFontAttributeName:font]
        size = self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict, context: nil).size
        return size.width
    }
    
    func calculateSize(font:UIFont,width:CGFloat) -> CGSize{
        var size = CGSizeMake(width, MAX_HEIGHT)
        let dict = [NSFontAttributeName:font]
        size = self.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: dict, context: nil).size
        return size
    }
    
    func length()->Int{
        return self.characters.count
    }
}

extension Double {
    func convertToDateString() -> String{
        let time = self / 1000 - NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSinceReferenceDate: time)
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let realDate = fmt.stringFromDate(date)
        return realDate
    }
    
    func convertToDateString(formatt:String) -> String{
        let time = self / 1000 - NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSinceReferenceDate: time)
        let fmt = NSDateFormatter()
        fmt.dateFormat = formatt as String
        let realDate = fmt.stringFromDate(date)
        return realDate
    }
    
    func convertToDateStringForComment() -> String{
        let now = NSDate()
        let time = self / 1000 - NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSinceReferenceDate: time)
        let gap = now.timeIntervalSinceDate(date)
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        if gap >= 60{
            if fmt.stringFromDate(now) == fmt.stringFromDate(date){
                fmt.dateFormat = "HH:mm"
            }
            let realDate = fmt.stringFromDate(date)
            return realDate
        }
        return "刚刚"
    }
    
    func convertToDateStringForActivity() -> String{
        let now = NSDate()
        let time = self / 1000 - NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSinceReferenceDate: time)
        let gap = now.timeIntervalSinceDate(date)
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let dateString = fmt.stringFromDate(date)
        fmt.dateFormat = "HH:mm"
        let timeString = fmt.stringFromDate(date)
        var weekDay = ""
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
        return dateString + " " + weekDay + " " + timeString
    }
    
    func convertToDateStringForChat() -> String{
        let now = NSDate()
        let time = self / 1000 - NSTimeIntervalSince1970
        let date = NSDate(timeIntervalSinceReferenceDate: time)
        let gap = now.timeIntervalSinceDate(date)
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy/MM/dd"
        if gap >= 60{
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
            if fmt.stringFromDate(now) == fmt.stringFromDate(date){
                fmt.dateFormat = "HH:mm"
            }
            let realDate = fmt.stringFromDate(date)
            return realDate
        }
        return "刚刚"
    }
}

extension NSDate {
    func convertToDateString() -> String{
        let date = self
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let realDate = fmt.stringFromDate(date)
        return realDate
    }
    
    func convertToDateString2() -> String{
        let date = self
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let realDate = fmt.stringFromDate(date)
        return realDate
    }
}

class QPExcuteDelay : NSObject {
    typealias DelayBlock = () -> ()
    
    class func excute(timeDelay:NSTimeInterval,block:DelayBlock){
        let ttt:Int64 = Int64(timeDelay)
        let time = dispatch_time(DISPATCH_TIME_NOW, ttt * (Int64)(1 * NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            block()
        }
    }
}

extension Int {
    func character() -> String{
        let character = Character(UnicodeScalar(65 + self))
        return "\(character)"
    }
}

extension Int {
    func random() -> Int {
        return Int(arc4random_uniform(UInt32(abs(self))))
    }
    func indexRandom() -> [Int] {
        var newIndex = 0
        var shuffledIndex:[Int] = []
        while shuffledIndex.count < self {
            newIndex = Int(arc4random_uniform(UInt32(self)))
            if !(shuffledIndex.indexOf(newIndex) > -1 ) {
                shuffledIndex.append(newIndex)
            }
        }
        return  shuffledIndex
    }
}

extension Array {
    func shuffle() -> [Element] {
        var shuffledContent:[Element] = []
        let shuffledIndex:[Int] = self.count.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        return shuffledContent
    }
    mutating func shuffled() {
        var shuffledContent:[Element] = []
        let shuffledIndex:[Int] = self.count.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        self = shuffledContent
    }
    func chooseOne() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
    func choose(x:Int) -> [Element] {
        var shuffledContent:[Element] = []
        let shuffledIndex:[Int] = x.indexRandom()
        for i in 0...shuffledIndex.count-1 {
            shuffledContent.append(self[shuffledIndex[i]])
        }
        return shuffledContent
    }
}

extension QPUtils{
    class func passwordValidator(password:String) -> Bool{
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
        }else{
            return false
        }
    }
}

extension NSDictionary {
    var id : Int {
        if let tmp = self["id"] as? Int {
            return tmp
        }
        return -1
    }
}


extension UIView {
    //view:UIView,predicate:String
    func leadingAlign(view:UIView,predicate:String){
        self.alignLeadingEdgeWithView(view, predicate: predicate)
    }
    
    func leadingConstrain(view:UIView,predicate:String){
        self.constrainLeadingSpaceToView(view, predicate: predicate)
    }
    
    func trailing(view:UIView,predicate:String){
        self.alignTrailingEdgeWithView(view, predicate: predicate)
    }
    
    func top(view:UIView,predicate:String){
        self.constrainTopSpaceToView(view, predicate: predicate)
    }
    
    func bottom(view:UIView,predicate:String){
        self.alignBottomEdgeWithView(view, predicate: predicate)
    }
    
    func centerY(view:UIView,predicate:String){
        self.alignCenterYWithView(view, predicate: predicate)
    }
    
    func width(view:UIView,predicate:String){
        self.constrainWidthToView(view, predicate: predicate)
    }
    
    func widthConstrain(predicate:String){
        self.constrainWidth(predicate)
    }
    
    func height(view:UIView,predicate:String){
        self.constrainHeightToView(view, predicate: predicate)
    }
    
    func heightConstrain(predicate:String){
        self.constrainHeight(predicate)
    }
}

class QPCurrentCity : NSObject{
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
    
    class func getCurrentCity() -> String{
        if let city = getCurrentCityInfo(){
            if let name = city["name"] as? String {
                return name
            }
        }
        return ""
    }
    
    class func getCurrentCityInfo() -> NSDictionary?{
        if let city = QPCacheUtils.sharedInstance.cacheBy("currentCity") as? NSDictionary {
            return city
        }
        return nil
    }
    
    class func getCurrentCityId() -> Int?{
        if let city = getCurrentCityInfo(){
            if let id = city["id"] as? Int {
                return id
            }
        }
        return nil
    }
    
    /// 初始化当前城市,如果城市为空,保存;非空,则不执行任何操作
    class func initCity(city:NSDictionary){
        if !QPCacheUtils.sharedInstance.cacheIsExist("currentCity") {
            QPCacheUtils.sharedInstance.cache(city, forKey: "currentCity")
        }
    }
    
    /// 保存当前城市
    class func saveCity(city:NSDictionary){
        QPCacheUtils.sharedInstance.cache(city, forKey: "currentCity")
    }
    
    class func saveCityName(city:String){
        for info in QPCurrentCity.sharedInstance.citys as! [NSDictionary] {
            if let name = info["name"] as? String {
                if name == city {
                    saveCity(info)
                }
            }
        }
    }
    
    class func isCurrentCity(city:String) -> Bool{
        let currentCity = getCurrentCity()
        if currentCity == city {
            return true
        }else{
            return false
        }
    }
}

extension String {
    func isMobile() -> Bool {
//        return "".isValidateMobile(self)
        return false
    }
    
    func isEmail() -> Bool {
//        return "".isValidateEmail(self)
        return false
    }
    
    func isPhone() -> Bool {
        let phoneRegex = "(([0-9]{4})|([0-9]{3}))-([0-9]{8})"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
}

extension UITextField{
    
    func isValid() -> Bool {
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

