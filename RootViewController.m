//
//  RootViewController.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "RootViewController.h"
#import "ReceivablesPage.h"
#import "MyPage.h"
#import "News.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBar removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  creatSubView];
    [self  creatTabBarView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabBar:) name:@"removeTabBar" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar:) name:@"showTabBar" object:nil];
    // Do any additional setup after loading the view.
}
- (void)removeTabBar:(NSNotification *)noti{

    _tabberView.hidden = YES;
}
- (void)showTabBar:(NSNotification *)noti{
    
    _tabberView.hidden = NO;
}

- (void)creatTabBarView{
    
    NSArray *tabDafImageArray = @[@"操作栏收款未选中",@"操作栏消息未选中",@"操作栏我的未选中"];
    NSArray *tabSelImageArray = @[@"操作栏收款选中",@"操作栏消息选中",@"操作栏我的选中"];
    
    _tabberView = [[UIView alloc] init];
    _tabberView.backgroundColor =COLORFromRGB(0xf9f9f9);
    _tabberView.layer.borderWidth = 1;
    _tabberView.layer.borderColor = [[UIColor grayColor] CGColor];
    _tabberView.frame = CGRectMake(0, SC_HEIGHT-44, SC_WIDTH, 44);
    [self.view addSubview:_tabberView];
    
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 100+i;
        button.frame = CGRectMake(i*SC_WIDTH/3.0, 0, SC_WIDTH/3.0, 44);
        [_tabberView addSubview:button];
        
        if (0==i) {

            button.selected=YES;
            _selectedButton=button;
        }
        [button setImage:[UIImage imageNamed:tabDafImageArray[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:tabSelImageArray[i]] forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)selectBtn:(UIButton*)btn
{
    if (_selectedButton!=btn) {
        _selectedButton.selected=NO;
        btn.selected=YES;
        _selectedButton=btn;
    }
    self.selectedIndex=btn.tag-100;
    
    switch (btn.tag) {
        case 100:
            [self setStatusBarBackgroundColor:[UIColor whiteColor]];
            break;
        case 101:
            [self setStatusBarBackgroundColor:[UIColor redColor]];
            break;
        case 102:
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

-(void)creatSubView
{
    ReceivablesPage*first=[[ReceivablesPage alloc] init];
    UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:first];

    MyPage *third=[[MyPage alloc] init];
    News*Second=[[News alloc] init];
    
    self.viewControllers=@[nav,Second,third];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

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
