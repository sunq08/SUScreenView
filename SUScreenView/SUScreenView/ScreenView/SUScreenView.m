//
//  SUScreenView.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUScreenView.h"
#import "SUScreenConfig.h"
@interface SUScreenView()
@property (nonatomic, strong) UIView        *mainView;      //内容视图
@property (nonatomic, strong) UIView        *maskView;      //蒙版
@property (nonatomic, strong) UIScrollView  *mainScroll;    //内容scroll
@property (nonatomic, strong) NSMutableArray *cells;        //内容list
@end
@implementation SUScreenView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.maskView                       = [[UIView alloc]init];
    self.maskView.frame                 = CGRectMake(0, SUTopHeight, SUScreenWidth, SUScreenHeight-SUTopHeight);
    self.maskView.backgroundColor       = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:self.maskView];
    
    self.mainView                       = [[UIView alloc]init];
    self.mainView.frame                 = CGRectMake(0, SUTopHeight, SUScreenWidth, SUTopViewHeight);
    self.mainView.backgroundColor       = [UIColor groupTableViewBackgroundColor];
    self.mainView.layer.masksToBounds   = YES;
    [self addSubview:self.mainView];
    
    self.mainScroll                     = [[UIScrollView alloc]init];
    self.mainScroll.frame               = CGRectMake(0, 0, SUScreenWidth, SUTopViewHeight-70);
    [self.mainView addSubview:self.mainScroll];
    
    float buttonW                       = (SUScreenWidth - 45)/2;
    UIButton *resetBtn                  = [self creatWithTitle:@"重置" textColor:resetTextColor bgColor:resetBgColor];
    resetBtn.frame                      = CGRectMake(15, SUTopViewHeight - 15 - 40, buttonW, 40);
    [resetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn                   = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame                       = CGRectMake(30+buttonW, SUTopViewHeight - 15 - 40, buttonW, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn setTitleColor:sureTextColor forState:UIControlStateNormal];
    sureBtn.backgroundColor             = sureBgColor;
    [self.mainView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
}

- (UIButton *)creatWithTitle:(NSString *)title textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor            = bgColor;
    [self.mainView addSubview:button];
    return button;
}

- (void)editContent{
    NSInteger num = 0;
    if(!self.cells){
        self.cells = [NSMutableArray new];
    }
    [self.cells removeAllObjects];
    if ([self.dataSource respondsToSelector:@selector(ghScreenViewOptionNumber)]) {
        num = [self.dataSource ghScreenViewOptionNumber];
    }
    for (int index = 0; index < num; index ++) {
        SUScreenOptionCell *cell = [self.dataSource ghScreenViewCellForIndex:index];
        cell.frame = CGRectMake(0, 80*index, SUScreenWidth, 80);
        [self.mainScroll addSubview:cell];
        [self.cells addObject:cell];
    }
    self.mainScroll.contentSize = CGSizeMake(SUScreenWidth, 80*num);
}

#pragma mark - click
- (void)resetClick{
    for (SUScreenOptionCell *cell in self.cells) {
        [cell resetValue];
    }
    NSMutableDictionary *dict           = [NSMutableDictionary new];
    [self.delegate ghScreenViewSearchEvent:dict];
    [self close];
}

- (void)sureClick{
    NSMutableDictionary *dict           = [NSMutableDictionary new];
    for (int index = 0; index < self.cells.count; index ++) {
        SUScreenOptionCell *cell = [self.cells objectAtIndex:index];
        [dict addEntriesFromDictionary:cell.data];
    }
    [self.delegate ghScreenViewSearchEvent:dict];
    [self close];
}
#pragma mark - event
- (void)show{
    self.maskView.backgroundColor       = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [SUHelper layoutViewHeightWith:self.mainView height:0];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.2 animations:^{
        self.maskView.backgroundColor   = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [SUHelper layoutViewHeightWith:self.mainView height:SUTopViewHeight];
    } completion:nil];
}

- (void)close{
    [UIView animateWithDuration:.2 animations:^{
        self.maskView.backgroundColor   = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [SUHelper layoutViewHeightWith:self.mainView height:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (CGRectContainsPoint([self.maskView frame], pt) && !CGRectContainsPoint([self.mainView frame], pt)) {
        [self close];
    }
}

@end
