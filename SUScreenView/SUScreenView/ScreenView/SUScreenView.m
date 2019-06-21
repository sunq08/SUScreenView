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
@property (nonatomic ,assign) SUScreenViewStyle style;      //0,下拉菜单。1，侧滑菜单
@property (nonatomic, strong) UIView        *mainView;      //内容视图
@property (nonatomic, strong) UIView        *maskView;      //蒙版
@property (nonatomic, strong) UIView        *navView;       //头部
@property (nonatomic, strong) UILabel       *titleLab;      //头部标题
@property (nonatomic, strong) UIScrollView  *mainScroll;    //内容scroll
@property (nonatomic, strong) UIButton      *resetBtn;      //重置按钮
@property (nonatomic, strong) UIButton      *sureBtn;       //确定按钮
@property (nonatomic, strong) NSMutableArray *cells;        //内容list

@property (nonatomic, assign) float         cellHeight;
@end
@implementation SUScreenView
- (id)initWithFrame:(CGRect)frame style:(SUScreenViewStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.maskView];

    [self addSubview:self.mainView];
    
    [self.mainView addSubview:self.mainScroll];
    
    [self.mainView addSubview:self.resetBtn];
    
    [self.mainView addSubview:self.sureBtn];
    
    if(self.style == SUScreenViewStyleDrop){//下拉
        [self addSubview:self.navView];
        [self.navView addSubview:self.titleLab];
        
        self.maskView.frame = CGRectMake(0, 0, SUScreenWidth, SUScreenHeight);
        self.mainView.frame = CGRectMake(0, SUTopHeight, SUScreenWidth, SUDropViewHeight);
        self.mainScroll.frame = CGRectMake(0, 0, SUScreenWidth, SUDropViewHeight-70);
        self.navView.frame = CGRectMake(0, 0, SUScreenWidth, SUTopHeight);
        self.titleLab.frame = CGRectMake(0, SUStatusBarHeight, SUScreenWidth, SUNavBarHeight);
        float buttonW = (SUScreenWidth - 45)/2;
        self.resetBtn.frame = CGRectMake(15, SUDropViewHeight - 15 - 40, buttonW, 40);
        self.sureBtn.frame = CGRectMake(30+buttonW, SUDropViewHeight - 15 - 40, buttonW, 40);
    }else{//侧滑
        [self.mainView addSubview:self.navView];
        [self.navView addSubview:self.titleLab];
        
        self.maskView.frame = CGRectMake(0, 0, SUScreenWidth, SUScreenHeight);
        self.mainView.frame = CGRectMake(SUScreenWidth-SUSideViewWidth, 0, SUSideViewWidth, SUScreenHeight);
        self.navView.frame = CGRectMake(0, 0, SUSideViewWidth, SUTopHeight);
        self.titleLab.frame = CGRectMake(0, SUStatusBarHeight, SUSideViewWidth, SUNavBarHeight);
        self.mainScroll.frame = CGRectMake(0, SUTopHeight, SUSideViewWidth, SUScreenHeight-SUTopHeight-70);
        float buttonW = (SUSideViewWidth - 45)/2;
        self.resetBtn.frame = CGRectMake(15, SUScreenHeight - 15 - 40, buttonW, 40);
        self.sureBtn.frame = CGRectMake(30+buttonW, SUScreenHeight - 15 - 40, buttonW, 40);
    }
}

- (void)reloadData{
    NSInteger num = 0;
    if(!self.cells){
        self.cells = [NSMutableArray new];
    }
    [self.cells removeAllObjects];
    if ([self.delegate respondsToSelector:@selector(suScreenViewOptionNumber)]) {
        num = [self.delegate suScreenViewOptionNumber];
    }
    
    float width = (self.style == SUScreenViewStyleDrop)?SUScreenWidth:SUSideViewWidth;
    float viewH = 0;
    for (int index = 0; index < num; index ++) {
        float height = SUCellDefaltHeight;
        if([self.delegate respondsToSelector:@selector(suScreenViewCellHeightForIndex:)]){
            height = [self.delegate suScreenViewCellHeightForIndex:index];
        }
        SUScreenOptionCell *cell = [self.delegate suScreenViewCellForIndex:index];
        cell.frame = CGRectMake(0, viewH, width, height);
        if(cell.style == SUScreenCellStyleOther && [self.delegate respondsToSelector:@selector(suCustomViewForCellIndex:)]){//自定义布局
            cell.customView = [self.delegate suCustomViewForCellIndex:index];
        }
        [self.mainScroll addSubview:cell];
        [self.cells addObject:cell];
        viewH += height;
    }
    self.mainScroll.contentSize = CGSizeMake(width, viewH);
}

#pragma mark - event
- (void)addPanEventWithVC:(UIViewController *)viewController{
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(edgePanEvent:)];
    edgePan.edges = (self.style == SUScreenViewStyleDrop)?UIRectEdgeTop:UIRectEdgeRight;
    [viewController.view addGestureRecognizer:edgePan];
}

- (void)edgePanEvent:(UIScreenEdgePanGestureRecognizer *)sender {
    if(self.style == SUScreenViewStyleDrop){
        if (sender.edges == UIRectEdgeTop && sender.state == UIGestureRecognizerStateBegan) {
            [self show];
        }
    }else{
        if (sender.edges == UIRectEdgeRight && sender.state == UIGestureRecognizerStateBegan) {
            [self show];
        }
    }
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if(self.style == SUScreenViewStyleDrop){//下拉
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [SUScreenHelper layoutViewHeightWith:self.mainView height:0];
        [UIView animateWithDuration:.2 animations:^{
            self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            [SUScreenHelper layoutViewHeightWith:self.mainView height:SUDropViewHeight];
        } completion:nil];
    } else {
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [SUScreenHelper layoutViewWidthWith:self.mainView left:SUScreenWidth];
        [UIView animateWithDuration:.2 animations:^{
            self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
            [SUScreenHelper layoutViewWidthWith:self.mainView left:SUScreenWidth-SUSideViewWidth];
        } completion:nil];
    }
}

- (void)close{
    if(self.style == SUScreenViewStyleDrop){//下拉
        [UIView animateWithDuration:.2 animations:^{
            self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [SUScreenHelper layoutViewHeightWith:self.mainView height:0];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [UIView animateWithDuration:.2 animations:^{
            self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [SUScreenHelper layoutViewWidthWith:self.mainView left:SUScreenWidth];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (CGRectContainsPoint([self.maskView frame], pt) && !CGRectContainsPoint([self.mainView frame], pt)) {
        [self close];
    }
}

#pragma mark - super get
- (UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc]init];
        
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return _maskView;
}

- (UIView *)mainView{
    if(!_mainView){
        _mainView = [[UIView alloc]init];
        
        _mainView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _mainView.layer.masksToBounds   = YES;
    }
    return _mainView;
}

- (UIView *)navView{
    if(!_navView){
        _navView = [[UIView alloc]init];
        _navView.backgroundColor = SUSideNavColor;
    }
    return _navView;
}

- (UILabel *)titleLab{
    if(!_titleLab){
        _titleLab = [[UILabel alloc]init];
        _titleLab.text = @"筛选";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UIScrollView *)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]init];
        
    }
    return _mainScroll;
}

- (UIButton *)resetBtn{
    if(!_resetBtn){
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_resetBtn setTitleColor:ResetTextColor forState:UIControlStateNormal];
        _resetBtn.backgroundColor = ResetBgColor;
        [_resetBtn addTarget:self action:@selector(resetClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIButton *)sureBtn{
    if(!_sureBtn){
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_sureBtn setTitleColor:SureTextColor forState:UIControlStateNormal];
        _sureBtn.backgroundColor = SureBgColor;
        [_sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

#pragma mark - click
- (void)resetClick{
    for (SUScreenOptionCell *cell in self.cells) {
        [cell resetValue];
    }
    NSMutableDictionary *dict           = [NSMutableDictionary new];
    [self.delegate suScreenViewSearchEvent:dict];
    [self close];
}

- (void)sureClick{
    NSMutableDictionary *dict           = [NSMutableDictionary new];
    for (int index = 0; index < self.cells.count; index ++) {
        SUScreenOptionCell *cell = [self.cells objectAtIndex:index];
        [dict addEntriesFromDictionary:cell.data];
    }
    [self.delegate suScreenViewSearchEvent:dict];
    [self close];
}


@end
