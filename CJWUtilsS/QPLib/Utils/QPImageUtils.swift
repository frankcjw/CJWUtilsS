//
//  QPImageUtils.swift
//  CJWUtilsS
//
//  Created by Frank on 1/18/16.
//  Copyright © 2016 cen. All rights reserved.
//

import UIKit
import SDWebImage

public class QPImageUtils: NSObject {
}

public extension UIImageView {
    public func image(url:String,placeholder:String){
        let placeholderImage = UIImage(named: placeholder)
        sd_setImageWithURL(NSURL(string: url), placeholderImage: placeholderImage) { (img, error, type, nsurl) -> Void in
            //
        }
    }
}