//
//  ChangePassWordController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChangePassWordController.h"

@interface ChangePassWordController ()

@end

@implementation ChangePassWordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    [self createNavgation];
    [self createSubview];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)createSubview{

    _oldPassWord = [[CustomTextView alloc] initView:@"输入旧密码"];
    _oldPassWord.textFile.secureTextEntry = YES;
    [self.view addSubview:_oldPassWord];

    _setNewPassWord = [[CustomTextView alloc] initView:@"设置新密码"];
    _setNewPassWord.textFile.secureTextEntry = YES;
    [self.view addSubview:_setNewPassWord];
    
    _confirmPassWord = [[CustomTextView alloc] initView:@"确认新密码"];
    _confirmPassWord.textFile.secureTextEntry = YES;
    [self.view addSubview:_confirmPassWord];

    [_oldPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    [_setNewPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldPassWord.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    [_confirmPassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_setNewPassWord.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.backgroundColor = COLORFromRGB(0xf9cccc);
    [btn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES ;
    btn.layer.cornerRadius = 25;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(clickInfo:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_confirmPassWord.mas_bottom).offset(50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];

}
- (void)clickInfo:(UIButton *)btn{
    btn.backgroundColor = COLORFromRGB(0xe10000);
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"修改密码";
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
    self.view.backgroundColor = [UIColor orangeColor];

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
