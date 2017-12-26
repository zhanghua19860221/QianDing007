//
//  GetPassWord.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "GetPassWord.h"
@interface GetPassWord ()

@end

@implementation GetPassWord

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavgation];
    [self createInfoText];
    // Do any additional setup after loading the view.
}

/**
 创建信息输入框
 */
- (void)createInfoText{
    
    _telePhone = [[CustomTextView alloc] initView:@"请输入手机号"];
    [self.view addSubview:_telePhone];
    [_telePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    _getCode = [[CustomGetCode alloc] initView:@"验证码"];
    [self.view addSubview:_getCode];
    [_getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telePhone.mas_bottom);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    _setNewPassWord = [[CustomTextView alloc] initView:@"设置新密码"];
    [self.view addSubview:_setNewPassWord];
    [_setNewPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_getCode.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    _confirmPassWord = [[CustomTextView alloc] initView:@"确认新密码"];
    [self.view addSubview:_confirmPassWord];
    [_confirmPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setNewPassWord.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor redColor];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 22/SCALE_X;
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPassWord.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
    }];

}
/**
 创建导航栏
 */
- (void)createNavgation{
        self.navigationItem.title = @"找回密码";
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 20,20);
        [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    
}
/**
 导航栏返回按钮
 */
- (void)leftBackClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
