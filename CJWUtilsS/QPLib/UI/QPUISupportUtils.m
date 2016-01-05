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


-(void)translucentWith:(UIColor *)color{
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
