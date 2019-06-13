//
//  SUScreenConfig.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#ifndef SUScreenConfig_h
#define SUScreenConfig_h

#define SUScreenWidth   [UIScreen mainScreen].bounds.size.width
#define SUScreenHeight  [UIScreen mainScreen].bounds.size.height
#define SUStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define SUNavBarHeight 44.0
#define SUTopHeight (SUStatusBarHeight + SUNavBarHeight)

#define SURGBA(r,g,b,a) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

#import "UIView+Frame.h"
#import "UITextFieldPicker.h"
#import "UIButton+Category.h"

#endif /* SUScreenConfig_h */
