//
//  SUCardView.h
//  GHKC
//
//  Created by SunQ on 2019/7/3.
//  Copyright © 2019年 Tonghui Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUCardView : UIView
/** 数据源，必传*/
@property (nonatomic, strong) NSDictionary            *pickerData;
/** 自定义按钮大小*/
@property (nonatomic, assign) CGSize                  radioSize;
/** 获取值*/
@property (nonatomic, strong, readonly) NSString      *selectValue;
/** 默认值*/
@property (nonatomic,   copy) NSString                *defaultValue;
/** 根据宽度获取卡片大小*/
- (CGFloat)getCardViewHeightWithSupW:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
