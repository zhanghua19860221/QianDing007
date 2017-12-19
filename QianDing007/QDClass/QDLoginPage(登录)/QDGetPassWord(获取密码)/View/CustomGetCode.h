//
//  CustomGetCode.h
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomGetCode : UIView<UITextFieldDelegate>
@property (strong , nonatomic) UIImageView *lineView;
@property (strong , nonatomic) UITextField *textFile;
@property (strong , nonatomic) NSString *defaultText;
- (id)initView:(NSString*)defaultText;
@end
