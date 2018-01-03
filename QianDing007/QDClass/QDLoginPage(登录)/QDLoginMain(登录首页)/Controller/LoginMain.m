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

    UIImageView *lg_logoImageView;//logo图标
    customTextFieldView *lg_telePhoneView;//账号
    customTextFieldView *lg_passWordView;//密码
    UIButton *lg_loginBtn;//登录按钮
    UIButton *lg_getPassWordBtn;//找回密码
    UIButton *lg_registerBtn;//注册
    
}
@end

@implementation LoginMain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self lgCreateLogoView];
    [self lgCreateLoginTextView];
    [self lgCreateLoginBtn];
    [self lgCreateGetPassWordBtn];
    
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
- (void)lgCreateLogoView{
    
    
    lg_logoImageView = [[UIImageView alloc] init];
    lg_logoImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lg_logoImageView];
    [lg_logoImageView setImage:[UIImage imageNamed:@"LOGO"]];
    [lg_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view).offset(40/SCALE_Y);
        make.height.mas_equalTo(170/SCALE_Y);
        make.width.mas_equalTo(125/SCALE_X);
        
    }];
}

/**
 创建帐号密码输入时图
 */
- (void)lgCreateLoginTextView{
    

    lg_telePhoneView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"手机未选中"] selectImage:[UIImage imageNamed:@"手机选中"] defaultText:@"输入登录手机号"];
    [self.view addSubview:lg_telePhoneView];
    [lg_telePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lg_logoImageView.mas_bottom).offset(40/SCALE_Y);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    lg_passWordView = [[customTextFieldView alloc] initView:[UIImage imageNamed:@"密码未选中"] selectImage:[UIImage imageNamed:@"密码选中"] defaultText:@"密码为6到18位数字、字母组合"];
    [self.view addSubview:lg_passWordView];
    [lg_passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lg_telePhoneView.mas_bottom);
        make.left.right.height.mas_equalTo(lg_telePhoneView);
    }];
    
}
/**
 创建登录按钮
 */
- (void)lgCreateLoginBtn{
    
    lg_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [lg_loginBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    lg_loginBtn.backgroundColor = COLORFromRGB(0xe10000);
    [lg_loginBtn addTarget:self action:@selector(lgClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    lg_loginBtn.layer.cornerRadius = 20;
    lg_loginBtn.layer.masksToBounds = YES;
    [self.view addSubview:lg_loginBtn];
    [lg_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lg_passWordView.mas_bottom).offset(50);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(@44);
    }];
}

/**
 
 登录按钮点击事件
 */
- (void)lgClickLoginBtn:(UIButton*)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
    
    BOOL isPhone = [shareDelegate isChinaMobile:lg_telePhoneView.textFile.text];
    if (!isPhone) {
        [self lgShowAlert:@"请输入正确的手机号码。"];
        return;
        
    }
    BOOL isoK = [shareDelegate judgePassWordLegal:lg_passWordView.textFile.text];
    if (!isoK) {
        [self lgShowAlert:@"密码为6到18位数字、字母组合"];
        return;
        
    }

    NSString * rsPassWord_md5 = [MyMD5 md5:lg_passWordView.textFile.text];
    NSDictionary *lgDic =@{@"phone":lg_telePhoneView.textFile.text,
                           @"password":rsPassWord_md5,

                           };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:LOGIN_URL parameters:lgDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[shareDelegate logDic:responseObject]);
        
        NSString *loginSession = [responseObject objectForKey:@"auth_session"];
        [[shareDelegate shareNSUserDefaults] setObject:loginSession forKey:@"auth_session"];
        
        RootViewController *home = [[RootViewController alloc] init];
        [self.navigationController pushViewController:home animated:NO];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];

}
- (void)lgCreateGetPassWordBtn{
    
    lg_getPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_getPassWordBtn setTitle:@"找回密码？" forState:UIControlStateNormal];
    [lg_getPassWordBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    [self.view addSubview:lg_getPassWordBtn];
    [lg_getPassWordBtn addTarget:self action:@selector(getPassWord) forControlEvents:UIControlEventTouchUpInside];
    [lg_getPassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(lg_loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(120);
        
        
    }];
    
    lg_registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lg_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [lg_registerBtn setTitleColor:COLORFromRGB(0xe10000) forState:UIControlStateNormal];
    [self.view addSubview:lg_registerBtn];
    [lg_registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    [lg_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.top.mas_equalTo(lg_loginBtn.mas_bottom).offset(10);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(60);
        
    }];
    
}

/**
 push 找回密码页面
 */
-(void)getPassWord{
    
    GetPassWord *vc = [[GetPassWord alloc] init];
    [self.navigationController pushViewController:vc animated:YES];


}
/**
 push 注册页面
 */
- (void)toRegister{

    RegisterController *vc = [[RegisterController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
/**
 警示 弹出框
 */
- (void)lgShowAlert:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              NSLog(@"action = %@", action);
                                                          }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {
                                                             //响应事件
                                                             NSLog(@"action = %@", action);
                                                         }];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
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
