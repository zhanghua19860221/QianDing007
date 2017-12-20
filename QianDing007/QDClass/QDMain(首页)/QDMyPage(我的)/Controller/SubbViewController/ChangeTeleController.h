//
//  ChangeTeleController.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextView.h"
#import "CustomGetCode.h"
@interface ChangeTeleController : UIViewController
@property (strong ,nonatomic) CustomTextView *oldTelePhone;
@property (strong ,nonatomic) CustomGetCode  *getCode;
@end
