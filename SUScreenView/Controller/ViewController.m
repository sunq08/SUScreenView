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
    return 2;
}

- (SUScreenOptionCell *)ghScreenViewCellForIndex:(NSInteger)index{
    if(index == 0){
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:1 identifier:@"sendUser"];
        cell.title = @"发送人";
        return cell;
    } else {
        SUScreenOptionCell *cell = [[SUScreenOptionCell alloc]initWithFrame:CGRectZero style:1 identifier:@"title"];
        cell.title = @"标题";
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
