//
//  SecuritySetController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "SecuritySetController.h"
#import "ChangeTeleController.h"
#import "ChangePassWordController.h"
#import "LoginMain.h"
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
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
        make.height.mas_equalTo(0.5);
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
    [exitlogonBtn addTarget:self action:@selector(exitLogonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

    ChangeTeleController *teleVC = [[ChangeTeleController alloc] init];
    
    [self.navigationController pushViewController:teleVC animated:YES];
}
/**
 更改密码
 
 */
- (void)changePassWord{

    ChangePassWordController *passVC = [[ChangePassWordController alloc] init];
    [self.navigationController pushViewController:passVC animated:YES];

    
}

/**
 
 退出登录按钮点击事件
 */
-(void)exitLogonBtnClick:(UIButton*)btn{
    
    //清空本地数据
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    //退出融云登陆
    [[RCIM sharedRCIM] disconnect];
    
    LoginMain * loginVC = [[LoginMain alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"安全设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    CUSTOMBACKCONCTORLLER(leftBackClick,self,self.view,@"返回箭头红色",20,20)
 
}
- (void)leftBackClick{
    //修改状态栏颜色 为白色
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

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
