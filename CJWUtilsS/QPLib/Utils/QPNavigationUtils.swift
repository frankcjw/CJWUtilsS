//
//  QPNavigationUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 9/10/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import MapKit

class QPNavigationUtils: NSObject {
	class func toBaiduMap(latitude: Double, longitude: Double, name: String) -> Bool {

		let url = "baidumap://map/direction?destination=\(latitude),\(longitude)&origin=我的位置&name=\(name)&region=珠海&mode=transit&src=CardPool|CardPool"
		log.debug("url \(url)")
		let encodeNaviString: String = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		let flag = UIApplication.sharedApplication().openURL(NSURL(string: encodeNaviString)!)
		log.debug("flag \(flag)")
		return flag
	}

	class func toGaodeMap(latitude: Double, longitude: Double, name: String) -> Bool {
		var url = "http://m.amap.com/?q=\(latitude),\(longitude)&name=\(name)"
		url = "iosamap://path?sourceApplication=卡仆会员&slat=\(QPLocationUtils.sharedInstance.latitude)&slon=\(QPLocationUtils.sharedInstance.longitude)&sname=我的位置&dname=\(name)&dev=0&m=0&t=0&dlat=\(latitude)&dlon=\(longitude)&backScheme=VIPCardPool"
		url.urlEncode()
		let flag = url.openUrl()
		log.debug("flag \(flag) \(url)")
		return flag
	}

	class func toSystemMap(latitude: Double, longitude: Double, name: String, address: String?) -> Bool {

		let to = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
		let currentLocation = MKMapItem.mapItemForCurrentLocation()

		let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: to, addressDictionary: nil))

		if address != nil {
			toLocation.name = address
		}

		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: NSNumber(bool: true)]
		let flag = MKMapItem.openMapsWithItems([currentLocation, toLocation], launchOptions: launchOptions)

		return flag
	}

}
