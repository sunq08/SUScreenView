//
//  SUScreenView.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUScreenView.h"

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
    self.maskView.backgroundColor       = SURGBA(0, 0, 0, .4);
    [self addSubview:self.maskView];
    
    self.mainView                       = [[UIView alloc]init];
    self.mainView.frame                 = CGRectMake(0, SUTopHeight, SUScreenWidth, 350);
    self.mainView.backgroundColor       = [UIColor groupTableViewBackgroundColor];
    self.mainView.layer.masksToBounds   = YES;
    [self addSubview:self.mainView];
    
    self.mainScroll                     = [[UIScrollView alloc]init];
    self.mainScroll.frame               = CGRectMake(0, 0, SUScreenWidth, 280);
    [self.mainView addSubview:self.mainScroll];
    
    float buttonW                       = (SUScreenWidth - 45)/2;
    UIButton *resetBtn                  = [UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame                      = CGRectMake(15, 350 - 15 - 40, buttonW, 40);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [resetBtn setTitleColor:SURGBA(0, 186, 242, 1) forState:UIControlStateNormal];
    resetBtn.backgroundColor            = SURGBA(206, 238, 248, 1);
    [self.mainView addSubview:resetBtn];
    [resetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sureBtn                   = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame                       = CGRectMake(30+buttonW, 350 - 15 - 40, buttonW, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor             = SURGBA(0, 186, 242,1);
    [self.mainView addSubview:sureBtn];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
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
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [self.delegate ghScreenViewSearchEvent:dict];
    [self close];
}

- (void)sureClick{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    for (int index = 0; index < self.cells.count; index ++) {
        SUScreenOptionCell *cell = [self.cells objectAtIndex:index];
        [dict addEntriesFromDictionary:cell.data];
    }
    [self.delegate ghScreenViewSearchEvent:dict];
    [self close];
}
#pragma mark - event
- (void)show{
    self.maskView.backgroundColor       = SURGBA(0, 0, 0, 0);
    self.mainView.height                = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.2 animations:^{
        self.maskView.backgroundColor   = SURGBA(0, 0, 0, 0.4);
        self.mainView.height            = 350;
    } completion:nil];
}

- (void)close{
    [UIView animateWithDuration:.2 animations:^{
        self.maskView.backgroundColor   = SURGBA(0, 0, 0, 0);
        self.mainView.height            = 0;
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
