//
//  AppDelegate.m
//  QianDing007
//
//  Created by 张华 on 17/12/8.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
/*
    应用程序启动后，要执行的委托调用，系统启动代理（第一个页面的加载）
 */
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%@",@"应用程序启动后，要执行的委托调用，系统启动代理（第一个页面的加载）");

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *str = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"] ;
    if (str == NULL){
        self.root = [[LoginMain alloc] init];
        self.mainNav = [[UINavigationController alloc] initWithRootViewController:self.root];
    }else{
        RootViewController *rootOne = [[RootViewController alloc] init];
        self.mainNav = [[UINavigationController alloc] initWithRootViewController:rootOne];
    }
    self.window.rootViewController = self.mainNav ;
    
    //集成融云
    [self IntegrateRongCloud];
    
    //是否出现引导页
    //  [self IsGuidePage];
    
    //mob分享
    [self mobShareInit];
    
    //语音播报代理方法
    [shareDelegate shareAVSpeechSynthesizer].delegate=self;
    
    // 设置应用程序的图标右上角的数字
//    [application setApplicationIconBadgeNumber:50];
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                     categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
            
        }
        
    }

    // Override point for customization after application launch.
    return YES;
}

#pragma ************************融云集成******************************

/**
 集成融云消息
 */
- (void)IntegrateRongCloud{
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    //遵守融云消息监听协议
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    //IMKit连接状态的监听器
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //设置前台提示音 NO 开启 YES 关闭
    [[RCIM sharedRCIM] setDisableMessageAlertSound:YES];
    //是否关闭本地通知，默认是打开的
    [[RCIM sharedRCIM] setDisableMessageNotificaiton:NO];

}
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
        
    if ([message.objectName isEqualToString:@"RC:TxtMsg"]) {
        RCTextMessage *content = (RCTextMessage*)message.content;
        NSData * getJsonData = [content.extra dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:nil];
        
        if (![getDict[@"title"] isEqualToString:@""]&& getDict[@"title"]!=NULL ) {

            [[NSNotificationCenter defaultCenter] postNotificationName:@"saveFMDBData" object:nil userInfo:getDict];
        }
        //用户是否屏蔽语音
        BOOL is_OpenSound =  [[shareDelegate shareNSUserDefaults] boolForKey:@"is_OpenSound"];
        
        if (!is_OpenSound) {

            AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:getDict[@"title"]];//需要转换的文字
            
            utterance.rate=0.52;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
            
            AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
            
            utterance.voice= voice;
            
            [[shareDelegate shareAVSpeechSynthesizer] speakUtterance:utterance];//开始
        }

        
    }
    
}

/**
 
 *  网络状态变化。
 
 *
 
 *  @param status 网络状态。
 
 */

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"提示"
                              
                              message:@"您"
                              
                              @"的帐号在别的设备上登录，您被迫下线！"
                              
                              delegate:self
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];

    }
}

//UIAlertView 协议代理方法 实现融云单点登陆功能

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.root = [[LoginMain alloc] init];
    [self.mainNav pushViewController:self.root animated:YES];
    
}
/**
 *程序在后台运行时 回调的方法 ，可以查询发送者信息 弹出本地通知
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion{
            //此处为了演示写了一个用户信息
            RCUserInfo *user = [[RCUserInfo alloc]init];
            user.userId = userId;
            user.name = @"钱叮";
            return completion(user);
}
/**
 *是否发送后台 NO接收本地通知 Yes不可接受本地通知
 */
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message withSenderName:(NSString *)senderName{
    
    return NO;
}

#pragma ************************后台语音播报******************************
/*
 应用程序将要由活动状态切换到非活动状态时执行的委托调用，如按下home 按钮，返回主屏幕，或全屏之间切换应用程序等。
*/
//程序后台运行时 激活多媒体处理事件 保持语音播报
-(void)applicationWillResignActive:(UIApplication* )application{
    //开启后台处理多媒体事件
    NSLog(@"%@",@" 应用程序将要由活动状态切换到非活动状态时执行的委托调用");
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    //后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    //这样做，可以在按home键进入后台后 ，播放一段时间，几分钟吧。
    //但是不能持续播放网络歌曲，若需要持续播放网络歌曲，还需要申请后台任务id，具体做法是：
    //其中的_bgTaskId是后台任务
    UIBackgroundTaskIdentifier _bgTaskId;
    _bgTaskId = [AppDelegate backgroundPlayerID:_bgTaskId];
}

//程序后台运行时 激活多媒体处理事件 保持语音播报

//实现一下backgroundPlayerID:这个方法:
+(UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId{
    //设置并激活音频会话类别
    AVAudioSession *session=[AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    //允许应用程序接收远程控制
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId=UIBackgroundTaskInvalid;
    newTaskId=[[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if(newTaskId!=UIBackgroundTaskInvalid&&backTaskId!=UIBackgroundTaskInvalid)
    {
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}

#pragma ************************mob分享******************************

/**
 初始化配置mob分享
 */
- (void)mobShareInit{
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ),
                                        ]
                             onImport:^(SSDKPlatformType platformType){
         switch (platformType){
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
      }onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
         
         switch (platformType){

             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx88ba0f01d568ba1c"
                          appSecret:@"9c441187acc8e59a5763b3f1ab8338ac"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;

                default:
                   break;
        }
    }];

}
#pragma ************************引导页******************************

-(void)IsGuidePage{
    
    NSString * Version = [[shareDelegate  shareNSUserDefaults]  objectForKey:@"AppVersion"];
    if (Version == nil) {
        Version = @"";
    }
    //获取plist里面的版本号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //CFShow(CFBridgingRetain(infoDictionary));

    //app应用版本号
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //版本号不想等时执行 括号内代码
    if ( ![Version isEqualToString:app_Version]  ) {
    
        StarViewPictrue * star = [[StarViewPictrue alloc]init];
        [self.window addSubview:star];
        [[shareDelegate shareNSUserDefaults] setObject:app_Version forKey:@"AppVersion"];
    }
}

/*
 在应用程序已进入后台程序时，要执行的委托调用。所以要设置后台继续运行，则在这个函数里面设置即可。
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@",@"在应用程序已进入后台程序时，要执行的委托调用。");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
/*
 在应用程序将要进入前台时(被激活)，要执行的委托调用，与applicationWillResignActive方法相对应。
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@",@"在应用程序将要进入前台时(被激活)，要执行的委托调用");

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
/*
 在应用程序已被激活后，要执行的委托调用，刚好与  applicationDidEnterBackground 方法相对应。
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@",@"在应用程序已被激活后，要执行的委托调用");

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
/*
 在应用程序要完全退出的时候，要执行的委托调用。
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@",@"在应用程序要完全退出的时候，要执行的委托调用。");

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}
#pragma ************************支付宝集成******************************

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMyLevel" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
//            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}
///**
// 网络提示 弹出框
// */
//- (void)adShowAlert:(NSString *)warning{
//
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
//                                                                   message:warning
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
//                                                          handler:^(UIAlertAction * action) {
//                                                              //响应事件
//                                                              NSLog(@"action = %@", action);
//                                                          }];
//
//    [alert addAction:defaultAction];
//
//    UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    alertWindow.rootViewController = [[UIViewController alloc] init];
//    alertWindow.windowLevel = UIWindowLevelAlert + 1;
//    [alertWindow makeKeyAndVisible];
//    [alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//
//}
@end
