////
////  QPMapViewController.swift
////  CJWUtilsS
////
////  Created by Frank on 9/10/16.
////  Copyright © 2016 cen. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class QPMapViewController: GDMapViewController {
//	var addressName: String?
//
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		showNavigation()
//		self.title = "地图"
////		if let addressName = addressName {
////			showDetail("", address: addressName)
////		}
//	}
//}
//
//extension QPMapViewController {
//	private func showNavigation() {
//		let btn = UIBarButtonItem(title: "导航", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(QPMapViewController.showSelection))
//		self.navigationItem.rightBarButtonItem = btn
//	}
//
//	func showSelection() {
//		let actionSheet = UIActionSheet(title: "导航", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "使用苹果地图导航", "使用高德地图导航", "使用百度地图导航")
//		actionSheet.showInView(self.view)
//	}
//}
//
//extension QPMapViewController: UIActionSheetDelegate {
//	func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
//		var flag = false
//		let address = addressName
//		let rootView = self.view
//		if buttonIndex == 1 {
//			flag = QPNavigationUtils.toSystemMap(self.latitude!, longitude: self.longitude!, name: "", address: address)
//			if !flag {
//				rootView.showTemporary("使用苹果地图导航失败")
//			}
//		} else if buttonIndex == 3 {
//			let location = VIPMapUtils.gcj02ToBd09(CLLocationCoordinate2DMake(self.latitude!, self.longitude!))
//			flag = QPNavigationUtils.toBaiduMap(location.latitude, longitude: location.longitude, name: address ?? "")
//			if !flag {
//				rootView.showTemporary("导航失败,请检查是否安装百度地图")
//			}
//		} else if buttonIndex == 2 {
//			flag = QPNavigationUtils.toGaodeMap(self.latitude!, longitude: self.longitude!, name: address ?? "")
//			if !flag {
//				rootView.showTemporary("导航失败,请检查是否安装高德地图")
//			}
//		} else if buttonIndex == 0 {
//			return
//		}
//	}
//
//	private func toSystemNavigation() {
//		var url = "http://maps.apple.com/maps?daddr=\(self.latitude!),\(self.longitude!)&saddr=我的位置"
////        url.
////		url = url.urlEncode()
//		url.urlEncode()
//		let to = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
//		let currentLocation = MKMapItem.mapItemForCurrentLocation()
//
//		let toLocation = MKMapItem(placemark: MKPlacemark(coordinate: to, addressDictionary: nil))
//
//		QPNavigationUtils.toBaiduMap(self.latitude!, longitude: self.longitude!, name: addressName ?? "")
//
//		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsShowsTrafficKey: NSNumber(bool: true)]
//		MKMapItem.openMapsWithItems([currentLocation, toLocation], launchOptions: launchOptions)
//	}
//}
