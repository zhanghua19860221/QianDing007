//
//  MoreOrderController.m
//  QianDing007
//
//  Created by 张华 on 17/12/18.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MoreOrderController.h"
#import "FrontViewController.h"
#import "MiddleViewController.h"
#import "ThirdViewController.h"

@interface MoreOrderController (){

    UIButton *selectedButton;//记录当前tabber选中的按钮
    UIScrollView *scrollView;//滚动界面
    FrontViewController *frontViewVC;//我的界面
    MiddleViewController *middleViewVC;//收款界面
    ThirdViewController *thirdViewVC;//消息界面
    UIView *tabberView;//操作栏视图

}

@end

@implementation MoreOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createTabberView];
    [self createSubViewController];
    [self createScrollerView];
    
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
/**
 创建子控制器
 */
- (void)createSubViewController{
    frontViewVC = [[FrontViewController alloc] init];
    middleViewVC = [[MiddleViewController alloc] init];
    thirdViewVC = [[ThirdViewController alloc] init];
    
    [self addChildViewController:frontViewVC];
    [self addChildViewController:middleViewVC];
    [self addChildViewController:thirdViewVC];
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    scrollView.delegate = self ;
    scrollView.contentSize = CGSizeMake(SC_WIDTH*3.0, SC_HEIGHT);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabberView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
    
    }];
    
    for (int i=0; i<3; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [scrollView addSubview:vc.view];
    }
    
}

/**
 创建顶部tabber视图
 */
- (void)createTabberView{
    
    NSArray *textArray = @[@"处理中",@"已到账",@"退 款"];
    tabberView = [[UIView alloc] init];
    tabberView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabberView];
    [tabberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(44);
        
    }];
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 150+i;
        [button setTitle:textArray[i] forState:UIControlStateNormal];
        button.frame = CGRectMake(i*SC_WIDTH/3.0, 0, SC_WIDTH/3.0,44);
        [tabberView addSubview:button];
        
        if (0==i) {
            
            button.selected=YES;
            selectedButton=button;
        }
        
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (void)selectBtn:(UIButton*)btn{
    
    if (selectedButton!=btn) {
        selectedButton.selected=NO;
        btn.selected=YES;
        selectedButton=btn;
    }
    switch (btn.tag) {
        case 150:
            scrollView.contentOffset = CGPointMake(0, 0);
            
            break;
        case 151:
            scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            
            break;
        case 152:
            scrollView.contentOffset = CGPointMake(SC_WIDTH*2.0, 0);
            
            break;
        default:
            break;
    }

}
/**
 创建导航栏
 */
- (void)createNavgation{

    self.navigationItem.title = @"收款记录";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
- (void)leftBackClick{
    
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma ***********************************************************


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
