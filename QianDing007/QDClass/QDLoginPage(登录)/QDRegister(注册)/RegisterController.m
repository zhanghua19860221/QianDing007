//
//  RegisterController.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "RegisterController.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createInfoText];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
/**
 创建信息输入框
 */
- (void)createInfoText{
    
    _requestView = [[CustomTextView alloc] initView:@"请输入邀请码"];
    [self.view addSubview:_requestView];
    [_requestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_promptLabel.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    _telePhoneView = [[CustomTextView alloc] initView:@"请输入手机号"];
    [self.view addSubview:_telePhoneView];
    [_telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_requestView.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    _setPassWordView = [[CustomTextView alloc] initView:@"请设置6至18位数字、字母组合密码"];
    [self.view addSubview:_setPassWordView];
    [_setPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_telePhoneView.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    _confirmPassWordView = [[CustomTextView alloc] initView:@"请确认密码"];
    [self.view addSubview:_confirmPassWordView];
    [_confirmPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setPassWordView.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    _getCodeView = [[CustomGetCode alloc] initView:@"验证码"];
    [self.view addSubview:_getCodeView];
    [_getCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPassWordView.mas_bottom);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
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
        make.top.equalTo(_getCodeView.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"注册";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    

    
    _promptLabel = [[UILabel alloc] init];
    _promptLabel.text = @"提示：商户邀请码为手机号，代理商邀请码在手机号码前加0。";
    _promptLabel.font = [UIFont systemFontOfSize:14];
    //文字居中显示
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    _promptLabel.lineBreakMode =NSLineBreakByWordWrapping;
    [_promptLabel setNumberOfLines:0];
    
    [_promptLabel setTextColor:COLORFromRGB(0xe10000)];
    [self.view addSubview:_promptLabel];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view).offset(40/SCALE_X);
        make.right.equalTo(self.view).offset(-40/SCALE_X);
        make.height.mas_offset(100/SCALE_Y);
    }];

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
