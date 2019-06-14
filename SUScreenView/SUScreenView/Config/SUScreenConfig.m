//
//  SUScreenConfig.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUScreenConfig.h"

@implementation SUHelper
+ (void)layoutViewRadioWith:(UIView *)view radio:(int)radio{
    [view.layer setCornerRadius:radio];
    [view.layer setMasksToBounds:YES];
}

+ (void)layoutViewHeightWith:(UIView *)view height:(float)height{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
