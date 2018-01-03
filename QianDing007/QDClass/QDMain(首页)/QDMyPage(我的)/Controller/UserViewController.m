//
//  UserViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "UserViewController.h"
#import "CompanyController.h"
#import "PersonalController.h"
@interface UserViewController (){
    
    UIView *topView;    //创建顶部选择按钮
    UIButton *selectBtn;//记录选中的按钮
    UIView *onePageView;//第一页展示视图
    UIView *twoPageView;//第二页展示视图
    
    CompanyController *companyVC;   //企业认证
    PersonalController *personalVC; //个人认证
    
}
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self createChooseView];
    [self createSubViewController];
    [self createScrollerView];

    
    self.view.backgroundColor = COLORFromRGB(0xffffff);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xffffff);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0x333333),NSForegroundColorAttributeName,nil]];
    
}
/**
 scrollerView展示控制器
 */
- (void)createScrollerView{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    _scrollView.delegate = self ;
    _scrollView.scrollEnabled = NO;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(SC_WIDTH*2.0, 0);
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT);
        
    }];
    for (int i=0; i<2; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame= CGRectMake(SC_WIDTH*i, 0, SC_WIDTH, SC_HEIGHT);
        [_scrollView addSubview:vc.view];
    }
}
/**
 创建子控制器
 */
- (void)createSubViewController{
    companyVC = [[CompanyController alloc] init];
    personalVC = [[PersonalController alloc] init];

    [self addChildViewController:companyVC];
    [self addChildViewController:personalVC];
}

- (void)createChooseView{

    topView = [[UIView alloc] init];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60/SCALE_Y);
        
    }];

    NSArray *oneArray = @[@"企业认证",@"个人认证"];
    NSArray *twoArray = @[@"(有营业执照)",@"(无营业执照)"];
    
    UIButton *tempBtn = nil;
    for (int i = 0; i < 2; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = COLORFromRGB(0xebebeb);
        button.tag = 300+i;
        [topView addSubview:button];
        [button addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            button.backgroundColor = COLORFromRGB(0xe10000);
            selectBtn = button;
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right);
            }else{
                make.left.equalTo(self.view);
            }
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(SC_WIDTH/2.0);
        }];
        
        UILabel *lableOne = [[UILabel alloc] init];
        lableOne.text = oneArray[i];
        lableOne.textAlignment = NSTextAlignmentCenter;
        [lableOne setTextColor:COLORFromRGB(0xffffff)];
        lableOne.font = [UIFont systemFontOfSize:16];
        [button addSubview:lableOne];
        [lableOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(button).offset(15);
            make.left.right.equalTo(button);
            make.height.mas_equalTo(16);
    
        }];
        UILabel *lableTwo = [[UILabel alloc] init];
        lableTwo.text = twoArray[i];
        lableTwo.textAlignment = NSTextAlignmentCenter;
        [lableTwo setTextColor:COLORFromRGB(0xffffff)];
        lableTwo.font = [UIFont systemFontOfSize:14];
        [button addSubview:lableTwo];
        [lableTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lableOne.mas_bottom);
            make.left.right.equalTo(button);
            make.height.mas_equalTo(14);
            
        }];
        
        tempBtn = button;
    }
}

/**
  选择框导航栏
 */
- (void)changeClick:(UIButton*)btn{
    
    if (selectBtn!=btn) {
        selectBtn.selected=NO;
        selectBtn.backgroundColor = COLORFromRGB(0xebebeb);
        btn.selected=YES;
        btn.backgroundColor = COLORFromRGB(0xe10000);
        selectBtn=btn;
    }
    
    switch (btn.tag) {
        case 300:
            _scrollView.contentOffset = CGPointMake(0, 0);
            break;
        case 301:
            _scrollView.contentOffset = CGPointMake(SC_WIDTH, 0);
            break;
        default:
            break;
    }

}
/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"商家认证";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xffffff);
    [leftButton setImage:[UIImage imageNamed:@"返回图标黑色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
/**
 导航栏左侧按钮点击事件
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma ********************UIScrollViewDelegate**************
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int x = scrollView.contentOffset.x/SC_WIDTH;
    
    UIButton *tempButton = (UIButton *)[self.view viewWithTag:300+x];
    if (selectBtn != tempButton) {
        selectBtn.selected=NO;
        selectBtn.backgroundColor = COLORFromRGB(0xebebeb);
        tempButton.selected = YES;
        tempButton.backgroundColor = COLORFromRGB(0xe10000);
        selectBtn = tempButton;
    }
    [_scrollView setContentOffset:CGPointMake(x*SC_WIDTH, 0) animated:YES];
    
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
