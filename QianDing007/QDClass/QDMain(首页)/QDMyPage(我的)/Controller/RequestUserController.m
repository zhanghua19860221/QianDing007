//
//  RequestUserController.m
//  QianDing007
//
//  Created by 张华 on 17/12/23.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "RequestUserController.h"

@interface RequestUserController (){

    UIView *firstView;
    UIView *secondView;
    UIView *thirdView;
}
@end

@implementation RequestUserController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createFirstView];
    [self createSecondView];
    [self createThirdView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)createFirstView{
    
    firstView = [[UIView alloc] init];
    firstView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(120/SCALE_Y);
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"代理商邀请码";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [firstView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(30/SCALE_Y);
        make.left.equalTo(firstView).offset(15);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(16);
    
    }];
    
    UILabel *teleLabel = [[UILabel alloc] init];
    teleLabel.text = @"13466358453";
    teleLabel.textAlignment = NSTextAlignmentCenter;
    [firstView addSubview:teleLabel];
    [teleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(firstView).offset(85/SCALE_X);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(23);
        
    }];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    copyBtn.backgroundColor = COLORFromRGB(0xbfbfbf);
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [copyBtn setTitleColor:COLORFromRGB(0xf5f5f5) forState:UIControlStateNormal];
    [firstView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(teleLabel.mas_centerY);
        make.left.equalTo(teleLabel.mas_right).offset(10);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(25);
        
    }];
    
}
- (void)createSecondView{
    secondView = [[UIView alloc] init];
    secondView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(268/SCALE_Y);
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.text = @"扫一扫，邀请商户";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [secondView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView).offset(30/SCALE_Y);
        make.left.equalTo(secondView).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
        
    }];
    
    UIImageView *codeView = [[UIImageView alloc] init];
    [codeView setImage:[UIImage imageNamed:@"邀请商家"]];
    [secondView addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeLabel.mas_bottom).offset(20/SCALE_Y);
        make.centerX.equalTo(secondView.mas_centerX);
        make.width.mas_equalTo(172/SCALE_X);
        make.height.mas_equalTo(172/SCALE_X);
        
    }];
    
}

- (void)createThirdView{
    thirdView = [[UIView alloc] init];
    thirdView.backgroundColor = COLORFromRGB(0xffffff);
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        
    }];
    UILabel *sendLabel = [[UILabel alloc] init];
    sendLabel.text = @"发送消息邀请注册";
    sendLabel.textAlignment = NSTextAlignmentCenter;
    [thirdView addSubview:sendLabel];
    [sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView).offset(30/SCALE_Y);
        make.left.equalTo(thirdView).offset(15);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(16);
        
    }];
    
    
    UIView *iconBJView = [[UIView alloc] init];
    iconBJView.backgroundColor = COLORFromRGB(0xffffff);
    [thirdView addSubview:iconBJView];
    [iconBJView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(sendLabel.mas_bottom).offset(20/SCALE_Y);
        make.left.equalTo(thirdView).offset(52.5/SCALE_X);
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(60);
        
    }];
    
    NSArray *loginViewArray = @[@"微信@2x",@"QQ",@"通讯录"];
    UIButton *tempBtn = nil;
    for (int i = 0; i<3 ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:loginViewArray[i]] forState:UIControlStateNormal];
        button.tag = 260+i;
        [iconBJView addSubview:button];
        [button addTarget:self action:@selector(requestViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBJView);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right).offset(45);
            }else{
                
                make.left.equalTo(iconBJView);
            }
            make.width.height.mas_equalTo(60);
            
        }];
        tempBtn = button;
    }
    
}
/**
 邀请对应类型按钮点击事件
 */
- (void)requestViewClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 260:
            
            break;
        case 261:
            
            break;
        case 262:
            
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setStatusBarBackgroundColor:COLORFromRGB(0xffffff)];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);
    
    
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"邀请商家";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
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
