//
//  HomeController.m
//  QianDing007
//
//  Created by 张华 on 17/12/13.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "HomeController.h"
#import "ReceivablesPage.h"
#import "MyPage.h"
#import "News.h"
@interface HomeController (){

    ReceivablesPage *receivablesVC;//收款界面
    MyPage *myPageVC;//我的界面
    News *newsVC;//消息界面
    UIScrollView *scrollView;//滚动界面
    UIButton *selectedButton;//记录当前tabber选中的按钮
    
}
@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViewController];
    [self createScrollerView];
    [self createTabber];
    self.view.backgroundColor = [UIColor orangeColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
/**
 创建子控制器
 */
- (void)createSubViewController{
    receivablesVC = [[ReceivablesPage alloc] init];
    newsVC = [[News alloc] init];
    myPageVC = [[MyPage alloc] init];

    [self addChildViewController:receivablesVC];
    [self addChildViewController:newsVC];
    [self addChildViewController:myPageVC];
}

/**
 创建tabber按钮
 */
- (void)createTabber{
    
    NSArray *tabDafImageArray = @[@"操作栏收款未选中",@"操作栏消息未选中",@"操作栏我的未选中"];
    NSArray *tabSelImageArray = @[@"操作栏收款选中",@"操作栏消息选中",@"操作栏我的选中"];
    
    UIView *tabberView = [[UIView alloc] init];
    tabberView.backgroundColor =COLORFromRGB(0xf9f9f9);
    tabberView.layer.borderWidth = 1;
    tabberView.layer.borderColor = [[UIColor grayColor] CGColor];
    tabberView.frame = CGRectMake(0, SC_HEIGHT-44, SC_WIDTH, 44);
    [self.view addSubview:tabberView];

    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 100+i;
        button.frame = CGRectMake(i*SC_WIDTH/3.0, 0, SC_WIDTH/3.0, 44);
        [tabberView addSubview:button];
        
        if (0==i) {
            
            button.selected=YES;
            selectedButton=button;
        }
        [button setImage:[UIImage imageNamed:tabDafImageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:tabSelImageArray[i]] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

/**
 Tabber按钮点击事件
 */
- (void)selectBtn:(UIButton *)btn{
    
    if (selectedButton!=btn) {
        selectedButton.selected=NO;
        btn.selected=YES;
        selectedButton=btn;
    }
    switch (btn.tag) {
        case 100:
            scrollView.contentOffset = CGPointMake(0, 0);
            [self setStatusBarBackgroundColor:[UIColor whiteColor]];
            break;
        case 101:
            scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            [self setStatusBarBackgroundColor:[UIColor redColor]];
            break;
        case 102:
            scrollView.contentOffset = CGPointMake(SC_WIDTH*2.0, 0);
            [self setStatusBarBackgroundColor:[UIColor redColor]];
            break;
        default:
            break;
    }
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
//    scrollView.userInteractionEnabled = NO;
    scrollView.contentSize = CGSizeMake(SC_WIDTH*3.0, SC_HEIGHT);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(self.view);
    }];
    
    for (int i=0; i<3; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [scrollView addSubview:vc.view];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

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
