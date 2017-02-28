//
//  QPPdfViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 25/02/2017.
//  Copyright © 2017 cen. All rights reserved.
//

import UIKit
import CJWUtilsS

public class QPPdfViewController: QPViewController {

	/// /Users/quickplain/Library/Developer/CoreSimulator/Devices/D7582BC0-670B-4060-BF59-6494D745C1F3/data/Containers/Bundle/Application/82BB5FB5-F2B0-4188-A2D9-D09B96C537B9/020Project.app/f.pdf
	public var pdfPath: String = "" {
		didSet {
//			webView.loadRequest(NSURLRequest(URL: NSURL(string: pdfPath)!))

			pdfView.loadPdf(pdfPath)
		}
	}

	public let pdfView = QPPDFView()

	public override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(pdfView)
		pdfView.equalConstrain()
	}

	public override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

public class QPPDFView: UIView {

//	public var pdfPath: String {
//		didSet {
//			webView.loadRequest(NSURLRequest(URL: NSURL(string: pdfPath)!))
//		}
//	}

	let webView = UIWebView()

	public func loadPdf(path: String) {
		var ppp = path
		ppp.urlEncode()
		if let nsurl = NSURL(string: ppp) {
			webView.loadRequest(NSURLRequest(URL: nsurl))
		}
	}

	public override func updateConstraints() {
		super.updateConstraints()
	}

	func setup() {
		addSubview(webView)
		webView.equalConstrain()
	}

	public convenience init () {
		self.init(frame: CGRect.zero)
		setup()
	}

	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}

	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
}