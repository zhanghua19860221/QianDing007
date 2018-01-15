//
//  UIButton+ZHCountDown.m
//  ZHCountDownButton
//
//  Created by 张华 on 18/1/13.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "UIButton+ZHCountDown.h"

static NSString *zhTempText;


@implementation UIButton (ZHCountDown)
- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(void))countDownBlock{
    
    [self initButtonData];
    
    [self startTime:time];
    
    if (countDownBlock) {
        countDownBlock();
    }
}
- (void)initButtonData{
    
    zhTempText = [NSString stringWithFormat:@"%@",self.titleLabel.text];
    
}
- (void)startTime:(int)time{
    
    __block int timeout = time;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束
        if(timeout <= 0){
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:zhTempText forState:UIControlStateNormal];
                self.backgroundColor = COLORFromRGB(0xe10000);
                self.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *text = [NSString stringWithFormat:@"%02d重新获取",timeout];
                [self setTitle:text forState:UIControlStateNormal];
                self.backgroundColor = COLORFromRGB(0xf9cccc);
                self.userInteractionEnabled = NO;
                
            });
            
            timeout --;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
}
@end
