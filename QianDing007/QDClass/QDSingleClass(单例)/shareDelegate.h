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
+(NSUserDefaults *)shareNSUserDefaults;

/**
 
 设置状态栏颜色
 */
+(void)setStatusBarBackgroundColor:(UIColor *)color;
/**
 
 获取字符串长度   来调整label的 宽度  SystemFontOfSize
 */
+(CGFloat) labelWidth:(NSString * ) text Font:(float) font;

/**
 
 获取字符串高度   来调整label的 高度  system
 */
+(CGFloat) labelHeight:(NSString * ) text Font:(float) font;

/**
 
 获得 当前网络状态
 */
+(NSString *)getNetWorkStates ;


@end
