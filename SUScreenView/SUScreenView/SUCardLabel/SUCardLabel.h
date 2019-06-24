//
//  SUCardLabel.h
//  SUScreenView
//
//  Created by SunQ on 2019/6/24.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum SUCardLabelStyle {
    SUCardLabelStyleRadio      = 0,        //单选
    SUCardLabelStyleCheckBox   = 1,        //多选
}SUCardLabelStyle;

@class SUCardLabel;
@protocol SUCardLabelDelegate <NSObject>
- (void)suCardLabelTouchUpInside:(SUCardLabel *)sender;
@end

@interface SUCardLabel : UIButton
+ (instancetype)creatLabelWith:(SUCardLabelStyle)style;
@property (nonatomic,strong) NSString *val;
@property (nonatomic,strong) NSString *text;
/** 代理*/
@property (nonatomic, assign) id<SUCardLabelDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
