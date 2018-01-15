//
//  UIButton+ZHCountDown.h
//  ZHCountDownButton
//
//  Created by 张华 on 18/1/13.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZHCountDown)
- (void)startCountDownTime:(int)time withCountDownBlock:(void(^)(void))countDownBlock;

@end
