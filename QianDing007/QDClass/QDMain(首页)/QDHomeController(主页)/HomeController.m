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
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
/**
 创建子控制器
 */
- (void)createSubViewController{
    receivablesVC = [[ReceivablesPage alloc] init];
    myPageVC = [[MyPage alloc] init];
    newsVC = [[News alloc] init];
    
    [self addChildViewController:receivablesVC];
    [self addChildViewController:myPageVC];
    [self addChildViewController:newsVC];
}

/**
 创建tabber按钮
 */
- (void)createTabber{
    
    UIView *tabberView = [[UIView alloc] init];
    tabberView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tabberView];
    [tabberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.bottom.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
    UIButton *oldBtn = nil;
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 100+i;
        [button setTitle:@"一" forState:UIControlStateNormal];
        [tabberView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tabberView).with.offset(0);
            if (oldBtn) {
                make.left.equalTo(oldBtn.mas_right).with.offset(0);
            }else{
                make.left.equalTo(tabberView).with.offset(0);
            }
            make.bottom.equalTo(tabberView).with.offset(0);
            make.width.mas_equalTo(SC_WIDTH/3.0);
        }];
        if (0==i) {
            button.selected=YES;
            selectedButton=button;
        }
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        oldBtn = button;
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
            break;
        case 101:
            scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            break;
        case 102:
            scrollView.contentOffset = CGPointMake(SC_WIDTH*2.0, 0);
            break;
        default:
            break;
    }
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT)];
    scrollView.backgroundColor = [UIColor orangeColor];
//  scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scrollView];
    scrollView.userInteractionEnabled = NO;
    scrollView.contentSize = CGSizeMake(SC_WIDTH*3.0, SC_HEIGHT);
    
    for (int i=0; i<3; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [scrollView addSubview:vc.view];
    }
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
