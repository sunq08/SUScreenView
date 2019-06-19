//
//  SUTextFiledPicker.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/19.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUTextFiledPicker.h"
@interface SUTextFiledPicker()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic ,assign) SUTextFiledPickerStyle style;      //0,下拉菜单。1，侧滑菜单
@end
@implementation SUTextFiledPicker

+ (instancetype)creatTextFiledWithStyle:(SUTextFiledPickerStyle)style{
    SUTextFiledPicker *textFiled = [[SUTextFiledPicker alloc]initWithFrame:CGRectZero style:style];
    return textFiled;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initBase];
}

- (id)initWithFrame:(CGRect)frame style:(SUTextFiledPickerStyle)style{
    if (!(self = [super initWithFrame:frame])) return nil;
    self.style = style;
    [self initBase];
    return self;
}

- (void)initBase{
    self.tintColor =[UIColor clearColor];
    
    if(self.style == SUTextFiledTimePicker){
        self.inputView = self.datePicker;
    }else{
        self.inputView = self.pickerView;
    }
}

#pragma mark - super getting
- (UIPickerView *)pickerView{
    if(!_pickerView){
        _pickerView = [[UIPickerView alloc] init];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
    }
    return _pickerView;
}

- (UIDatePicker *)datePicker{
    if(!_datePicker){
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setBackgroundColor:[UIColor whiteColor]];
        _datePicker.datePickerMode = UIDatePickerModeDate;
    }
    return _datePicker;
}

#pragma mark - super setting
- (void)setVal:(NSString *)val{
    _val = val;
    
    if(self.style == SUTextFiledCommonPicker){
        if([val isEqualToString:@""]){
            self.text = @"";
            [_pickerView selectRow:0 inComponent:0 animated:NO];
        } else {
            self.text = [self.pickerData objectForKey:val];
        }
    }else{
        self.text = val;
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        _datePicker.date = [format dateFromString:val];
    }
}

- (void)setStyle:(SUTextFiledPickerStyle)style{
    _style = style;
}

- (void)setShowToolBar:(BOOL)showToolBar{
    _showToolBar = showToolBar;
    
    if(!showToolBar) return;
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 44)];
    toolbar.tintColor = [UIColor blueColor];
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithTitle:@"清除" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *down = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(resignFirstResponder)];
    toolbar.items = @[clear, space, down];
    self.inputAccessoryView = toolbar;
}

#pragma mark - super function
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (BOOL)becomeFirstResponder{
    if(self.style == SUTextFiledCommonPicker){
        if(!self.val || [self.val isEqualToString:@""]){
            if([self.pickerData isKindOfClass:[NSDictionary class]] && [self.pickerData allKeys].count != 0){
                NSArray *dataKey = [self.pickerData allKeys];
                self.val = dataKey[0];
            }
        } else {
            if([self.pickerData isKindOfClass:[NSDictionary class]] && [self.pickerData allKeys].count != 0){
                int index = 0;
                NSArray *dataKey = [self.pickerData allKeys];
                for (int i = 0 ; i < dataKey.count ; i ++) {
                    NSString *data = dataKey[i];
                    if([data isEqualToString:self.val]){
                        index = i;
                        break;
                    }
                }
                [_pickerView selectRow:index inComponent:0 animated:NO];
            }
        }
    }
    BOOL become = [super becomeFirstResponder];
    return become;
}

- (BOOL)resignFirstResponder {
    if(self.style == SUTextFiledTimePicker){
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
        self.text = [format stringFromDate:_datePicker.date];
    }
    BOOL resign = [super resignFirstResponder];
    return resign;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:))//禁止粘贴
        return NO;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
// 几列数据
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// 每列的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerData.count;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return [UIScreen mainScreen].bounds.size.width;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *dataKey = [self.pickerData allKeys];
    self.val = dataKey[row];
}

// 显示每行每列的数据
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *dateValue = [self.pickerData allValues];
    return dateValue[row];
}



#pragma mark - private function
- (void)reset{
    if(self.style == SUTextFiledCommonPicker){
        self.text = @"";
        [_pickerView selectRow:0 inComponent:0 animated:NO];
    }else{
        self.text = @"";
    }
}

@end
