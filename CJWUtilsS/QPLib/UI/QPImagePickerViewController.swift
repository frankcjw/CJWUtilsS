//
//  QPImagePickerViewController.swift
//  CJWUtilsS
//
//  Created by Frank on 9/7/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit

public typealias QPImagePickerBlock = (images: Array<UIImage>) -> ()

class QPImagePickerViewController: UIImagePickerController, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	var block: QPImagePickerBlock!
	var cameraBlock: QPImagePickerBlock!

	func pickImage(vc: UIViewController, maxCount: Int, block: QPImagePickerBlock) {
		self.block = block
		let actionSheet = UIAlertController(title: "选择照片", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
		let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
		let camera = UIAlertAction(title: "相机", style: UIAlertActionStyle.Default) { (action) -> Void in
			self.imageFromCamera(vc, block: block)
		}
		let library = UIAlertAction(title: "图库", style: UIAlertActionStyle.Default) { (action) -> Void in
			if maxCount <= 1 {
				self.imageFromPhoto(vc, block: block)
			} else {
				self.imageFromLibrary(vc, maxCount: maxCount, block: block)
			}
		}

		actionSheet.addAction(cancelAction)
		actionSheet.addAction(camera)
		actionSheet.addAction(library)

		vc.presentViewController(actionSheet, animated: true) { () -> Void in
		}
	}

	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
		if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
			let oirentationImage = image.fixOrientation()
			block(images: [oirentationImage])
		}
		picker.dismissViewControllerAnimated(true) { () -> Void in
			//
		}
	}

	func imageFromSystem(vc: UIViewController, type: UIImagePickerControllerSourceType, block: QPImagePickerBlock) {
		if self.block == nil {
			self.block = block
		}

		let isAvailable = UIImagePickerController.isSourceTypeAvailable(type)

		self.sourceType = type
		self.delegate = self
		self.allowsEditing = true
		if isAvailable {
			vc.presentViewController(self, animated: true, completion: nil)
		} else {
			self.showText("无权限")
		}
	}

	func imageFromPhoto(vc: UIViewController, block: QPImagePickerBlock) {
		imageFromSystem(vc, type: UIImagePickerControllerSourceType.PhotoLibrary, block: block)
	}
	func imageFromCamera(vc: UIViewController, block: QPImagePickerBlock) {
		imageFromSystem(vc, type: UIImagePickerControllerSourceType.Camera, block: block)

	}

	func imageFromLibrary(vc: UIViewController, maxCount: Int, block: QPImagePickerBlock) {
		let pickerVc = MLSelectPhotoPickerViewController()
		pickerVc.maxCount = maxCount
		pickerVc.status = PickerViewShowStatus.CameraRoll
		pickerVc.showPickerVc(vc)
		pickerVc.callBack = {
			(assets) -> () in
			if let array = assets as? NSArray {
				var imgs = Array<UIImage>()
				for asset in array {
					if let ass = asset as? MLSelectPhotoAssets {
						let image = ass.originImage()
						imgs.append(image)
					}

				}
				block(images: imgs)
			}
		}
	}

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		picker.dismissViewControllerAnimated(true) { () -> Void in
		}
	}
}

public extension UIViewController {

	func pickImage(maxCount: Int, block: QPImagePickerBlock) {
		let picker = QPImagePickerViewController()
		picker.pickImage(self, maxCount: maxCount, block: block)
	}

	func pickImageFromLibrary(maxCount: Int, block: QPImagePickerBlock) {
		let picker = QPImagePickerViewController()
		picker.imageFromLibrary(self, maxCount: maxCount, block: block)
	}

	// imageFromCamera
	func pickImageFromCamera(block: QPImagePickerBlock) {
		let picker = QPImagePickerViewController()
		picker.imageFromCamera(self, block: block)
	}
}
