//
//  SUCardView.m
//  GHKC
//
//  Created by SunQ on 2019/7/3.
//  Copyright © 2019年 Tonghui Network Technology Co., Ltd. All rights reserved.
//

#import "SUCardView.h"
#import "SUCardLabel.h"
@interface SUCardView()<SUCardLabelDelegate>
@property (nonatomic, strong, readwrite) NSString      *selectValue;
@end
@implementation SUCardView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.radioSize = CGSizeMake(60, 30);//默认的按钮尺寸
}

- (void)setPickerData:(NSDictionary *)pickerData{
    _pickerData = pickerData;
    
    NSArray *allKeys = [pickerData allKeys];
    for (int i = 0; i < allKeys.count; i ++) {
        NSString *value = [pickerData objectForKey:allKeys[i]];
        SUCardLabel *label = [SUCardLabel creatLabelWith:SUCardLabelStyleRadio];
        if(i == 0) {
            self.selectValue = allKeys[i];
            label.selected = YES;
        }
        label.text = value;
        label.val  = allKeys[i];
        label.delegate = self;
        [self addSubview:label];
    }
}

- (void)setDefaultValue:(NSString *)defaultValue{
    _defaultValue = defaultValue;
    
    for (SUCardLabel *label in self.subviews) {
        if([label isKindOfClass:[SUCardLabel class]]){
            if([label.val isEqualToString:defaultValue]){
                self.selectValue = defaultValue;
                label.selected = YES;
            }else{
                label.selected = NO;
            }
        }
    }
}

- (void)suCardLabelTouchUpInside:(SUCardLabel *)sender{
    if(sender.selected){
        self.selectValue = sender.val;
    }else self.selectValue = @"";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    float width                 = self.frame.size.width;
    
    float labelH                = self.radioSize.height;//按钮高度
    float labelW                = self.radioSize.width;//按钮宽度
    float labelX                = 0;
    float labelY                = 6;
    
    for (SUCardLabel *label in [self subviews]) {
        if(![label isKindOfClass:[SUCardLabel class]]){
            continue;
        }
        if((labelX + 15 + labelW) > width){//超出一行，则换行
            labelX          = 0;
            labelY          += (labelH + 4);
            label.frame     = CGRectMake(labelX, labelY, labelW, labelH);
            labelX          += labelW + 15; //水平间隙
        }else{//没有超出，平铺
            label.frame     = CGRectMake(labelX, labelY, labelW, labelH);
            labelX          += labelW + 15; //水平间隙
        }
    }
}

- (CGFloat)getCardViewHeightWithSupW:(CGFloat)width{
    if (self.pickerData){
        float labelH                = self.radioSize.height;//按钮高度
        float labelW                = self.radioSize.width;//按钮宽度
        float labelX                = 0;
        float labelY                = 0;
        for (SUCardLabel *label in [self subviews]) {
            if([label isKindOfClass:[SUCardLabel class]]){
                if((labelX + 15 + labelW) > width){//超出一行，则换行
                    labelY          += (labelH + 4);
                    labelX          = labelW + 15; //水平间隙
                }else{//没有超出，平铺
                    labelX          += labelW + 15; //水平间隙
                }
            }
        }
        return labelY + labelH;
    }
    return 0.0;
}
@end
