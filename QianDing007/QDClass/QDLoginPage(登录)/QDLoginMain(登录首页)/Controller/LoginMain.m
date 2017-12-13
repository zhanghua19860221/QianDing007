//
//  LoginMain.m
//  QianDing007
//
//  Created by 张华 on 17/12/11.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "LoginMain.h"
#import "customTextFieldView.h"
#import "GetPassWord.h"
#import "HomeController.h"
@interface LoginMain (){

    UIImageView *logoImageView;//logo图标
    customTextFieldView *telePhoneView;//账号
    customTextFieldView *passWordView;//密码
    UIButton *loginBtn;//登录按钮
    UIButton *getPassWordBtn;//找回密码
    UIButton *registerBtn;//注册
    UILabel  *loginLabel;//第三方登录文本
    UIButton *qqLoginBtn;//QQ登录
    UIButton *wechatLoginBtn;//微信登录
    
}
@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLogoView];
    [self createLoginTextView];
    [self createLoginBtn];
    [self createGetPassWordBtn];
    [self createQuickLoginBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/**
 创建logo视图
 */
- (void)createLogoView{
    
    logoImageView = [[UIImageView alloc] init];
    logoImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(60);
        make.height.mas_equalTo(@80);
        make.width.mas_equalTo(@100);
        
    }];
}

/**
 创建帐号密码输入时图
 */
- (void)createLoginTextView{
    

    telePhoneView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"telephone11"] selectImage:[UIImage imageNamed:@"telephone22"] defaultColor:[UIColor grayColor] selectColor:[UIColor redColor]];
    [self.view addSubview:telePhoneView];
    [telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(logoImageView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(@44);
    }];
    
    passWordView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"telephone11"] selectImage:[UIImage imageNamed:@"telephone22"] defaultColor:[UIColor grayColor] selectColor:[UIColor redColor]];
    [self.view addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telePhoneView.mas_bottom).with.offset(20);
        make.left.right.height.equalTo(telePhoneView);
    }];
    
}

/**
 创建登录按钮
 */
- (void)createLoginBtn{
    
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 15;
    loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passWordView.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(@44);
    }];

}
- (void)clickLoginBtn{
    
    HomeController *home = [[HomeController alloc] init];
    [self.navigationController pushViewController:home animated:NO];
    
}
- (void)createGetPassWordBtn{
    
    getPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getPassWordBtn setTitle:@"找回密码？" forState:UIControlStateNormal];
    [getPassWordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:getPassWordBtn];
    [getPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@120);
        
    }];
    
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-20);
        make.top.equalTo(loginBtn.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@60);
        
    }];
    
    loginLabel = [[UILabel alloc] init];
    loginLabel.text = @"第三方登录";
    [loginLabel setTextColor:COLORFromRGB(0x666666)];
    loginLabel.font = [UIFont boldSystemFontOfSize:18];
    loginLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(registerBtn.mas_bottom).with.offset(30);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@120);
    }];
}
- (void)createQuickLoginBtn{
    
    qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqLoginBtn.backgroundColor = [UIColor grayColor];
    qqLoginBtn.layer.cornerRadius = 30;
    qqLoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:qqLoginBtn];
    [qqLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginLabel.mas_bottom).with.offset(40);
        make.left.equalTo(self.view).with.offset(60);
        make.width.mas_equalTo(@60);
        make.height.mas_equalTo(@60);
        
    }];
    wechatLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wechatLoginBtn.backgroundColor = [UIColor grayColor];
    wechatLoginBtn.layer.cornerRadius = 30;
    wechatLoginBtn.layer.masksToBounds = YES;
    [self.view addSubview:wechatLoginBtn];
    
    [wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(qqLoginBtn);
        make.right.equalTo(self.view).with.offset(-60);
    }];

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
