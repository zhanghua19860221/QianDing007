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
#import "RegisterController.h"
#import "RootViewController.h"
@interface LoginMain (){

    UIImageView *logoImageView;//logo图标
    customTextFieldView *telePhoneView;//账号
    customTextFieldView *passWordView;//密码
    UIButton *loginBtn;//登录按钮
    UIButton *getPassWordBtn;//找回密码
    UIButton *registerBtn;//注册
    
}
@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLogoView];
    [self createLoginTextView];
    [self createLoginBtn];
    [self createGetPassWordBtn];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}
/**
 创建logo视图
 */
- (void)createLogoView{
    
    logoImageView = [[UIImageView alloc] init];
    logoImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:logoImageView];
    [logoImageView setImage:[UIImage imageNamed:@"LOGO"]];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(40/SCALE_Y);
        make.height.mas_equalTo(170/SCALE_Y);
        make.width.mas_equalTo(125/SCALE_X);
        
    }];
}

/**
 创建帐号密码输入时图
 */
- (void)createLoginTextView{
    

    telePhoneView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"手机未选中"] selectImage:[UIImage imageNamed:@"手机选中"] defaultText:@"输入登录手机号"];
    [self.view addSubview:telePhoneView];
    [telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(40/SCALE_Y);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    passWordView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"密码未选中"] selectImage:[UIImage imageNamed:@"密码选中"] defaultText:@"密码为6到18位数字、字母组合"];
    [self.view addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(telePhoneView.mas_bottom).offset(0);
        make.left.right.height.mas_equalTo(telePhoneView);
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
        make.top.mas_equalTo(passWordView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(@44);
    }];
}
- (void)clickLoginBtn{
    
    
    RootViewController *home = [[RootViewController alloc] init];
    [self.navigationController pushViewController:home animated:NO];
}
- (void)createGetPassWordBtn{
    
    getPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getPassWordBtn setTitle:@"找回密码？" forState:UIControlStateNormal];
    [getPassWordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:getPassWordBtn];
    [getPassWordBtn addTarget:self action:@selector(getPassWord) forControlEvents:UIControlEventTouchUpInside];
    [getPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@120);
        
    }];
    
    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:registerBtn];
    [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@60);
        
    }];
}

/**
 PUSH 找回密码页面
 */
-(void)getPassWord{
    
    GetPassWord *vc = [[GetPassWord alloc] init];
    [self.navigationController pushViewController:vc animated:YES];


}

/**
 PUSH 注册页面
 */
- (void)toRegister{

    RegisterController *vc = [[RegisterController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

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
