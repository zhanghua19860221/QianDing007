//
//  ChangePassWordController.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"
@interface ChangePassWordController : UIViewController
@property (strong ,nonatomic) CustomTextView *oldPassWord;
@property (strong ,nonatomic) CustomTextView *setNewPassWord;
@property (strong ,nonatomic) CustomTextView *confirmPassWord;
@end
