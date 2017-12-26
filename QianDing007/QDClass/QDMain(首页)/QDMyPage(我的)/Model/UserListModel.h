//
//  UserListModel.h
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserListModel : NSObject
@property (strong , nonatomic) NSString *userNameStr;    //商家名称
@property (strong , nonatomic) NSString *teleStr;        //商家电话
@property (strong , nonatomic) NSString *allMoneyStr;    //总收款
@property (strong , nonatomic) NSString *openTimeStr;    //开通时间
@property (strong , nonatomic) NSString *mebIconStr;     //会员头像
@property (strong , nonatomic) NSString *mebLevelStr;    //会员等级

@end
