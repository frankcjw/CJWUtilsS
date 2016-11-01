//
//  QPUISupportUtils.m
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

#import "QPUISupportUtils.h"

@implementation QPUISupportUtils

@end

@implementation UINavigationBar (CJWUINavigationBar)


-(void)translucentBar:(UIColor *)color{
    UIImage *image = [UIImage imageWithColor:color];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    [self setTranslucent:YES];
}


-(void)removeTranslucent{
    //    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [self setShadowImage:nil];
    [self setTranslucent:NO];
}

@end


@implementation UIImage (CJWColor)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end


@implementation UIImage (CJWBarCode)

+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    // 生成二维码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    
    [filter setValue:data forKey:@"inputMessage"];
    barcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

@end
