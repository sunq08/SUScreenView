//
//  SUScreenConfig.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#define SUDropViewHeight    350//顶部筛选框的高度
#define SUSideViewWidth     300//侧边筛选看的宽度

#define SUCellDefaltHeight  80//cell默认高度
//头部的颜色
#define SUSideNavColor      [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0f]

//重置按钮背景颜色，默认(206, 238, 248, 1)，淡蓝
#define resetBgColor [UIColor colorWithRed:206.0/255.0 green:238.0/255.0 blue:248.0/255.0 alpha:1.0f]
//重置按钮字体颜色，默认(0, 186, 242, 1)，深蓝
#define resetTextColor [UIColor colorWithRed:0.0/255.0 green:186.0/255.0 blue:242.0/255.0 alpha:1.0f]
//确定按钮背景颜色，默认(0, 186, 242, 1)，深蓝
#define sureBgColor [UIColor colorWithRed:0.0/255.0 green:186.0/255.0 blue:242.0/255.0 alpha:1.0f]
//确定按钮字体颜色，默认白色
#define sureTextColor [UIColor whiteColor]

#define SUScreenWidth   [UIScreen mainScreen].bounds.size.width
#define SUScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SUStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define SUNavBarHeight 44.0
#define SUTopHeight (SUStatusBarHeight + SUNavBarHeight)

#import "UITextFieldPicker.h"

@interface SUScreenHelper : NSObject
/**设置圆角*/
+ (void)layoutViewRadioWith:(UIView *)view radio:(int)radio;
/**设置高度*/
+ (void)layoutViewHeightWith:(UIView *)view height:(float)height;
/**设置宽度*/
+ (void)layoutViewWidthWith:(UIView *)view left:(float)left;
/** 根据颜色获取图片*/
+ (UIImage *)imageWithColor:(UIColor *)color;
/** 获取上级controller*/
+ (UIViewController *)getSuperViewController:(UIView *)view;
@end
