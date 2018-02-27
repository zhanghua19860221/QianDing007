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
#import <AVFoundation/AVFoundation.h>
#import <FMDatabase.h>
#import <FMDB.h>
#import "LoginMain.h"
//推送通知
#import <UserNotifications/UserNotifications.h>





@interface AppDelegate : UIResponder <UIApplicationDelegate,RCIMReceiveMessageDelegate,AVSpeechSynthesizerDelegate,RCIMConnectionStatusDelegate,RCIMUserInfoDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *mainNav;
@property (strong, nonatomic) LoginMain *root;

@end

