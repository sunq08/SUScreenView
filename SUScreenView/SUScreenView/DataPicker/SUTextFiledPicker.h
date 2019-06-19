//
//  SUTextFiledPicker.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/19.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum SUTextFiledPickerStyle {
    SUTextFiledCommonPicker         = 0,        //select
    SUTextFiledTimePicker           = 1,        //时间选择
}SUTextFiledPickerStyle;

@interface SUTextFiledPicker : UITextField
/** 快捷创建picker*/
+ (instancetype)creatTextFiledWithStyle:(SUTextFiledPickerStyle)style;
/** 是否显示自定义toolbar 默认不显示
    现在项目里很多用到类似于IQKeyboardManager等键盘管理工具，如果没有用的话可以使用这个参数显示toolbar
 */
@property (nonatomic, assign) BOOL          showToolBar;
/** 数据源*/
@property (nonatomic, strong) NSDictionary  *pickerData;
/** 取值*/
@property (nonatomic, strong) NSString      *val;
/** 重置*/
- (void)reset;

@end

NS_ASSUME_NONNULL_END
