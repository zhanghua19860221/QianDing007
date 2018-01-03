//
//  NewsSetController.m
//  QianDing007
//
//  Created by 张华 on 17/12/21.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "NewsSetController.h"

@interface NewsSetController ()

@end

@implementation NewsSetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

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
    label.text = @"屏蔽消息";
    [view addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(100);
    
        
    }];
    
    UISwitch *switchView = [[UISwitch alloc] init];
    switchView.on = YES;//设置初始为ON的一边
    switchView.onTintColor = COLORFromRGB(0xe10000);
    [switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   // 开关事件切换通知
    [view addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.right.equalTo(self.view).offset(-30);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);

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
    label2.text = @"清空历史消息";
    [view2 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(view2.mas_centerY);
        make.left.equalTo(view2).offset(15);
        make.height.mas_equalTo(50/SCALE_Y);
        make.width.mas_equalTo(200);
        
    }];
    

}

/**
 创建导航栏
 */
- (void)createNavgation{
    self.navigationItem.title = @"消息设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];

    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"开");
    }else {
        NSLog(@"关");
    }
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
