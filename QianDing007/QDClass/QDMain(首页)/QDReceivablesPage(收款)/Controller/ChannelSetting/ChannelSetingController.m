//
//  ChannelSetingController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "ChannelSetingController.h"

@interface ChannelSetingController ()

@end

@implementation ChannelSetingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createSubView];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
}
- (void)createSubView{
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView setImage:[UIImage imageNamed:@"组9"]];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(self.view).offset(15);
        make.height.width.mas_equalTo(40);
        
    }];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"联通沃支付";
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    [label setTextColor:COLORFromRGB(0x333333)];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64+50/SCALE_Y);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(150);

    }];
    UILabel *labelOne = [[UILabel alloc] init];
    labelOne.text = @"实时到账，低费率";
    labelOne.textAlignment = NSTextAlignmentLeft;
    labelOne.font = [UIFont systemFontOfSize:14];
    [labelOne setTextColor:COLORFromRGB(0x999999)];
    [self.view addSubview:labelOne];
    [labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(10);
        make.left.equalTo(imageView.mas_right).offset(10);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(150);
        
    }];
    
    UIImageView *imageViewOne = [[UIImageView alloc] init];
    [self.view addSubview:imageViewOne];
    [imageViewOne setImage:[UIImage imageNamed:@"选择"]];
    [imageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageView.mas_centerY);
        make.right.equalTo(self.view).offset(-25);
        make.height.width.mas_equalTo(22);
        
    }];
    
    UIView *viewTwo = [[UIView alloc] init];
    [self.view addSubview:viewTwo];
    [viewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(130);

    }];
    
    UIImageView *imageViewTwo = [[UIImageView alloc] init];
    [viewTwo addSubview:imageViewTwo];
    [imageViewTwo setImage:[UIImage imageNamed:@"暂无"]];
    [imageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTwo);
        make.left.equalTo(viewTwo);
        make.height.width.mas_equalTo(22);
        
    }];
    
    UILabel *labelTwo = [[UILabel alloc] init];
    labelTwo.text = @"暂无更多通道";
    labelTwo.textAlignment = NSTextAlignmentLeft;
    labelTwo.font = [UIFont systemFontOfSize:16];
    [labelTwo setTextColor:COLORFromRGB(0xd1d1d1)];
    [viewTwo addSubview:labelTwo];
    [labelTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTwo);
        make.left.equalTo(imageViewTwo.mas_right);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(108);
        
    }];
    

}
- (void)createNavgation{
    
    self.navigationItem.title = @"通道设置";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)leftBackClick{
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
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
