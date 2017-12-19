//
//  CustomLabelView.h
//  QianDing007
//
//  Created by 张华 on 17/12/16.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabelView : UIView
@property (copy , nonatomic) NSString *firstImage;
@property (copy , nonatomic) NSString *secondImage;
@property (copy , nonatomic) NSString *firstStr;
@property (copy , nonatomic) NSString *secondStr;

@property(strong , nonatomic) UIImageView *iconView;
@property(strong , nonatomic) UILabel *firstLabel;
@property(strong , nonatomic) UILabel *secondLabel;
@property(strong , nonatomic) UIButton *directionBtn;

-(id)initWithFrame:(NSString *)firstImage firstLabel:(NSString*)firstStr secondLabel:(NSString*)secondStr secondImage:(NSString*)secondImage;

@end
