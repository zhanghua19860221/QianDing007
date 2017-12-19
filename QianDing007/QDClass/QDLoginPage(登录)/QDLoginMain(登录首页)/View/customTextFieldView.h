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
@property (strong , nonatomic) UIImageView *lineView;
@property (strong , nonatomic) UITextField *textFile;
@property (strong , nonatomic) NSString *defaultText;
@property (strong , nonatomic) UIImage *defaultImage;
@property (strong , nonatomic) UIImage *selectImage;


- (id)initView:(UIImage*)defaultImage selectImage:(UIImage*)selectImage defaultText:(NSString*)defaultText;
@end
