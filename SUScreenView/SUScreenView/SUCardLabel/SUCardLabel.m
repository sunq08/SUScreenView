//
//  SUCardLabel.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/24.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUCardLabel.h"
#import "SUScreenConfig.h"
@interface SUCardLabel()
@property (nonatomic ,assign) SUCardLabelStyle style;
@end
@implementation SUCardLabel
+ (instancetype)creatLabelWith:(SUCardLabelStyle)style{
    SUCardLabel *label = [SUCardLabel buttonWithType:UIButtonTypeCustom];
    label.style = style;
    [label.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [label setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [label setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [label setBackgroundImage:[SUScreenHelper imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [label setBackgroundImage:[SUScreenHelper imageWithColor:ResetBgColor] forState:UIControlStateSelected];
    
//    [label setBackgroundImage:[UIImage imageNamed:@"sucard_un"] forState:UIControlStateNormal];
//    [label setBackgroundImage:[UIImage imageNamed:@"sucard_select"] forState:UIControlStateSelected];
    [SUScreenHelper layoutViewRadioWith:label radio:2];
    [label addTarget:label action:@selector(cardClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return label;
}

- (void)cardClick:(SUCardLabel *)sender{
    if(self.style == SUCardLabelStyleRadio){//单选
        if(sender.selected){//取消选择
            sender.selected = NO;
            if([self.delegate respondsToSelector:@selector(suCardLabelTouchUpInside:)]){
                [self.delegate suCardLabelTouchUpInside:self];
            }
        }else{//选择其他
            UIView *supView = [sender superview];
            NSArray *subViews = [supView subviews];
            for (SUCardLabel *label in subViews) {
                if([label isKindOfClass:[SUCardLabel class]]) label.selected = NO;
            }
            sender.selected = YES;
            if([self.delegate respondsToSelector:@selector(suCardLabelTouchUpInside:)]){
                [self.delegate suCardLabelTouchUpInside:self];
            }
        }
    }else{//多选
        sender.selected = !sender.selected;
        if([self.delegate respondsToSelector:@selector(suCardLabelTouchUpInside:)]){
            [self.delegate suCardLabelTouchUpInside:self];
        }
    }
}

- (void)setText:(NSString *)text{
    _text = text;
    [self setTitle:text forState:UIControlStateNormal];
}

@end
