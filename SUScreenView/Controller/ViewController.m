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
}

- (SUScreenView *)screenViewDrop{
    if(!_screenViewDrop){
        _screenViewDrop = [[SUScreenView alloc]initWithFrame:self.view.bounds style:SUScreenViewStyleDrop];
        _screenViewDrop.delegate = self;
        [_screenViewDrop reloadData];
    }
    return _screenViewDrop;
}
- (SUScreenView *)screenViewSide{
    if(!_screenViewSide){
        _screenViewSide = [[SUScreenView alloc]initWithFrame:self.view.bounds style:SUScreenViewStyleSide];
        _screenViewSide.delegate = self;
        [_screenViewSide reloadData];
    }
    return _screenViewSide;
}

- (NSInteger)ghScreenViewOptionNumber{
    return 3;
}

- (SUScreenOptionCell *)ghScreenViewCellForIndex:(NSInteger)index{
    if(index == 0){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleInput identifier:@"sendUser"];
        cell.title = @"发送人";
        return cell;
    } else if(index == 1){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleSelect identifier:@"type"];
        cell.pickerData = @{@"1":@"质量考查",@"2":@"6S",@"3":@"CSR",@"4":@"交流回访",@"5":@"仓库评审",@"6":@"其他考查"};
        cell.title = @"考查类型";
        return cell;
    } else {
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:SUScreenCellStyleRadio identifier:@"title"];
        cell.title = @"我发起的";
        return cell;
    }
}
- (void)ghScreenViewSearchEvent:(NSDictionary *)dict{
    NSLog(@"%@",dict);
}

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
    }else{
        cell.textLabel.text = @"打开侧滑弹窗";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self.screenViewDrop show];
    }else{
        [self.screenViewSide show];
    }
}
@end
