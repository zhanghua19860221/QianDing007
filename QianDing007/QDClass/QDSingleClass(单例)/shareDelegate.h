//
//  shareDelegate.h
//  Nbber
//
//  Created by 张华 on 15/10/22.
//  Copyright © 2015年 zhanghau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHProgressView.h"
#import <FMDatabase.h>
#import <FMDB.h>
#import <AVFoundation/AVFoundation.h>

@interface shareDelegate : NSObject

//用来记录用户是否设置过账户
@property(nonatomic,assign)BOOL b_setAccount ;
//记录融云用户id
@property(nonatomic,assign)NSString *b_userID ;



+ (shareDelegate *)sharedManager;

/**

 NSUserDefaults单例
 */
+ (NSUserDefaults *)shareNSUserDefaults;

/**
 AVSpeechSynthesizer 语音播报单例
 
 */
+ (AVSpeechSynthesizer *)shareAVSpeechSynthesizer;

/**
 
 获取字符串长度   来调整label的 宽度  SystemFontOfSize
 */
+ (CGFloat) labelWidth:(NSString * ) text Font:(float) font;

/**
 
 根据字符串 获取控件高度
 */
+ (CGFloat)labelHeightText:(NSString * ) text Font:(float) font Width:(float)wid;
/**
 
 获得 当前网络状态
 */
+ (NSString *)getNetWorkStates ;


/**
 验证密码正则表达式 密码为 6-18位的 字母＋数字

 @param pass 密码
 @return 是否是字母数字组合
 */
+ (BOOL)judgePassWordLegal:(NSString *)pass;

/**
 
 把Unicode编码转换为 中文
 */
+ (NSString *)logDic:(NSDictionary *)dic;


/**
 验证手机号码正则表达式

 @param phoneNum 手机号码
 @return 是否为手机号码
 */
+ (BOOL)isChinaMobile:(NSString *)phoneNum;


/**
 纯中文正则判断
 */
+ (BOOL)deptNameInputShouldChinese:(NSString *)text;

/**
 邮箱正则验证
 */
+ (BOOL)IsEmailAdress:(NSString *)Email;
/**
 自定义进度条
 */
+ (ZHProgressView*)shareZHProgress;

/**
 
 特殊字符正则表达式
 */
+ (BOOL)isAllCharacterString:(NSString *)string;

/**
 身份证验证
 
 */
+ (BOOL)isLenghtCard:(NSString *)value;


/**
 判断中文字符串的长度 不高于11个字
 */
+ (BOOL)isStringLengthName:(NSString *)name;


/**
 判断是否为银行卡号
 
 */
+ (BOOL)checkCardNo:(NSString*) cardNo;

/**
 是否是纯数字
 
 */
+ (BOOL)deptNumInputShouldNumber:(NSString *)text;

/**
 数据库单利
 
 */
+ (FMDatabase*)shareFMDatabase;
/**
 把图片压缩到 1兆以内
 
 */
+(NSData *)dealBigImage:(UIImage *)image;

/**
 企业统一社会信用代码验证
 
 */
+ (BOOL)isSocialCredit18Number:(NSString *)socialCreditNum;

/**
 url 拼接
 
 */
+ (NSMutableString *)stringBuilder:(NSString *)url;

/**
 返回登录页弹出框
 
 */
+ (void)returnLoginController:(NSString *)info  UINavigationController:(UINavigationController *)nav UIViewController:(UIViewController *)vc;


@end
