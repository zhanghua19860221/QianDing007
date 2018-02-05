//
//  QDPickerModel.h
//  QianDing007
//
//  Created by 张华 on 2018/2/5.
//  Copyright © 2018年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDPickerModel : NSObject
@property (strong , nonatomic)NSString *summ;//每日限额
@property (strong , nonatomic)NSString *name;//银行名称
@property (strong , nonatomic)NSString *logo;//图标地址
@property (strong , nonatomic)NSString *numb;//银行代码

@end
