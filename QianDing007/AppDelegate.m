//
//  AppDelegate.m
//  QianDing007
//
//  Created by 张华 on 17/12/8.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginMain.h"
#import "RootViewController.h"

@interface AppDelegate (){
    
    AVSpeechSynthesizer*zh_voice;//语音播报
    
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"%@",@"didFinishLaunchingWithOptions");

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSString *str = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"] ;
    if (str == NULL){
        LoginMain *root = [[LoginMain alloc] init];
        self.mainNav = [[UINavigationController alloc] initWithRootViewController:root];
    }else{

        RootViewController *root = [[RootViewController alloc] init];
        self.mainNav = [[UINavigationController alloc] initWithRootViewController:root];
    }
    self.window.rootViewController = self.mainNav ;
    
    //集成融云
    [self IntegrateRongCloud];
    
    //是否出现引导页
    [self IsGuidePage];
    [self mobShareInit];

    // Override point for customization after application launch.
    return YES;
}

/**
 集成融云消息
 */
- (void)IntegrateRongCloud{
    //初始化融云SDK
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
 
}
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    if ([message.objectName isEqualToString:@"RC:TxtMsg"]) {
        RCTextMessage *content = (RCTextMessage*)message.content;

        NSData * getJsonData = [content.extra dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * getDict = [NSJSONSerialization JSONObjectWithData:getJsonData options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"getDict == %@",getDict);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"saveFMDBData" object:nil userInfo:getDict];

        zh_voice= [[AVSpeechSynthesizer alloc]init];
    
        zh_voice.delegate=self;//挂上代理
    
        AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:getDict[@"title"]];//需要转换的文字
    
        utterance.rate=0.52;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
    
        AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
    
        utterance.voice= voice;
    
        [zh_voice speakUtterance:utterance];//开始
        
        }
    
}
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
- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@",@"applicationWillResignActive");
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@",@"applicationDidEnterBackground");

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@",@"applicationWillEnterForeground");

    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@",@"applicationDidBecomeActive");

    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@",@"applicationWillTerminate");

    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
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

@end
