//
//  ZHProgressView.m
//  QianDing001
//
//  Created by 张华 on 18/1/8.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "ZHProgressView.h"
#import <Masonry.h>
#import <MASConstraintMaker.h>
@implementation ZHProgressView
- (id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

        _progressView = [[UIActivityIndicatorView alloc]
                      initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _progressView.color = [UIColor whiteColor];
        [self addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(100);
            
        }];
        [_progressView startAnimating];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"loading...";
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_progressView.mas_bottom).offset(10);
            make.centerX.equalTo(_progressView.mas_centerX);
            make.width.mas_equalTo(_progressView.mas_width);
            make.height.mas_equalTo(14);

        }];
        
        
    }
    
    return  self;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
