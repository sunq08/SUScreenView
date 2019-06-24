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
- (NSInteger)suScreenViewOptionNumber;
/** 设置单个选项的类型，标题等信息*/
- (SUScreenOptionCell *)suScreenViewCellForIndex:(NSInteger)index;
/** 点击重置、确定调用的方法，将数据带出*/
- (void)suScreenViewSearchEvent:(NSDictionary *)dict;
@optional
/** 设置单个选项的高度，主要是针对非标准cell的高度适配*/
- (CGFloat)suScreenViewCellHeightForIndex:(NSInteger)index;
/** 自定义视图的cell设置内容*/
- (UIView *)suCustomViewForCellIndex:(NSInteger)index;
/** 监听cell内容改变*/
- (void)suCellValueChangeWithIndex:(NSInteger)index value:(NSString *)value identifier:(NSString *)identifier;
@end

@interface SUScreenView : UIView

- (id)initWithFrame:(CGRect)frame style:(SUScreenViewStyle)style;
/** 代理*/
@property (nonatomic, assign) id<SUScreenViewDelegate> delegate;
/** 给vc添加侧滑功能*/
- (void)addPanEventWithVC:(UIViewController *)viewController;
/** 弹窗打开*/
- (void)show;
/** 初始化，设置完数据源后调用*/
- (void)reloadData;
/** 刷新某一个cell，用于修改标题/cell的数据源*/
- (void)reloadCellWith:(NSInteger)index title:(NSString *)title data:(NSDictionary *)data;
@end

NS_ASSUME_NONNULL_END
