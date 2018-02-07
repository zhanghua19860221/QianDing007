//
//  shareDelegate.m
//  Nbber
//
//  Created by 张华 on 15/10/22.
//  Copyright © 2015年 zhanghau. All rights reserved.
//

#import "shareDelegate.h"
@implementation shareDelegate

/**

 @return 获取单例对象
 */
+ (shareDelegate *)sharedManager
{
    static shareDelegate *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
        
    });
    return sharedAccountManagerInstance;
}

/**
 NSUserDefaults单例对象

 */
+ (NSUserDefaults *)shareNSUserDefaults
{
    static NSUserDefaults * sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance = [[NSUserDefaults alloc] init];
        
    });
    return sharedAccountManagerInstance;
}

/**
 获取字符串长度

 @param text 字符串
 @param font 字符串字号
 @return 字符串长度
 */
+ (CGFloat) labelWidth:(NSString * ) text Font:(float) font
{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];

    return rect.size.width;
}

/**
 根据字符串 获取控件高度

 @param text 字符串
 @param font 字符串字号
 @param wid  承载字符串控件宽度
 @return控件高度
 */
+ (CGFloat)labelHeightText:(NSString * )text  Font:(float)font Width:(float)wid{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(wid, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}


/**
 
 获取当前网络状态
 */
+ (NSString *)getNetWorkStates{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}
/**
 
 把Unicode编码转换为 中文
 */
+ (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;
}
//^ 匹配一行的开头位置
//(?![0-9]+$) 预测该位置后面不全是数字
//(?![a-zA-Z]+$) 预测该位置后面不全是字母
//[0-9A-Za-z] {8,16} 由8-16位数字或这字母组成
//$ 匹配行结尾位置

/**
 密码设置验证 正则表达式
 */
+ (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}
/**
 
 手机号码验证正则表达式
 */
+ (BOOL)isChinaMobile:(NSString *)phoneNum{
    
    NSString *CM = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678]|2[0-9])\\d{8}$";
    
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    
    return [regextestcm evaluateWithObject:phoneNum];
    
}

/**
 
 特殊字符正则表达式
 */
+ (BOOL)isAllCharacterString:(NSString *)string
{
    NSString *regex = @"[~`!@#$%^&*()_+-=[]|{};':\",./<>?]{,}/";//规定的特殊字符，可以自己随意添加
    
    //计算字符串长度
    NSInteger str_length = [string length];
    
    NSInteger allIndex = 0;
    for (int i = 0; i<str_length; i++) {
        //取出i
        NSString *subStr = [string substringWithRange:NSMakeRange(i, 1)];
        if([regex rangeOfString:subStr].location != NSNotFound)
        {  //存在
            allIndex++;
        }
    }
    
    if (str_length == allIndex) {
        //纯特殊字符
        return YES;
    }
    else
    {
        //非纯特殊字符
        return NO;
    }
}

/**
 纯中文正则判断
 */
+ (BOOL)deptNameInputShouldChinese:(NSString *)text{
    
    NSString *regex = @"[\u4e00-\u9fa5]+";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:text];
}

/**
 邮箱正则验证
 */
+ (BOOL)IsEmailAdress:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    

}


/**
 判断中文字符串的长度 不高于11个字
 */
+ (BOOL)isStringLengthName:(NSString *)name{
    NSUInteger  character = 0;
    for(int i=0; i< [name length];i++){
        int a = [name characterAtIndex:i];
        if( a >= 0x4e00 && a <= 0x9fff){ //判断是否为中文
            character +=2;
        }else{
            character +=1;
        }
    }
    if (character <=22) {
        return YES;
    }else{
        return NO;
    }
    
}

/**
 身份证验证
 
 */
+ (BOOL)isLenghtCard:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    int length = 0;
    
    
    
    if (!value) {
        
        return NO;
        
    }
    
    else {
        
        length = (int)value.length;
        
        
        
        if (length !=15 && length !=18) {
            
            return NO;
            
        }
        
    }
    
    // 省份代码
    
    NSArray *areasArray =@[@"11",@"12",@"13",@"14",@"15",@"21",@"22",@"23",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"41",@"42",@"43",@"44",@"45",@"46",@"50",@"51",@"52",@"53",@"54",@"61",@"62",@"63",@"64",@"65",@"71",@"81",@"82",@"91"];
    
    
    
    NSString *valueStart2 = [value substringToIndex:2];
    
    
    
    BOOL areaFlag =NO;
    
    
    
    for (NSString *areaCode in areasArray) {
        
        
        
        if ([areaCode isEqualToString:valueStart2]) {
            
            areaFlag =YES;
            
            break;
            
        }
        
    }
    
    
    
    if (!areaFlag) {
        
        return NO;
        
    }
    
    
    
    NSRegularExpression *regularExpression;
    
    NSUInteger numberofMatch;
    
    int year =0;
    
    switch (length) {
            
        case 15:{
            
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                
                return YES;
                
            }else {
                
                return NO;
                
            }
            
        }
            
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }else {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                     
                                                                       options:NSRegularExpressionCaseInsensitive
                                     
                                                                         error:nil];//测试出生日期的合法性
                
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                             
                                                               options:NSMatchingReportProgress
                             
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                
                
                
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                
                
                int Y = S %11;
                
                
                
                NSString *M =@"F";
                
                
                
                NSString *JYM =@"10X98765432";
                
                
                
                M = [JYM substringWithRange:NSMakeRange(Y,1)];//判断校验位
                
                
                
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    
                    return YES;// 检测ID的校验位
                    
                }else {
                    
                    return NO;
                    
                }
                
            }else {
                
                
                
                return NO;
                
            }
            
        default:
            
            return NO;
            
    }
}

/**
判断是否为银行卡号

 */
+ (BOOL) checkCardNo:(NSString*) cardNo{
    
    int oddsum = 0;    //奇数求和
    
    int evensum = 0;    //偶数求和
    
    int allsum = 0;
    
    int cardNoLength = (int)[cardNo length];
    
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    
    for (int i = cardNoLength -1 ; i>=1;i--) {
        
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        
        int tmpVal = [tmpString intValue];
        
        if (cardNoLength % 2 ==1 ) {
            
            if((i % 2) == 0){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }else{
            
            if((i % 2) == 1){
                
                tmpVal *= 2;
                
                if(tmpVal>=10)
                    
                    tmpVal -= 9;
                
                evensum += tmpVal;
                
            }else{
                
                oddsum += tmpVal;
                
            }
            
        }
        
    }
    
    
    
    allsum = oddsum + evensum;
    
    allsum += lastNum;
    
    if((allsum % 10) ==0)
        
        return YES;
    
    else
        
        return NO;
    
}
//是否是纯数字

/**
 是否是纯数字

 */
+ (BOOL)deptNumInputShouldNumber:(NSString *)text{
    
    NSString *regex =@"[0-9]*";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if (![pred evaluateWithObject:text]) {

        return YES;
    }
    //全数字返回NO
    return NO;
}

/**
 自定义进度条
 */
+ (ZHProgressView*)shareZHProgress{
    static ZHProgressView *zhprogress = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        zhprogress = [[ZHProgressView alloc] initWithFrame:CGRectZero];

    });
    return zhprogress;
    
}

/**
 数据库单利
 
 */
+ (FMDatabase*)shareFMDatabase{
    
    static FMDatabase *collectBase = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        //创建一文件
        collectBase = [[FMDatabase alloc] initWithPath:[NSString stringWithFormat:@"%@/Documents/collectNews.db",NSHomeDirectory()]];
        if ([collectBase open]) {
            //需要创建表格  创建表格的语句    create table 表名(字段名,字段名…);
            BOOL isSucceed=[collectBase executeUpdate:@"create table collectBase (content,extra,title,time,money,userId)"];
            
            if(isSucceed){
                NSLog(@"数据库创建成功");
                
            }else{
                NSLog(@"数据库创建失败");
            }
        }else{
            NSLog(@"沙盒打开失败");
        }
        //需要查看数据库的东西时 ，可以打开查看沙盒路径
    });

    return collectBase;
}
/**
 把图片压缩到 1兆以内

 */
+(NSData *)dealBigImage:(UIImage *)image{
    //循环语句压缩size
    int i = 1;
    while (i < 200) {
        //KSLog(@"我现在第%d次循环压缩",i);
        NSData *data = UIImageJPEGRepresentation(image, 1-0.05*i);
        //KSLog(@"压缩质量后所占的大小=%lu",data.length/1024);
        NSInteger size = data.length/1024;
        
        if(size<600) {
            return data;
            
            break;
        }else {
            i++;
        }
    }
    return nil;
}
/**
 纯中文正则判断
 */
+ (BOOL)isSocialCredit18Number:(NSString *)socialCreditNum {
    if(socialCreditNum.length != 18){
        return NO;
    }
    NSString *scN = @"^([0-9ABCDEFGHJKLMNPQRTUWXY]{2})([0-9]{6})([0-9ABCDEFGHJKLMNPQRTUWXY]{9})([0-9Y])$";
    NSPredicate *regextestSCNum = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", scN];
    if (![regextestSCNum evaluateWithObject:socialCreditNum]) {
        return NO;
    }

    NSArray *ws = @[@1,@3,@9,@27,@19,@26,@16,@17,@20,@29,@25,@13,@8,@24,@10,@30,@28];
    NSDictionary *zmDic = @{@"A":@10,@"B":@11,@"C":@12,@"D":@13,@"E":@14,@"F":@15,@"G":@16,@"H":@17,@"J":@18,@"K":@19,@"L":@20,@"M":@21,@"N":@22,@"P":@23,@"Q":@24,@"R":@25,@"T":@26,@"U":@27,@"W":@28,@"X":@29,@"Y":@30};
    NSMutableArray *codeArr = [NSMutableArray array];
    NSMutableArray *codeArr2 = [NSMutableArray array];
    
    codeArr[0] = [socialCreditNum substringWithRange:NSMakeRange(0,socialCreditNum.length-1)];
    codeArr[1] = [socialCreditNum substringWithRange:NSMakeRange(socialCreditNum.length-1,1)];
    
    int sum = 0;
    
    for (int i = 0; i < [codeArr[0] length]; i++) {
        
        [codeArr2 addObject:[codeArr[0] substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSScanner* scan;
    int val;
    for (int j = 0; j < codeArr2.count; j++) {
        scan = [NSScanner scannerWithString:codeArr2[j]];
        if (![scan scanInt:&val] && ![scan isAtEnd]) {
            codeArr2[j] = zmDic[codeArr2[j]];
        }
    }
    
    
    for (int x = 0; x < codeArr2.count; x++) {
        sum += [ws[x] intValue]*[codeArr2[x] intValue];
    }
    
    
    int c18 = 31 - (sum % 31);
    
    for (NSString *key in zmDic.allKeys) {
        
        if (zmDic[key]==[NSNumber numberWithInt:c18]) {
            if (![codeArr[1] isEqualToString:key]) {
                return NO;
            }
        }
    }
    
    return YES;
}
@end
