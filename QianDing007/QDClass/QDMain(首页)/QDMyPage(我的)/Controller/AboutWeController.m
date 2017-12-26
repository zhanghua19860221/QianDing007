//
//  AboutWeController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "AboutWeController.h"

@interface AboutWeController (){
    UIImageView *logoImageView;//logo视图

}

@end

@implementation AboutWeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createMainTextView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);
    

}
- (void)createMainTextView{
    logoImageView = [[UIImageView alloc] init];
    [logoImageView setImage:[UIImage imageNamed:@"组2"]];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(SC_HEIGHT-64);
        make.width.mas_equalTo(SC_WIDTH);
        
    }];

    
}
/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"关于我们";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标"] forState:UIControlStateNormal];
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
