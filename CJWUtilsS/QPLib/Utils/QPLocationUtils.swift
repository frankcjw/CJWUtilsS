//
//  QPLocationUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 9/10/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import ClusterPrePermissions
import INTULocationManager

class QPLocationUtils: NSObject, CLLocationManagerDelegate {
	var locManager: CLLocationManager!
	var latitude: Double?
	var longitude: Double?

	class var sharedInstance: QPLocationUtils {
		struct Static {
			static var onceToken: dispatch_once_t = 0
			static var instance: QPLocationUtils? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = QPLocationUtils()
		}
		return Static.instance!
	}

	override init() {
		super.init()
		locManager = CLLocationManager()
		locManager.delegate = self
		// locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
		locManager.distanceFilter = 100;
		locManager.startUpdatingLocation()
	}

	func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
		log.verbose("newLocation \(newLocation.coordinate.latitude) \(newLocation.coordinate.longitude)")
	}

	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {

		log.error("error \(error)")
		log.error("locManager \(locManager.location?.coordinate.latitude) \(locManager.location?.coordinate.longitude)")
	}

	func onLocated(city: String) {
		var tmpCity: String = (city as String)
		tmpCity = tmpCity.stringByReplacingOccurrencesOfString("市", withString: "")
//		VIPCurrentCity.sharedInstance.gpsCity = tmpCity
//		self.cache(tmpCity, forKey: "GPSCity")
		log.info("current city \(tmpCity)")
	}

	func checkCurrentCity(location: CLLocation) {
		let coder = CLGeocoder()
		coder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
			if placemarks != nil {
				for placemark in placemarks! as [CLPlacemark] {
					if let city: String = placemark.locality {
						self.onLocated(city)
					} else if let city = placemark.administrativeArea {
						self.onLocated(city)
					}
					// log.debug("\(placemark.locality)")
					// log.debug("\(placemark.name)")
					// log.debug("\(placemark.thoroughfare)")
					// log.debug("\(placemark.subThoroughfare)")
					// log.debug("\(placemark.subLocality)")
					// log.debug("\(placemark.administrativeArea)")
					// log.debug("\(placemark.subAdministrativeArea)")
					// log.debug("\(placemark.postalCode)")
					// log.debug("\(placemark.ISOcountryCode)")
					// log.debug("\(placemark.country)")
					// log.debug("\(placemark.ocean)")
					// log.debug("\(placemark.inlandWater)")
					// log.debug("\(placemark.areasOfInterest)")
				}
			}
		})
	}

	func updateCurrentLocation() {
		log.verbose("start locating")
		let locMgr = INTULocationManager.sharedInstance()
		locMgr.requestLocationWithDesiredAccuracy(INTULocationAccuracy.Block, timeout: 99) { (location, accuracy, status) -> Void in
			if status == INTULocationStatus.Success {
				let lat: Double = location.coordinate.latitude
				let lon: Double = location.coordinate.longitude

				let location = CLLocation(latitude: lat, longitude: lon)
				self.checkCurrentCity(location)
				self.latitude = lat
				self.longitude = lon
				let permission = ClusterPrePermissions.locationPermissionAuthorizationStatus()
				if permission == ClusterAuthorizationStatus.Authorized {
					self.cache(lat, forKey: "latitude")
					self.cache(lon, forKey: "longitude")
				} else {
					self.cache(0.0, forKey: "latitude")
					self.cache(0.0, forKey: "longitude")
				}
				log.verbose("INTULocationStatus Success")
			} else {
				log.verbose("INTULocationManager error")
			}
		}
	}

	func haveLoacation() -> Bool {
		if latitude == nil || longitude == nil {
			updateCurrentLocation()
			return false
		} else if latitude > 0 && longitude > 0 {
			return true
		} else {
			return true
		}
	}

	func distanceFromLocation(target: CLLocation) -> Int {
		/*
		 CLLocation *current=[[CLLocation alloc] initWithLatitude:32.178722 longitude:119.508619];
		 //第二个坐标
		 CLLocation *before=[[CLLocation alloc] initWithLatitude:32.206340 longitude:119.425600];
		 // 计算距离
		 CLLocationDistance meters=[current distanceFromLocation:before];
		 */
		if haveLoacation() {
			let location = CLLocation(latitude: latitude!, longitude: longitude!)

			let distance = location.distanceFromLocation(target) as Double
			let dis = NSNumber(double: distance).integerValue
			return dis
		} else {
			return 0
		}
	}

	private let units = ["m", "km"]

	func distanceStringFromLocation(target: CLLocation) -> String {
		let permission = ClusterPrePermissions.locationPermissionAuthorizationStatus()
		if permission == ClusterAuthorizationStatus.Authorized {
			var distance = distanceFromLocation(target)
			var unitIndex = 0
			if distance > 1000 {
				distance = Int(distance / 1000)
				unitIndex += 1
			}
			if distance > 10000 && unitIndex == 1 {
				log.warning("\(distance)\(units[unitIndex])")
				return "距离较远"
			}
			return "\(distance)\(units[unitIndex])"
		}
		return "定位失败"
	}

}
