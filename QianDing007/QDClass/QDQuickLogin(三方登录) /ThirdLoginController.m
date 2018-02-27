//
//  ThirdLoginController.m
//  QianDing007
//
//  Created by 张华 on 2018/2/24.
//  Copyright © 2018年 张华. All rights reserved.
//

#import "ThirdLoginController.h"

@interface ThirdLoginController (){
    
    UITextField *tl_teleField;     //手机号码
    UITextField *tl_getCodeField;  //邀请码
    UIButton    *tl_submitBtn;     //提交按钮
   
    
}

@end

@implementation ThirdLoginController

- (void)viewDidLoad {
    [super   viewDidLoad];
    [self  createSubview];
    [self createNavgation];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);

}
/**
 创建子控件
 */
- (void)createSubview{
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(164/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    tl_teleField = [[UITextField alloc] init];
    tl_teleField.placeholder = @"请输入手机号";
    tl_teleField.delegate = self;
    [tl_teleField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    tl_teleField.font = [UIFont systemFontOfSize:18];
    [tl_teleField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:tl_teleField];
    [tl_teleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(line.mas_bottom);
        make.left.equalTo(line).offset(10);
        make.right.equalTo(line).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    
    UIImageView *lineOne = [[UIImageView alloc] init];
    lineOne.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lineOne];
    [lineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(1);
        
    }];
    
    tl_getCodeField = [[UITextField alloc] init];
    tl_getCodeField.placeholder = @"请输入验证码";
    tl_getCodeField.delegate = self;
    tl_getCodeField.font = [UIFont systemFontOfSize:18];
    [tl_getCodeField setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:tl_getCodeField];
    [tl_getCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.left.equalTo(lineOne).offset(10);
        make.right.equalTo(lineOne).offset(-10);
        make.height.mas_equalTo(50/SCALE_Y);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = COLORFromRGB(0xe10000);
    [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(tlGetCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = 3;
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineOne.mas_bottom);
        make.right.equalTo(lineOne);
        make.height.mas_equalTo(40/SCALE_Y);
        make.width.mas_equalTo(140/SCALE_X);
        
        
    }];
    
    tl_submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tl_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [tl_submitBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    tl_submitBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    tl_submitBtn.layer.masksToBounds = YES;
    tl_submitBtn.layer.cornerRadius = 22/SCALE_Y;
    tl_submitBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [tl_submitBtn addTarget:self action:@selector(tlSubmitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tl_submitBtn];
    [tl_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineOne.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44/SCALE_Y);
        
    }];
    
}
/**
 确定按钮点击事件
 
 */
-(void)tlSubmitBtnClick:(UIButton*)btn{
    
    
}
/**
 获取验证码
 
 */
- (void)tlGetCodeBtnClick:(UIButton*)btn{
    
    BOOL isPhone = [shareDelegate isChinaMobile:tl_teleField.text];
    if (!isPhone) {
        [self tlShowAlertFail:@"请输入正确的手机号码。"];
        return;
        
    }
    [btn startCountDownTime:60 withCountDownBlock:^{
        NSDictionary *dic = @{@"phone":tl_teleField.text};
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        
        [manager POST:SMS_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            
        }];
    }];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"绑定手机号";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 警示 提示框
 */
- (void)tlShowAlertFail:(NSString *)warning{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:warning
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //响应事件
                                                              
                                                          }];
    
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
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
