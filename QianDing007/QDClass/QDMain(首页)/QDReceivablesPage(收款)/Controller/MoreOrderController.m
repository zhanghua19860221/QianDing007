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
    FrontViewController *frontViewVC;//我的界面
    MiddleViewController *middleViewVC;//收款界面
    ThirdViewController *thirdViewVC;//消息界面
    UIView *tabberView;//操作栏视图
    UIView *tabberLineView;//滚动线条

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
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self ;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(SC_WIDTH*3.0, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tabberView.mas_bottom).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
    
    }];
    
    for (int i=0; i<3; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [_scrollView addSubview:vc.view];
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
    
    tabberLineView = [[UIView alloc] init];
    tabberLineView.frame = CGRectMake(0,42,SC_WIDTH/3.0, 2);
    tabberLineView.backgroundColor = COLORFromRGB(0xffffff);
    [tabberView addSubview:tabberLineView];
    
    UIImageView *imageLine = [[UIImageView alloc] init];
    imageLine.backgroundColor = COLORFromRGB(0xe10000);
    imageLine.frame = CGRectMake(15,0,SC_WIDTH/3.0-30 , 2);
    [tabberLineView addSubview:imageLine];

}
- (void)selectBtn:(UIButton*)btn{
    
    if (selectedButton!=btn) {
        selectedButton.selected=NO;
        btn.selected=YES;
        selectedButton=btn;
    }
    switch (btn.tag) {
        case 150:{
            [UIView animateWithDuration:0.3 animations:^{
                tabberLineView.frame = CGRectMake(0,42,SC_WIDTH/3.0, 2);
            }];
            _scrollView.contentOffset = CGPointMake(0, 0);
            }
            break;
        case 151:{
            [UIView animateWithDuration:0.3 animations:^{
                tabberLineView.frame = CGRectMake(SC_WIDTH/3.0,42,SC_WIDTH/3.0, 2);
            }];
            _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            }
            break;
        case 152:{
            [UIView animateWithDuration:0.3 animations:^{
                tabberLineView.frame = CGRectMake(SC_WIDTH/3.0*2,42,SC_WIDTH/3.0, 2);
            }];
            _scrollView.contentOffset = CGPointMake(SC_WIDTH*2.0, 0);
            }
            
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


//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
    // NSLog(@"scrollViewDidScroll");

    // 从中可以读取contentOffset属性以确定其滚动到的位置。
    
    // 注意：当ContentSize属性小于Frame时，将不会出发滚动
    
    
}
// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//    NSLog(@"scrollViewWillBeginDragging");
    
}
// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{

    
}
// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
//    NSLog(@"scrollViewDidEndDragging");
//    if (decelerate) {
//        NSLog(@"decelerate");
//    }else{
//        NSLog(@"no decelerate");
//        
//    }
    
//    CGPoint point=scrollView.contentOffset;
//    NSLog(@"%f,%f",point.x,point.y);
    
}

// 滑动减速时调用该方法。
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    //NSLog(@"scrollViewWillBeginDecelerating");
    // 该方法在scrollViewDidEndDragging方法之后。

}

// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x/SC_WIDTH;
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:150+x];
    if (selectedButton != tempButton) {
        selectedButton.selected = NO;
        tempButton.selected = YES;
        selectedButton = tempButton;
    }
    [UIView animateWithDuration:0.3 animations:^{
        tabberLineView.frame = CGRectMake(x*SC_WIDTH/3.0,42,SC_WIDTH/3.0, 2);
    }];
    
    
//    [_scrollView setContentOffset:CGPointMake(0, 500) animated:YES];
    
}

// 当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法将不被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{


    //NSLog(@"scrollViewDidEndScrollingAnimation");
    // 有效的动画方法为：
    // - (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated 方法
    // - (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated 方法
    
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
