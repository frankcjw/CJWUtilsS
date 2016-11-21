//
//  CJWQRCode.h
//  CJWUtils
//
//  Created by cen on 10/10/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CJWQRCode : NSObject

+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

@end


@interface UIImageView (CJWQRCode)

-(void)qrcodeWith:(NSString *)string;
//-(void)qrcodeWith:(NSString *)string logo:(UIImage *)image;


@end