//
//  SUScreenOptionCell.h
//  GHKC
//
//  Created by SunQ on 2019/8/18.
//  Copyright © 2019年 Tonghui Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** cell类型的枚举*/
typedef enum SUScreenOptionCellStyle {
    SUScreenCellStyleInput          = 0,        //输入框
    SUScreenCellStyleSelect         = 1,        //select
    SUScreenCellStyleRadio          = 2,        //单选确认
    SUScreenCellStyleDatePicker     = 3,        //选择时间
    SUScreenCellStyleCardPicker     = 4,        //卡片视图单选
    SUScreenCellStyleCardMultiple   = 5,        //卡片视图多选
    SUScreenCellStyleDateRange      = 6,        //时间范围
    //其他，自定义布局，只放一个可定制内容和值的输入框进去，配置方法通过属性设置
    SUScreenCellStyleOther          = 99,
}SUScreenOptionCellStyle;

/** 定义内容改变的block*/
typedef void (^SUScreenCellValueChanged) (NSString *value,NSString *identifier);

@interface SUScreenOptionCell : UIView

/** identifier:当前cell的标识，用于获取data时的key，同一个筛选框中的identifier需要唯一*/
- (id)initWithFrame:(CGRect)frame style:(SUScreenOptionCellStyle)style identifier:(NSString *)identifier;




#pragma mark - @@通用属性
/** 类型，详见枚举*/
@property (nonatomic, assign) SUScreenOptionCellStyle       style;
/** identifier*/
@property (nonatomic ,  copy) NSString                      *identifier;//
/** 标题*/
@property (nonatomic,   copy) NSString                      *title;
/** 监听内容改变，注意弱引用*/
@property (nonatomic,   copy) SUScreenCellValueChanged      valueChanged;


/** 获取值*/
@property (nonatomic, strong, readonly) NSDictionary        *data;
/** 动态设置值*/
@property (nonatomic, strong) NSString                      *dynamicValue;
/** 日期格式*/
@property (nonatomic, strong) NSString                      *dateFormate;

/** 重置*/
- (void)resetValue;
/** 根据screen的宽度获取卡片选择视图的高度*/
- (CGFloat)getCardViewHeightWithSupW:(CGFloat)width;



#pragma mark - @@SUScreenCellStyleSelect|SUScreenCellStyleCardPicker属性
/** 选择框的数据源*/
@property (nonatomic, strong) NSDictionary                  *pickerData;



#pragma mark - @@SUScreenCellStyleOther属性
/** customTF*/
@property (nonatomic, strong) UITextField                   *customTF;
/** customValue*/
@property (nonatomic, strong) NSString                      *customValue;
/** 监听customTF点击事件，注意弱引用*/
@property (nonatomic,   copy) void (^suScreenCellClick)(NSString *cellId);

@end

NS_ASSUME_NONNULL_END
