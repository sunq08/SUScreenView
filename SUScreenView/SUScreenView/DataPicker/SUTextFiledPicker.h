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
/** 数据源*/
@property (nonatomic, strong) NSDictionary  *pickerData;
/** 取值*/
@property (nonatomic, strong) NSString      *val;

@end

NS_ASSUME_NONNULL_END
