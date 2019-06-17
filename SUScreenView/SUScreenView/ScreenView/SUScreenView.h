//
//  SUScreenView.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUScreenOptionCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef enum SUScreenViewStyle {
    SUScreenViewStyleDrop       = 0,        //下拉菜单
    SUScreenViewStyleSide       = 1,        //侧滑菜单-右侧
}SUScreenViewStyle;

/** 数据源代理方法*/
@protocol SUScreenViewDelegate <NSObject>
@required
/** 共有几个选项*/
- (NSInteger)ghScreenViewOptionNumber;
/** 设置单个选项的类型，标题等信息*/
- (SUScreenOptionCell *)ghScreenViewCellForIndex:(NSInteger)index;
/** 点击重置、确定调用的方法，将数据带出*/
- (void)ghScreenViewSearchEvent:(NSDictionary *)dict;
@end

@interface SUScreenView : UIView

- (id)initWithFrame:(CGRect)frame style:(SUScreenViewStyle)style;
/** 弹窗打开*/
- (void)show;
/** 初始化，设置完数据源后调用*/
- (void)reloadData;
/** 代理*/
@property (nonatomic, assign) id<SUScreenViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
