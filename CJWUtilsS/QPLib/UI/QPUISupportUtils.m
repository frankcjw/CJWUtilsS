//
//  QPUISupportUtils.m
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

#import "QPUISupportUtils.h"
#import "PodAsset.h"

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


@implementation UIImage (CJWCompress)

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    if (image.size.width <= newSize.width && image.size.height <= newSize.height) {
        return image;
    }
    
    CGSize actSize = image.size;
    float scale = actSize.width/actSize.height;
    
    if (scale < 1) {
        newSize.height = newSize.width/scale;
    } else {
        newSize.width = newSize.height*scale;
    }
    
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {
    
    
    
    return [UIImage scaleImage:image toSize:newSize];
}

@end


@implementation UIViewController (CJWWeb)

/**
 *  在ViewController中viewDidAppare中添加，在viewWillDisappear中remove。
 */
-(void)restBackFunction{
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(back)];
}

@end



@implementation QPMobileUtils

+ (BOOL)isChinaMobile:(NSString *)phoneNum
{
    NSString *CM = @"^1(3[4-9]|4[7]|5[0-27-9]|7[08]|8[2-478])\\d{8}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}


@end


@implementation UIImage (CJWPodImage)

+(UIImage *) imageInPod:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@""];
    if (bundle == NULL) {
        bundle = [PodAsset bundleForPod:@""];
    }
    UIImage *image = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end


