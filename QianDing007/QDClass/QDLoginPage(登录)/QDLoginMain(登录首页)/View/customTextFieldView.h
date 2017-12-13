//
//  customTextFieldView.h
//  QianDing007
//
//  Created by 张华 on 17/12/11.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTextFieldView : UIView<UITextFieldDelegate>
@property (strong , nonatomic) UIImageView *iconView;
@property (strong , nonatomic) UITextField *textFile;
@property (strong , nonatomic) UIImageView *lineView;
@property (strong , nonatomic) UIColor *defaultColor;
@property (strong , nonatomic) UIColor *selectColor;
- (id)initView:(UIImage*)defaultImage selectImage:(UIImage*)selectImage defaultColor:(UIColor*)defaultColor selectColor:(UIColor*)selectColor;
@end
