//
//  CJWQRCode.m
//  CJWUtils
//
//  Created by cen on 10/10/14.
//  Copyright (c) 2014 cen. All rights reserved.
//

#import "CJWQRCode.h"
#import "QRCodeGenerator.h"

@implementation CJWQRCode

+(UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size{
    return [QRCodeGenerator qrImageForString:string imageSize:size];
}
@end


@implementation UIImageView (CJWQRCode)

-(void)qrcodeWith:(NSString *)string{
    self.image = [QRCodeGenerator qrImageForString:string imageSize:self.frame.size.width];
}


@end