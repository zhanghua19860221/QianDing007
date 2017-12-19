//
//  GetPassWord.h
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"
#import "CustomGetCode.h"
@interface GetPassWord : UIViewController
@property (strong ,nonatomic) CustomTextView *telePhone;
@property (strong ,nonatomic) CustomTextView *setNewPassWord;
@property (strong ,nonatomic) CustomTextView *confirmPassWord;
@property (strong ,nonatomic) CustomGetCode  *getCode;
@end
