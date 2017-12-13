//
//  customTextFieldView.m
//  QianDing007
//
//  Created by 张华 on 17/12/11.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "customTextFieldView.h"

@implementation customTextFieldView
- (id)initView:(UIImage*)defaultImage selectImage:(UIImage*)selectImage defaultColor:(UIColor*)defaultColor selectColor:(UIColor*)selectColor{
    self = [super init];
    if (self) {
        self.defaultColor = defaultColor;
        self.selectColor  = selectColor;
        [self createSubView:defaultImage selectImage:selectImage ];
    }
    return self;
}
-(void)createSubView:(UIImage*)defaultImage selectImage:(UIImage*)selectImage{
    
    self.iconView = [[UIImageView alloc] init];
    [self.iconView setImage:defaultImage];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(0);
        make.top.equalTo(self).with.offset(0);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(self.mas_height);
    }];
    
    self.textFile = [[UITextField alloc] init];
    [self addSubview:self.textFile];
    self.textFile.delegate = self;
    [self.textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_equalTo(self.mas_height);
    }];
    
    self.lineView = [[UIImageView alloc] init];
    self.lineView.backgroundColor = self.defaultColor;
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(0);
        make.height.mas_equalTo(@1);
    }];
}
/**
  当输入框开始时触发 ( 获得焦点触发)

 */
- (void)textFieldDidBeginEditing:( UITextField*)textField{

    self.lineView.backgroundColor = self.selectColor;
}

/**
 询问输入框是否可以结束编辑 ( 键盘是否可以收回)

 */
- (BOOL)textFieldShouldEndEditing:( UITextField*)textField{

    return YES;
}

/**
 当前输入框结束编辑时触发 (键盘收回之后触发)

 */
- (void)textFieldDidEndEditing:( UITextField *)textField{

    NSLog(@"当前输入框结束编辑时触发");
}
/**
 当输入框文字发生变化时触发 ( 只有通过键盘输入时 , 文字改变 , 触发 )

 */
- (BOOL)textField:( UITextField  *)textField shouldChangeCharactersInRange:(NSRange )range replacementString:( NSString  *)string{
    
    return YES;
}
/**
 控制当前输入框是否能被编辑

 */
- (BOOL)textFieldShouldBeginEditing:( UITextField *)textField{

    return YES;
}

/**
 控制输入框清除按钮是否有效 (yes, 有 ;no, 没有)

 */
- (BOOL)textFieldShouldClear:( UITextField*)textField{

    return YES;
}
/**
返回按钮
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFile resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
