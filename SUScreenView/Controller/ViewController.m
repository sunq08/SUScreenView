//
//  ViewController.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "ViewController.h"
#import "SUScreenView.h"
@interface ViewController ()<SUScreenViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SUScreenView *screenViewDrop;
@property (nonatomic, strong) SUScreenView *screenViewSide;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"SUScreenView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.screenViewSide = [[SUScreenView alloc]initWithFrame:self.view.bounds style:SUScreenViewStyleSide];
    self.screenViewSide.delegate = self;
    //需要添加手势的话需要在viewdidload里面就把菜单创建好，不能使用懒加载！
    [self.screenViewSide addPanEventWithVC:self];
    [self.screenViewSide reloadData];
}

- (SUScreenView *)screenViewDrop{
    if(!_screenViewDrop){
        _screenViewDrop = [[SUScreenView alloc]initWithFrame:self.view.bounds style:SUScreenViewStyleDrop];
        _screenViewDrop.delegate = self;
        [_screenViewDrop addPanEventWithVC:self];
        [_screenViewDrop reloadData];
    }
    return _screenViewDrop;
}

#pragma mark - screen view
- (NSInteger)suScreenViewOptionNumber{
    return 7;
}

- (SUScreenOptionCell *)suScreenViewCellForIndex:(NSInteger)index{
    if(index == 0){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleInput identifier:@"sendUser"];
        cell.title = @"发送人";
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    } else if(index == 1){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleSelect identifier:@"type"];
        cell.pickerData = @{@"1":@"全部",@"2":@"已读",@"3":@"未读"};
        cell.title = @"消息状态";
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    } else if(index == 2){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleDatePicker identifier:@"addTime"];
        cell.title = @"开始时间";
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    } else if(index == 3){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleOther identifier:@"custom"];
        cell.title = @"自定义布局";
        return cell;
    } else if(index == 4){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleCardPicker identifier:@"date"];
        cell.title = @"卡片选择器";
        cell.pickerData = @{@"-1":@"大前天",@"0":@"前天前天",@"1":@"昨天昨天昨天",@"2":@"今天天",@"3":@"明天明天",@"4":@"后天后天后天后天",@"5":@"大后天大后天大后天"};
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    } else if(index == 5){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleCardMultiple identifier:@"status"];
        cell.title = @"订单状态";
        cell.pickerData = @{@"-1":@"全部",@"0":@"待付款",@"1":@"待发货",@"2":@"待收货",@"3":@"待评价",@"4":@"已完成",@"5":@"退款/售后"};
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    } else {
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleRadio identifier:@"mySend"];
        cell.title = @"我发起的";
        cell.valueChanged = ^(NSString * _Nonnull value, NSString * _Nonnull identifier) {
            NSLog(@"第%ld个cell内容改变了，改成了：%@，cell id为：%@",index,value,identifier);
        };
        return cell;
    }
}

- (CGFloat)suScreenViewCellHeightForIndex:(NSInteger)index{
    if(index == 3){
        return 100;
    }
    return 80;
}

- (UIView *)suCustomViewForCellIndex:(NSInteger)index{
    if(index == 3){
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor yellowColor];
        return view;
    }
    return nil;
}

- (void)suScreenViewSearchEvent:(NSDictionary *)dict{
    NSLog(@"%@",dict);
}

- (void)suCellValueChangeWithIndex:(NSInteger)index value:(NSString *)value identifier:(NSString *)identifier{
    
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreenViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ScreenViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == 0){
        cell.textLabel.text = @"打开下拉弹窗";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"打开侧滑弹窗";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self.screenViewDrop show];
    }else if (indexPath.row == 1){
        [self.screenViewSide show];
    }else{

    }
}
@end
