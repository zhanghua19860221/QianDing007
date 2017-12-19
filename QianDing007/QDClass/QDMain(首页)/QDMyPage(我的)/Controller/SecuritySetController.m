//
//  SecuritySetController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "SecuritySetController.h"

@interface SecuritySetController ()

@end

@implementation SecuritySetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)createSubView{
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(84);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(self.view);
        
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"修改密码";
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(100);
        
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"更多图标"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button addTarget:self action:@selector(changePassWord) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(view).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(30);
        
    }];
    
    UIImageView *lineView = [[UIImageView alloc] init];
    [lineView setImage:[UIImage imageNamed:@"分割线"]];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(1);
        make.left.equalTo(view);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(SC_WIDTH);
    }];
    
    
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(self.view);
        
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"更换手机号";
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2.mas_centerY);
        make.left.equalTo(view2).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(100);
        
    }];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"更多图标"] forState:UIControlStateNormal];
    [view2 addSubview:button2];
    [button2 addTarget:self action:@selector(changeTelephone) forControlEvents:UIControlEventTouchUpInside];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2.mas_centerY);
        make.right.equalTo(view2).offset(-15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(30);
        
    }];
    
    
    UIButton *exitlogonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [exitlogonBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    exitlogonBtn.backgroundColor = COLORFromRGB(0xe10000);
    [exitlogonBtn setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.view addSubview:exitlogonBtn];
    [exitlogonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-80/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(SC_WIDTH);
        
    }];
    
}

/**
 更改电话号码
 */
- (void)changeTelephone{


}
/**
 更改密码
 */
- (void)changePassWord{


    
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"安全设置";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
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
