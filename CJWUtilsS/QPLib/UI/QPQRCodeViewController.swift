//
//  QPQRCodeViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 11/21/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

class QPQRCodeViewController: UIViewController {

	typealias QPScanQRCodeViewControllerBlock = (result: String) -> ()

	var block: QPScanQRCodeViewControllerBlock?

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "扫描二维码"
		self.view.backgroundColor = UIColor.blackColor()
		let scaner = QRCScanner(QRCScannerWithView: self.view)
		scaner.transparentAreaSize = CGSizeMake(300, 300)
		scaner.delegate = self
//        scane
		self.view.addSubview(scaner)
	}

	func onScaned(block: QPScanQRCodeViewControllerBlock) {
		self.block = block
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension QPQRCodeViewController: QRCodeScanneDelegate {
	func didFinshedScanningQRCode(result: String!) {
		log.verbose("result [\(result)]")
		block?(result: result)
//		self.navigationController?.popViewControllerAnimated(true)
	}
}
