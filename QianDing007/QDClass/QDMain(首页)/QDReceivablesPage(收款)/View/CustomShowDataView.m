//
//  CustomShowDataView.m
//  QianDing007
//
//  Created by 张华 on 17/12/13.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CustomShowDataView.h"


@implementation CustomShowDataView
- (id)initNumber:(NSString*)first ratioMoney:(NSString*)second nameType:(NSString*)third{
    self = [super init];
    if (self) {
        self.firstData = first;
        self.secondData = second;
        self.thirdData = third;
        [self createView];
    }
    return self;
}
/**
 创建展示Label
 */
-(void)createView{
        
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.text = self.firstData;
    self.firstLabel.font = [UIFont systemFontOfSize:21];
    self.firstLabel.textColor = COLORFromRGB(0xe10000);
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.firstLabel];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.text = self.secondData;
    self.secondLabel.textColor = COLORFromRGB(0xe55555);
    self.secondLabel.font = [UIFont systemFontOfSize:12];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.secondLabel];
    
    self.thirdLabel = [[UILabel alloc] init];
    self.thirdLabel.text = self.thirdData;
    self.thirdLabel.font = [UIFont systemFontOfSize:16];
    self.thirdLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.thirdLabel];
    
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(20/SCALE_Y);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(21/SCALE_Y);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.firstLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(12);
        
    }];
    [self.thirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.secondLabel.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self);
        make.height.mas_offset(16/SCALE_Y);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
