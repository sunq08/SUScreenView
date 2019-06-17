//
//  SUScreenOptionCell.m
//  SUScreenView
//
//  Created by SunQ on 2019/6/13.
//  Copyright © 2019年 sunq. All rights reserved.
//

#import "SUScreenOptionCell.h"

#import "SUScreenConfig.h"
@interface SUScreenOptionCell()
@property (nonatomic ,assign) SUScreenOptionCellStyle style;//1,输入框。2，选择框
@property (nonatomic ,  copy) NSString              *identifier;//identifier
@property (nonatomic ,strong) UILabel               *titleLab;//title
@property (nonatomic ,strong) UITextField           *mainTF;//tf
@property (nonatomic ,strong) UITextFieldPicker     *mainPicker;//picker
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
    } else {
        NSLog(@"错误的cell类型");
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    float width = self.frame.size.width;
    self.titleLab.frame             = CGRectMake(15, 15, width - 30, 21);
    if(self.style == SUScreenCellStyleInput) {//输入框
        self.mainTF.frame           = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleSelect) {//选择框
        self.mainPicker.frame       = CGRectMake(15, 44, width - 30, 30);
    } else if (self.style == SUScreenCellStyleRadio) {//单选
        self.mainRadio.frame        = CGRectMake(15, 44, width - 30, 30);
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
        [SUHelper layoutViewRadioWith:_mainTF radio:2];
    }
    return _mainTF;
}

- (UITextFieldPicker *)mainPicker{
    if(!_mainPicker){
        _mainPicker                     = [[UITextFieldPicker alloc]init];
        _mainPicker.font                = [UIFont systemFontOfSize:13];
        _mainPicker.borderStyle         = UITextBorderStyleNone;
        _mainPicker.backgroundColor     = [UIColor whiteColor];
        _mainPicker.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _mainPicker.leftViewMode        = UITextFieldViewModeAlways;
        [SUHelper layoutViewRadioWith:_mainPicker radio:2];
    }
    return _mainPicker;
}

- (UIButton *)mainRadio{
    if(!_mainRadio){
        _mainRadio = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainRadio setTitle:@"是" forState:UIControlStateNormal];
        [_mainRadio.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_mainRadio setBackgroundImage:[SUHelper imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_mainRadio setBackgroundImage:[SUHelper imageWithColor:resetBgColor] forState:UIControlStateSelected];
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
    if(self.style == SUScreenCellStyleRadio && ![self.mainPicker.text isEqualToString:@""]){
        return @{self.identifier:self.mainRadio.selected?@"1":@"0"};
    }
    return @{};
}

#pragma mark - supper set
- (void)setTitle:(NSString *)title{
    _title = title;
    
    self.titleLab.text = title;
    if(self.style == SUScreenCellStyleInput){
        self.mainTF.placeholder = [NSString stringWithFormat:@"请输入%@",title];
    } else if (self.style == SUScreenCellStyleSelect){
        self.mainPicker.placeholder = [NSString stringWithFormat:@"请选择%@",title];
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
    }  else if (self.style == SUScreenCellStyleRadio){
        self.mainRadio.selected = NO;
    }
}
@end
