//
//  SUScreenView.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUScreenOptionCell.h"
#import "SUScreenConfig.h"
NS_ASSUME_NONNULL_BEGIN

/** 数据源*/
@protocol SUScreenViewDataSource <NSObject>
@required
/** 共有几个选项*/
- (NSInteger)ghScreenViewOptionNumber;
/** 设置单个选项的类型，标题等信息*/
- (SUScreenOptionCell *)ghScreenViewCellForIndex:(NSInteger)index;
@end

/** 代理*/
@protocol SUScreenViewDelegate <NSObject>
@required
/** 点击重置、确定调用的方法，将数据带出*/
- (void)ghScreenViewSearchEvent:(NSDictionary *)dict;
@end

@interface SUScreenView : UIView
/** 弹窗打开*/
- (void)show;
/** 初始化，设置完数据源后调用*/
- (void)editContent;
/** 代理*/
@property (nonatomic, assign) id<SUScreenViewDelegate> delegate;
/** 数据源*/
@property (assign, nonatomic) id<SUScreenViewDataSource> dataSource;
@end

NS_ASSUME_NONNULL_END
