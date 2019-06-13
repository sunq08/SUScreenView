//
//  SUScreenOptionCell.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum SUScreenOptionCellStyle {
    SUScreenCellStyleInput  = 0,        //无录制任务
    SUScreenCellStyleSelect = 1,     //录制中
    SUScreenCellStyleRadio  = 2    //录制取消中
}SUScreenOptionCellStyle;

@interface SUScreenOptionCell : UIView
/** type:1,输入框。2，选择框。3，单选*/
/** identifier:当前cell的标识，用于获取data时的key，同一个筛选框中的identifier需要唯一*/
- (id)initWithFrame:(CGRect)frame style:(SUScreenOptionCellStyle)style identifier:(NSString *)identifier;
/** 标题*/
@property (nonatomic ,  copy) NSString          *title;
/** 选择框的数据源,style=2有效*/
@property (nonatomic, strong) NSDictionary      *pickerData;
/** 获取值*/
@property (nonatomic, strong, readonly) NSDictionary *data;
/** 重置*/
- (void)resetValue;

@end

NS_ASSUME_NONNULL_END
