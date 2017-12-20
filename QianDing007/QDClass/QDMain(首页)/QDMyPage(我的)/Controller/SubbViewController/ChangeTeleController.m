//
//  ChangeTeleController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChangeTeleController.h"

@interface ChangeTeleController ()

@end

@implementation ChangeTeleController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubview];
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)createSubview{
    
    _oldTelePhone = [[CustomTextView alloc] initView:@"验证旧手机号"];
    [self.view addSubview:_oldTelePhone];
    
    _getCode = [[CustomGetCode alloc] initView:@"验证码"];
    [self.view addSubview:_getCode];
    
    
    [_oldTelePhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    
    [_getCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_oldTelePhone.mas_bottom);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
    }];
    

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    nextBtn.backgroundColor = COLORFromRGB(0xf9cccc);
    [nextBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    nextBtn.layer.masksToBounds = YES ;
    nextBtn.layer.cornerRadius = 25;
    [self.view addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(clickInfo:) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_getCode.mas_bottom).offset(50/SCALE_Y);
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
    self.navigationItem.title = @"更换手机号";
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
