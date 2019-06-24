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
    SUScreenCellStyleInput          = 0,        //输入框
    SUScreenCellStyleSelect         = 1,        //select
    SUScreenCellStyleRadio          = 2,        //单选确认
    SUScreenCellStyleDatePicker     = 3,        //选择时间
    SUScreenCellStyleCardPicker     = 4,        //卡片视图单选
    SUScreenCellStyleCardMultiple   = 5,        //卡片视图多选
    SUScreenCellStyleOther          = 99,       //其他，自定义布局，不过好像没啥用，只能展示布局
}SUScreenOptionCellStyle;

typedef void (^SUScreenCellValueChanged) (NSString *value,NSString *identifier);

@interface SUScreenOptionCell : UIView
/** identifier:当前cell的标识，用于获取data时的key，同一个筛选框中的identifier需要唯一*/
- (id)initWithFrame:(CGRect)frame style:(SUScreenOptionCellStyle)style identifier:(NSString *)identifier;
/** 类型，详见枚举*/
@property (nonatomic, assign) SUScreenOptionCellStyle       style;
/** 标题*/
@property (nonatomic,   copy) NSString                      *title;
/** 选择框的数据源,style=SUScreenCellStyleSelect有效*/
@property (nonatomic, strong) NSDictionary                  *pickerData;
/** 监听内容改变，注意弱引用*/
@property (nonatomic,   copy) SUScreenCellValueChanged      valueChanged;

/** 自定义视图,style=SUScreenCellStyleOther有效*/
@property (nonatomic, strong) UIView                        *customView;
/** 获取值*/
@property (nonatomic, strong, readonly) NSDictionary        *data;
/** 重置*/
- (void)resetValue;
/** 根据screen的宽度获取卡片选择视图的高度*/
- (CGFloat)getCardViewHeightWithSupW:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
