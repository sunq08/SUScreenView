//
//  SUScreenConfig.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#define SUToolbarTintColor  [UIColor darkGrayColor]//toolbar按钮颜色

#define SUSideNavColor      surgb(249.0,249.0,249.0)//头部的颜色
#define SUSideNavTextColor  surgb(249.0,249.0,249.0)//头部字体的颜色

#define ResetBgColor        surgb(206.0,238.0,248.0)//重置按钮背景颜色，默认淡蓝
#define ResetTextColor      surgb(0.0,186.0,242.0)//重置按钮字体颜色，默认深蓝
#define SureBgColor         surgb(0.0,186.0,242.0)//确定按钮背景颜色，默认深蓝
#define SureTextColor       [UIColor whiteColor]//确定按钮字体颜色，默认白色

#define SUScreenWidth       [UIScreen mainScreen].bounds.size.width
#define SUScreenHeight      [UIScreen mainScreen].bounds.size.height
#define SUStatusBarHeight   [[UIApplication sharedApplication] statusBarFrame].size.height
#define SUNavBarHeight      44.0
#define SUTopHeight         (SUStatusBarHeight + SUNavBarHeight)

#import <UIKit/UIKit.h>

static const CGFloat SUDropViewHeight   = 350.0;//顶部筛选框的高度
static const CGFloat SUSideViewWidth    = 300.0;//侧边筛选框的宽度
static const CGFloat SUCellDefaltHeight = 80.0; //cell默认高度
static const CGFloat SULabelMinWidth    = 48.0; //label最小宽度

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
/** 计算文字宽度 */
+ (CGFloat)widthWithString:(NSString *)string fs:(CGFloat)fs height:(CGFloat)height;
@end
/** 通过RGB创建颜色 rgb(173.0,23.0,11.0)*/
UIColor *surgb(CGFloat red, CGFloat green, CGFloat blue);
