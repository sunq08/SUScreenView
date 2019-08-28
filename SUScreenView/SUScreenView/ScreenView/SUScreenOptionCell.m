//
//  SUScreenOptionCell.m
//  GHKC
//
//  Created by SunQ on 2019/8/18.
//  Copyright © 2019年 Tonghui Network Technology Co., Ltd. All rights reserved.
//

#import "SUScreenOptionCell.h"
#import "SUScreenConfig.h"
#import "SUTextFiledPicker.h"
#import "SUCardLabel.h"
@interface SUScreenOptionCell()<SUCardLabelDelegate,UITextFieldDelegate>

@property (nonatomic ,strong) UILabel               *titleLab;//title
@property (nonatomic ,strong) UITextField           *mainTF;//tf
@property (nonatomic ,strong) SUTextFiledPicker     *mainPicker;//picker
@property (nonatomic ,strong) SUTextFiledPicker     *mainDatePicker;//datepicker
@property (nonatomic ,strong) UIButton              *mainRadio;//radio
@property (nonatomic ,strong) UIView                *cardView;//cardView
@property (nonatomic ,strong) SUTextFiledPicker     *startDatePicker;//startDatePicker
@property (nonatomic ,strong) UILabel               *dateRangeLabel;//dateRangeLabel
@property (nonatomic ,strong) SUTextFiledPicker     *endDatePicker;//endDatePicker


@end

@implementation SUScreenOptionCell

- (id)initWithFrame:(CGRect)frame style:(SUScreenOptionCellStyle)style identifier:(NSString *)identifier {
    self = [super initWithFrame:frame];
    if (self) {
        self.style                  = style;
        self.identifier             = identifier;
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
        [self addSubview:self.customTF];
    } else if(self.style == SUScreenCellStyleCardPicker) {//card
        [self addSubview:self.cardView];
    } else if(self.style == SUScreenCellStyleCardMultiple) {//card
        [self addSubview:self.cardView];
    } else if(self.style == SUScreenCellStyleDateRange) {//DateRange
        [self addSubview:self.startDatePicker];
        [self addSubview:self.endDatePicker];
        [self addSubview:self.dateRangeLabel];
    } else {
        NSLog(@"错误的cell类型");
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    float width                     = self.frame.size.width;
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
        self.customTF.frame         = CGRectMake(15, 44, width - 30, 30);
    } else if(self.style == SUScreenCellStyleCardPicker || self.style == SUScreenCellStyleCardMultiple){//card
        float labelH                = 30;//按钮高度
        float labelX                = 0;
        float labelY                = 0;
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]]){
                float labelW = [SUScreenHelper widthWithString:label.text fs:12 height:labelH] + 8;
                if(labelW<SULabelMinWidth){
                    labelW = SULabelMinWidth;
                }
                if((labelX + 4 + labelW) > (width - 30)){//超出一行，则换行
                    if((labelW + 4) >= (width - 30)){//看看是不是因为这个lab自己就超出了
                        labelW      = (width - 30);
                    }
                    labelX          = 0;
                    labelY          += (labelH + 4);
                    label.frame     = CGRectMake(labelX, labelY, labelW, labelH);
                    labelX          += labelW + 4; //水平间隙
                }else{//没有超出，平铺
                    label.frame     = CGRectMake(labelX, labelY, labelW, labelH);
                    labelX          += labelW + 4; //水平间隙
                }
            }
        }
        float cardH                 = labelY + labelH;
        self.cardView.frame         = CGRectMake(15, 44, width - 30, cardH);
    } else if(self.style == SUScreenCellStyleDateRange) {//DateRange
        float pickerW = (width - 30 - 30)/2;
        self.startDatePicker.frame = CGRectMake(15, 44, pickerW, 30);
        self.dateRangeLabel.frame = CGRectMake(15+pickerW, 44, 30, 30);
        self.endDatePicker.frame = CGRectMake(15+pickerW+30, 44, pickerW, 30);
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
        [_mainTF addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
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
        _mainTF.inputView.hidden = YES;
        [_mainPicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
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
        [_mainDatePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [SUScreenHelper layoutViewRadioWith:_mainDatePicker radio:2];
    }
    return _mainDatePicker;
}
-(void)setDateFormate:(NSString *)dateFormate{
    _dateFormate = dateFormate;
    if(self.style == SUScreenCellStyleDatePicker){
        self.mainDatePicker.dateFormate = self.dateFormate;
    }else if(self.style == SUScreenCellStyleDateRange){
        self.startDatePicker.dateFormate = self.dateFormate;
        self.endDatePicker.dateFormate = self.dateFormate;
    }
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

- (UIView *)cardView{
    if(!_cardView){
        _cardView = [[UIView alloc]init];
    }
    return _cardView;
}

- (SUTextFiledPicker *)startDatePicker{
    if(!_startDatePicker){
        _startDatePicker                 = [SUTextFiledPicker creatTextFiledWithStyle:SUTextFiledTimePicker];
        _startDatePicker.placeholder     = @"请选择";
        _startDatePicker.font            = [UIFont systemFontOfSize:13];
        _startDatePicker.borderStyle     = UITextBorderStyleNone;
        _startDatePicker.backgroundColor = [UIColor whiteColor];
        _startDatePicker.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _startDatePicker.leftViewMode    = UITextFieldViewModeAlways;
        [_startDatePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [SUScreenHelper layoutViewRadioWith:_startDatePicker radio:2];
    }
    return _startDatePicker;
}

- (SUTextFiledPicker *)endDatePicker{
    if(!_endDatePicker){
        _endDatePicker                 = [SUTextFiledPicker creatTextFiledWithStyle:SUTextFiledTimePicker];
        _endDatePicker.font            = [UIFont systemFontOfSize:13];
        _endDatePicker.placeholder     = @"请选择";
        _endDatePicker.borderStyle     = UITextBorderStyleNone;
        _endDatePicker.backgroundColor = [UIColor whiteColor];
        _endDatePicker.leftView        = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _endDatePicker.leftViewMode    = UITextFieldViewModeAlways;
        [_endDatePicker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [SUScreenHelper layoutViewRadioWith:_endDatePicker radio:2];
    }
    return _endDatePicker;
}

- (UILabel *)dateRangeLabel{
    if(!_dateRangeLabel){
        _dateRangeLabel                 = [[UILabel alloc]init];
        _dateRangeLabel.font            = [UIFont systemFontOfSize:13];
        _dateRangeLabel.textAlignment   = NSTextAlignmentCenter;
        _dateRangeLabel.text            = @"到";
        _dateRangeLabel.textColor       = [UIColor darkGrayColor];
    }
    return _dateRangeLabel;
}

- (UITextField *)customTF{
    if(!_customTF){
        _customTF                     = [[UITextField alloc]init];
        _customTF.font                = [UIFont systemFontOfSize:13];
        _customTF.borderStyle         = UITextBorderStyleNone;
        _customTF.backgroundColor     = [UIColor whiteColor];
        _customTF.leftView            = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _customTF.leftViewMode        = UITextFieldViewModeAlways;
        _customTF.delegate            = self;
        [_customTF addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingDidEnd];
        [SUScreenHelper layoutViewRadioWith:_mainTF radio:2];
    }
    return _customTF;
}

- (NSDictionary *)data{
    if(self.style == SUScreenCellStyleInput){
        return @{self.identifier:self.mainTF.text};
    }
    if(self.style == SUScreenCellStyleSelect){
        return @{self.identifier:self.mainPicker.val?self.mainPicker.val:@""};
    }
    if(self.style == SUScreenCellStyleRadio){
        return @{self.identifier:self.mainRadio.selected?@"1":@"0"};
    }
    if(self.style == SUScreenCellStyleDatePicker){
        return @{self.identifier:self.mainDatePicker.text};
    }
    if(self.style == SUScreenCellStyleCardPicker){
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]] && label.selected){
                return @{self.identifier:label.val};
            }
        }
    }
    if(self.style == SUScreenCellStyleCardMultiple){
        NSMutableString *value = [NSMutableString stringWithString:@""];
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]] && label.selected){
                if([value isEqualToString:@""]){
                    [value appendString:label.val];
                }else [value appendFormat:@",%@",label.val];
            }
        }
        return @{self.identifier:value};
    }
    if(self.style == SUScreenCellStyleDateRange){
        NSArray *identifiers = [self.identifier componentsSeparatedByString:@","];
        return @{identifiers[0]:self.startDatePicker.text,identifiers[1]:self.endDatePicker.text};
    }
    if(self.style == SUScreenCellStyleOther){
        return @{self.identifier:self.customValue?self.customValue:self.customTF.text};
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
    } else if (self.style == SUScreenCellStyleDatePicker){
        self.mainDatePicker.placeholder = [NSString stringWithFormat:@"请选择%@",title];
    } else if (self.style == SUScreenCellStyleOther){
        self.customTF.placeholder = [NSString stringWithFormat:@"请选择%@",title];
    }
}

- (void)setPickerData:(NSDictionary *)pickerData{
    _pickerData = pickerData;
    
    if(self.style == SUScreenCellStyleSelect){
        self.mainPicker.pickerData = pickerData;
    }else if (self.style == SUScreenCellStyleCardPicker || self.style == SUScreenCellStyleCardMultiple){
        NSArray *allKeys = [pickerData allKeys];
        for (int i = 0; i < allKeys.count; i ++) {
            NSString *value = [pickerData objectForKey:allKeys[i]];
            SUCardLabel *label = (self.style == SUScreenCellStyleCardPicker)?[SUCardLabel creatLabelWith:SUCardLabelStyleRadio]:[SUCardLabel creatLabelWith:SUCardLabelStyleCheckBox];
            label.text = value;
            label.val  = allKeys[i];
            label.delegate = self;
            [self.cardView addSubview:label];
        }
    }
}

- (void)setDynamicValue:(NSString *)dynamicValue{
    if(self.style == SUScreenCellStyleInput){
        self.mainTF.text = dynamicValue;
    }
    if(self.style == SUScreenCellStyleSelect){
        self.mainPicker.val = dynamicValue;
    }
    if(self.style == SUScreenCellStyleRadio){
        self.mainRadio.selected = ([dynamicValue isEqualToString:@"1"]);
    }
    if(self.style == SUScreenCellStyleDatePicker){
        self.mainDatePicker.text = dynamicValue;
    }
    if(self.style == SUScreenCellStyleCardPicker){
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]]){
                label.selected = ([label.val isEqualToString:dynamicValue]);
            }
        }
    }
    if(self.style == SUScreenCellStyleCardMultiple){
        
    }
    if(self.style == SUScreenCellStyleDateRange){//
        
    }
    if(self.style == SUScreenCellStyleOther){
        self.customTF.text = dynamicValue;
        self.customValue = dynamicValue;
    }
}

#pragma mark - privately
- (void)radioClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if(self.valueChanged){
        self.valueChanged(sender.selected?@"1":@"0", self.identifier);
    }
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
    } else if (self.style == SUScreenCellStyleDateRange){
        self.startDatePicker.val = @"";
        self.endDatePicker.val   = @"";
    } else if (self.style == SUScreenCellStyleCardPicker || self.style == SUScreenCellStyleCardMultiple){
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]]){
                label.selected = NO;
            }
        }
    } else if (self.style == SUScreenCellStyleOther) {//自定义类型
        self.customTF.text = @"";
        self.customValue = @"";
    }
}

- (void)textFieldValueChanged:(UITextField *)sender{
    if(self.valueChanged){
        self.valueChanged(sender.text, self.identifier);
    }
}
- (void)pickerValueChanged:(SUTextFiledPicker *)sender{
    if(self.valueChanged){
        self.valueChanged(sender.val?sender.val:@"", self.identifier);
    }
}

- (void)suCardLabelTouchUpInside:(SUCardLabel *)sender{
    if(self.valueChanged){
        self.valueChanged(sender.val?sender.val:@"", self.identifier);
    }
}
/** 获取卡片选择视图的高度*/
- (CGFloat)getCardViewHeightWithSupW:(CGFloat)width{
    if((self.style == SUScreenCellStyleCardPicker || self.style == SUScreenCellStyleCardMultiple) && self.pickerData){
        float labelH                = 30;//按钮高度
        float labelX                = 0;
        float labelY                = 0;
        for (SUCardLabel *label in [self.cardView subviews]) {
            if([label isKindOfClass:[SUCardLabel class]]){
                float labelW = [SUScreenHelper widthWithString:label.text fs:12 height:labelH] + 8;
                if(labelW<SULabelMinWidth){
                    labelW = SULabelMinWidth;
                }
                if((labelX + 4 + labelW)>(width-30)){//超出一行，则换行
                    if((labelW + 4)>=(width-30)) labelW      = (width-30);
                    labelX          = 0 + labelW + 4;
                    labelY          += (labelH + 4);
                }else labelX        += labelW + 4; //水平间隙
            }
        }
        return labelY + labelH + 44.0;
    }
    return 44.0;
}

#pragma mark - text filed delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.suScreenCellClick(self.identifier);
    return NO;
}

@end
