////
////  GDMapViewController.swift
////  VIP
////
////  Created by Frank on 6/18/15.
////  Copyright (c) 2015 cen. All rights reserved.
////
//
//import UIKit
//
//private let GD_MAP_APPKEY = "2bab86f775329259bdbd7c68f520641c"
//
//class GDMapViewController: UIViewController, MAMapViewDelegate {
//
//	var map: MAMapView!
//
//	// 纬度
//	var latitude: Double?
//	// 经度
//	var longitude: Double?
//
//	var location: CLLocationCoordinate2D? {
//		didSet {
//			map.setCenterCoordinate(location!, animated: true)
//		}
//	}
//
//	// 地图的缩放级别的范围是[3-19]
//	var zoomLevel: Double = 17
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//
//		AMapServices.sharedServices().apiKey = QPUtils.sharedInstance.config.gdMapApiKey
//		map = MAMapView(frame: self.view.frame)
//		map.delegate = self
//
//		if latitude != nil && longitude != nil {
//			let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//			self.location = location
//
//			map.setCenterCoordinate(location, animated: true)
//
//			let pointAnnotation = MAPointAnnotation()
//			pointAnnotation.coordinate = location
//			pointAnnotation.title = "山盛什么什么什么吊"
//			pointAnnotation.subtitle = "一个小幅小幅标题"
//			map.addAnnotation(pointAnnotation)
//		}
//		map.zoomLevel = zoomLevel
//
//		self.view.addSubview(map)
//	}
//
//	func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
//		log.debug("\(userLocation.location?.coordinate.latitude) \(userLocation.location?.coordinate.longitude)")
//	}
//
//	func reloadLocation() {
//		if latitude != nil && longitude != nil {
//			let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//			self.location = location
//			map.setCenterCoordinate(location, animated: true)
//		}
//	}
//
//	func addPointAnnotation(title: String, subtitle: String, latitude: Double, longitude: Double) {
//		let pointAnnotation = MAPointAnnotation()
//		pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//		pointAnnotation.title = title
//		pointAnnotation.subtitle = subtitle
//		map.addAnnotation(pointAnnotation)
//	}
//
//	override func didReceiveMemoryWarning() {
//		super.didReceiveMemoryWarning()
//	}
//}
