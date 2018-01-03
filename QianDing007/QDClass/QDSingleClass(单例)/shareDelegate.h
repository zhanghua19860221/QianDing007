//
//  shareDelegate.h
//  Nbber
//
//  Created by 张华 on 15/10/22.
//  Copyright © 2015年 zhanghau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shareDelegate : NSObject

//用来记录用户是否设置过账户
@property(nonatomic,assign)BOOL b_setAccount ;

+ (shareDelegate *)sharedManager;

/**

 NSUserDefaults单例
 */
+ (NSUserDefaults *)shareNSUserDefaults;

/**
 
 获取字符串长度   来调整label的 宽度  SystemFontOfSize
 */
+ (CGFloat) labelWidth:(NSString * ) text Font:(float) font;

/**
 
 获取字符串高度   来调整label的 高度  system
 */
+ (CGFloat) labelHeight:(NSString * ) text Font:(float) font;
/**
 
 获得 当前网络状态
 */
+ (NSString *)getNetWorkStates ;

/**
 
 字符串转 base64字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text;


/**
 
 字典转json字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

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
@end
