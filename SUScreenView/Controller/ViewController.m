//
//  ViewController.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "ViewController.h"
#import "SUScreenView.h"
@interface ViewController ()<SUScreenViewDelegate,SUScreenViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SUScreenView *screenView;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (SUScreenView *)screenView{
    if(!_screenView){
        _screenView = [[SUScreenView alloc]initWithFrame:self.view.bounds];
        _screenView.delegate = self;
        _screenView.dataSource = self;
        [_screenView editContent];
    }
    return _screenView;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScreenViewCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ScreenViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"打开弹窗";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.screenView show];
}
@end
