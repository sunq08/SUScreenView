//
//  SUScreenOptionCell.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUScreenOptionCell.h"
#import "SUTextFiledPicker.h"
#import "SUScreenConfig.h"
@interface SUScreenOptionCell()

@property (nonatomic ,  copy) NSString              *identifier;//identifier
@property (nonatomic ,strong) UILabel               *titleLab;//title
@property (nonatomic ,strong) UITextField           *mainTF;//tf
@property (nonatomic ,strong) SUTextFiledPicker     *mainPicker;//picker
@property (nonatomic ,strong) SUTextFiledPicker     *mainDatePicker;//datepicker
@property (nonatomic ,strong) UIButton              *mainRadio;//radio
@end

@implementation SUScreenOptionCell

- (id)initWithFrame:(CGRect)frame style:(SUScreenOptionCellStyle)style identifier:(NSString *)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        self.identifier = identifier;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self addSubview:self.titleLab];
    if(self.style == SUScreenCellStyleInput) {//输入框
        [self addSubview:self.mainTF];
    } else if (self.style == SUScreenCellStyleSelect) {//选择框
        [self addSubview:self.mainPicker];
    } else if (self.style == SUScreenCellStyleRadio) {//单选
        [self addSubview:self.mainRadio];
    } else if (self.style == SUScreenCellStyleDatePicker) {//时间
        [self addSubview:self.mainDatePicker];
    } else if (self.style == SUScreenCellStyleOther) {//自定义类型
        
    } else {
        NSLog(@"错误的cell类型");
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    self.titleLab.frame             = CGRectMake(15, 15, width - 30, 21);
    if(self.style == SUScreenCellStyleInput) {//输入框
        self.mainTF.frame           = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleSelect) {//选择框
        self.mainPicker.frame       = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleRadio) {//单选
        self.mainRadio.frame        = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleDatePicker) {//时间
        self.mainDatePicker.frame   = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleOther) {//自定义布局
        self.customView.frame       = CGRectMake(15, 44, width - 30, height-44-6);
    } else {
        NSLog(@"错误的cell类型");
    }
}

#pragma mark - supper get
- (UILabel *)titleLab{
    if(!_titleLab){
        _titleLab                   = [[UILabel alloc]init];
        _titleLab.textColor         = [UIColor darkGrayColor];
        _titleLab.font              = [UIFont systemFontOfSize:14];
    }
    return _titleLab;
}

- (UITextField *)mainTF{
    if(!_mainTF){
        _mainTF                     = [[UITextField alloc]init];
        _mainTF.font                = [UIFont systemFontOfSize:13];
        _mainTF.borderStyle         = UITextBorderStyleNone;
        _mainTF.backgroundColor     = [UIColor whiteColor];
        _mainTF.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _mainTF.leftViewMode        = UITextFieldViewModeAlways;
        [SUScreenHelper layoutViewRadioWith:_mainTF radio:2];
    }
    return _mainTF;
}

- (SUTextFiledPicker *)mainPicker{
    if(!_mainPicker){
        _mainPicker                     = [SUTextFiledPicker creatTextFiledWithStyle:SUTextFiledCommonPicker];
        _mainPicker.font                = [UIFont systemFontOfSize:13];
        _mainPicker.borderStyle         = UITextBorderStyleNone;
        _mainPicker.backgroundColor     = [UIColor whiteColor];
        _mainPicker.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _mainPicker.leftViewMode        = UITextFieldViewModeAlways;
        [SUScreenHelper layoutViewRadioWith:_mainPicker radio:2];
    }
    return _mainPicker;
}

- (SUTextFiledPicker *)mainDatePicker{
    if(!_mainDatePicker){
        _mainDatePicker                 = [SUTextFiledPicker creatTextFiledWithStyle:SUTextFiledTimePicker];
        _mainDatePicker.font            = [UIFont systemFontOfSize:13];
        _mainDatePicker.borderStyle     = UITextBorderStyleNone;
        _mainDatePicker.backgroundColor = [UIColor whiteColor];
        _mainDatePicker.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _mainDatePicker.leftViewMode    = UITextFieldViewModeAlways;
        [SUScreenHelper layoutViewRadioWith:_mainDatePicker radio:2];
    }
    return _mainDatePicker;
}

- (UIButton *)mainRadio{
    if(!_mainRadio){
        _mainRadio = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainRadio setTitle:@"是" forState:UIControlStateNormal];
        [_mainRadio.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_mainRadio setBackgroundImage:[SUScreenHelper imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_mainRadio setBackgroundImage:[SUScreenHelper imageWithColor:ResetBgColor] forState:UIControlStateSelected];
        [_mainRadio setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_mainRadio setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_mainRadio addTarget:self action:@selector(radioClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainRadio;
}

- (NSDictionary *)data{
    if(self.style == SUScreenCellStyleInput && ![self.mainTF.text isEqualToString:@""]){
        return @{self.identifier:self.mainTF.text};
    }
    if(self.style == SUScreenCellStyleSelect && ![self.mainPicker.text isEqualToString:@""]){
        return @{self.identifier:self.mainPicker.text};
    }
    if(self.style == SUScreenCellStyleRadio){
        return @{self.identifier:self.mainRadio.selected?@"1":@"0"};
    }
    if(self.style == SUScreenCellStyleDatePicker && ![self.mainDatePicker.text isEqualToString:@""]){
        return @{self.identifier:self.mainDatePicker.text};
    }
    return @{};
}

#pragma mark - supper set
- (void)setCustomView:(UIView *)customView{
    _customView = customView;
    
    [self addSubview:customView];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLab.text = title;
    if(self.style == SUScreenCellStyleInput){
        self.mainTF.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    } else if (self.style == SUScreenCellStyleSelect){
        self.mainPicker.placeholder = [NSString stringWithFormat:@"请选择%@",title];
    } else if (self.style == SUScreenCellStyleDatePicker){
        self.mainDatePicker.placeholder = [NSString stringWithFormat:@"请选择%@",title];
    }
}

- (void)setPickerData:(NSDictionary *)pickerData{
    _pickerData = pickerData;
    
    if(self.style == SUScreenCellStyleSelect){
        self.mainPicker.pickerData = pickerData;
    }
}

#pragma mark - privately
- (void)radioClick:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)resetValue{
    if(self.style == SUScreenCellStyleInput){
        self.mainTF.text = @"";
    } else if (self.style == SUScreenCellStyleSelect){
        self.mainPicker.val = @"";
    } else if (self.style == SUScreenCellStyleRadio){
        self.mainRadio.selected = NO;
    } else if (self.style == SUScreenCellStyleDatePicker){
        self.mainDatePicker.val = @"";
    }
}
@end
