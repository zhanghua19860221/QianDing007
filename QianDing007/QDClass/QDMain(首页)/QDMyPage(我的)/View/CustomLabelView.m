//
//  CustomLabelView.m
//  QianDing007
//
//  Created by 张华 on 17/12/16.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "CustomLabelView.h"
#import "SecuritySetController.h"
#import "UserViewController.h"
#import "MydelegateViewController.h"
#import "AboutWeController.h"
#import "CallViewController.h"
#import "UpdateController.h"

@implementation CustomLabelView
-(id)initWithFrame:(NSString *)firstImage firstLabel:(NSString*)firstStr secondLabel:(NSString*)secondStr secondImage:(NSString*)secondImage{
    self = [self init];
    if (self) {
        self.firstImage = firstImage;
        self.secondImage = secondImage;
        self.firstStr = firstStr;
        self.secondStr = secondStr;

        [self configView];
    }
    return self;
}
- (void)configView{
    
    self.iconView = [[UIImageView alloc] init];
    [self.iconView setImage:[UIImage imageNamed:self.firstImage]];
//    self.iconView.backgroundColor = [UIColor redColor];
    [self addSubview:self.iconView];

    self.directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.directionBtn setImage:[UIImage imageNamed:self.secondImage] forState:UIControlStateNormal];
    [self.directionBtn addTarget:self action:@selector(clickToVc) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.directionBtn];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.text = self.firstStr;
    self.firstLabel.font = [UIFont systemFontOfSize:16];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.firstLabel];
    
    if (![self.secondStr  isEqual: @"空"]) {
        
        self.secondLabel = [[UILabel alloc] init];
        self.secondLabel.text = self.secondStr;
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.secondLabel];
        
    }

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@22);
        make.height.mas_offset(22);

    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(22);

    }];
    
    [self.directionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.width.mas_offset(20);
        make.height.mas_offset(22);
        
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self.directionBtn.mas_left).offset(-15);
        make.width.mas_offset(90);
        make.height.mas_offset(22);
        
    }];

}

- (void)clickToVc{
    if ([self.firstStr isEqualToString:@"商户认证"]) {
        
    }else if([self.firstStr isEqualToString:@"我的代理"]){
    
    
    }else if([self.firstStr isEqualToString:@"安全设置"]){
        
        
    }else if([self.firstStr isEqualToString:@"关于我们"]){
        
        
    }else if([self.firstStr isEqualToString:@"联系我们"]){
        
        
    }else if([self.firstStr isEqualToString:@"检查更新"]){
        
        
    }




    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
