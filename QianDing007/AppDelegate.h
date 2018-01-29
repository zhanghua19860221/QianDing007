//
//  AppDelegate.h
//  QianDing007
//
//  Created by 张华 on 17/12/8.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMReceiveMessageDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNav;

@end

