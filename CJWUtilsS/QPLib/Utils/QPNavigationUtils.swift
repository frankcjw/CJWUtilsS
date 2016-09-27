//
//  QPNavigationUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 9/10/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import MapKit

public class QPNavigationUtils: NSObject {

	public class func toBaiduMap(latitude: Double, longitude: Double, name: String, appName: String) -> Bool {

		let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let bdCoordinate = VIPMapUtils.gcj02ToBd09(coordinate)
		var url = "baidumap://map/direction?destination=\(bdCoordinate.latitude),\(bdCoordinate.longitude)&origin=我的位置&name=\(name)&region=&mode=transit&src=\(appName)|\(appName)"
		url.urlEncode()
		let encodeNaviString: String = url
		let flag = UIApplication.sharedApplication().openURL(NSURL(string: encodeNaviString)!)
		log.debug("flag \(flag)")
		return flag
	}

	public class func toGaodeMap(latitude: Double, longitude: Double, name: String, appName: String, backScheme: String) -> Bool {
		var url = "http://m.amap.com/?q=\(latitude),\(longitude)&name=\(name)"
		// url = "iosamap://path?sourceApplication=\(appName)&slat=\(VIPLocationUtils.sharedInstance.latitude)&slon=\(VIPLocationUtils.sharedInstance.longitude)&sname=我的位置&dname=\(name)&dev=0&m=0&t=0&dlat=\(latitude)&dlon=\(longitude)&backScheme=VIPCardPool"

		url = "iosamap://navi?sourceApplication=\(appName)&backScheme=\(backScheme)&poiname=\(name)&poiid=BGVIS&lat=\(latitude)&lon=\(longitude)&dev=1&style=2"
		url.urlEncode()
		let flag = url.openUrl()
		log.debug("flag \(flag) \(url)")
		return flag
	}

	public class func toSystemMap(latitude: Double, longitude: Double, name: String, address: String?) -> Bool {

		let to = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let currentLocation = MKMapItem.mapItemForCurrentLocation()

		let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: to, addressDictionary: nil))

		if address != nil {
			toLocation.name = address
			// VIPNavigationUtils.toBaiduMap(latitude, longitude: longitude, name: address!)
		}

		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: NSNumber(bool: true)]
		let flag = MKMapItem.openMapsWithItems([currentLocation, toLocation], launchOptions: launchOptions)

		return flag
	}
}

public extension UIViewController {
	public func naviMenu(latitude: Double, longitude: Double, name: String, appName: String, backScheme: String, address: String?) {
		self.showActionSheet("选择导航方式", message: "", buttons: ["百度地图", "高德地图", "苹果地图"]) { (index) in

			switch index {
			case 0:
				let flag = QPNavigationUtils.toBaiduMap(latitude, longitude: longitude, name: name, appName: appName)
				if !flag {
					self.showConfirmAlert("导航失败", message: "请检查是否安装百度地图", confirm: {
					})
				}
				break
			case 1:
				let flag = QPNavigationUtils.toGaodeMap(latitude, longitude: longitude, name: name, appName: appName, backScheme: backScheme)
				if !flag {
					self.showConfirmAlert("导航失败", message: "请检查是否安装高德地图", confirm: {
					})
				}
				break
			case 2:
				QPNavigationUtils.toSystemMap(latitude, longitude: longitude, name: name, address: address)
				break
			default:
				break
			}
		}
	}
}

