//
//  ReceivablesPage.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ReceivablesPage.h"

@interface ReceivablesPage (){

    UIView *mebInfoView;//会员信息展示视图
    UIView *profitView;//商家收益视图
    UIView *myView;//我的等级视图
    UIView *codeView;//二维码扫描视图
    
}

@end

@implementation ReceivablesPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createBasicView];
}

/**
 创建四大基础视图
 */
- (void)createBasicView{
    
    mebInfoView = [[UIView alloc] init];
    [self.view addSubview:mebInfoView];
    [mebInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
    }];
    
    profitView = [[UIView alloc] init];
    [self.view addSubview:profitView];
    [profitView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    myView = [[UIView alloc] init];
    [self.view addSubview:myView];
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    codeView = [[UIView alloc] init];
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
