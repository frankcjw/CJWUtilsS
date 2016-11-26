//
//  QPQRCodeViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 11/21/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public class QPQRCodeViewController: UIViewController {

	public typealias QPScanQRCodeViewControllerBlock = (result: String) -> ()

	public var block: QPScanQRCodeViewControllerBlock?

	override public func viewDidLoad() {
		super.viewDidLoad()
		self.title = "扫描二维码"
		self.view.backgroundColor = UIColor.blackColor()
		let scaner = QRCScanner(QRCScannerWithView: self.view)
		scaner.transparentAreaSize = CGSizeMake(300, 300)
		scaner.delegate = self
		self.view.addSubview(scaner)
	}

	public func onScaned(block: QPScanQRCodeViewControllerBlock) {
		self.block = block
	}

	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

extension QPQRCodeViewController: QRCodeScanneDelegate {
	public func didFinshedScanningQRCode(result: String!) {
		log.verbose("result [\(result)]")
		block?(result: result)
		self.navigationController?.popViewControllerAnimated(true)
	}
}
