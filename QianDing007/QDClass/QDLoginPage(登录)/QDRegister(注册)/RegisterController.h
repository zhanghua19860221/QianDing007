//
//  RegisterController.h
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"
#import "CustomGetCode.h"

@interface RegisterController : UIViewController
@property (strong ,nonatomic) CustomTextView *requestView;
@property (strong ,nonatomic) CustomTextView *telePhoneView;
@property (strong ,nonatomic) CustomTextView *setPassWordView;
@property (strong ,nonatomic) CustomTextView *confirmPassWordView;
@property (strong ,nonatomic) CustomGetCode  *getCodeView;
@property (strong ,nonatomic) UILabel *promptLabel;

@end
