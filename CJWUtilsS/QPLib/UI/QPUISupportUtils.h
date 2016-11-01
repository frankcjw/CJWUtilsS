//
//  QPUISupportUtils.h
//  QHProject
//
//  Created by quickplain on 15/12/24.
//  Copyright © 2015年 quickplain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QPUISupportUtils : UIView

@end

@interface UINavigationBar (CJWUINavigationBar)

-(void)translucentBar:(UIColor *)color;
//-(void)removeTranslucent;



@end


@interface UIImage (CJWColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end

@interface UIImage (CJWBarCode)
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;
@end