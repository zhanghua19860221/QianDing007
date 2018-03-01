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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];

    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabBar:) name:@"removeTabBar" object:nil];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar:) name:@"showTabBar" object:nil];
    
    //注册消息通知-把数据保存到数据库
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveFMDBData:) name:@"saveFMDBData" object:nil];
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self  creatSubView];
    [self  creatTabBarView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)removeTabBar:(NSNotification *)noti{
    [self.tabBar removeFromSuperview];
    _tabberView.hidden = YES;
}
- (void)showTabBar:(NSNotification *)noti{
    
    
    _tabberView.hidden = NO;
}
/**
 数据库添加数据
 
 */
- (void)saveFMDBData:(NSNotification*)notification{
    
    NSDictionary * infoDic = notification.userInfo;
    NSLog(@"infoDic == %@",infoDic);
    BOOL isSucceed=[[shareDelegate shareFMDatabase] executeUpdate:@"insert into collectBase values(?,?,?,?,?,?)",infoDic[@"content"],infoDic[@"extra"],infoDic[@"title"],infoDic[@"time"],infoDic[@"money"],[shareDelegate sharedManager].b_userID];
    if (isSucceed) {
        NSLog(@"插入成功");
        
    }
    
}
- (void)creatTabBarView{
    
    NSArray *tabDafImageArray = @[@"收款2",@"消息2",@"我的2"];
    NSArray *tabSelImageArray = @[@"收款1",@"消息",@"操作栏我的选中@2x"];
    
    _tabberView = [[UIView alloc] init];
    _tabberView.backgroundColor =COLORFromRGB(0xf9f9f9);
    _tabberView.layer.borderWidth = 1;
    _tabberView.layer.borderColor = [[UIColor grayColor] CGColor];
    _tabberView.frame = CGRectMake(0, SC_HEIGHT-49, SC_WIDTH, 49);
    [self.view addSubview:_tabberView];
    
    for (int i=0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.tag = 100+i;
        button.frame = CGRectMake(i*SC_WIDTH/3.0, 0, SC_WIDTH/3.0, 49);
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
-(void)selectBtn:(UIButton*)btn{
    if (_selectedButton!=btn) {
        _selectedButton.selected=NO;
        btn.selected=YES;
        _selectedButton=btn;
    }
    self.selectedIndex=btn.tag-100;
    
    switch (btn.tag) {
        case 100:
            break;
            
        case 101:
            
            break;
        case 102:

            break;
        default:
            break;
    }
    

}

-(void)creatSubView{
    
    ReceivablesPage*first=[[ReceivablesPage alloc] init];
    UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:first];
    
    MyPage *third=[[MyPage alloc] init];
    
    News*Second=[[News alloc] init];
    
    self.viewControllers=@[nav,Second,third];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
  [super viewDidDisappear:animated];
  [[NSNotificationCenter defaultCenter]  removeObserver:self  name:@"removeTabBar"  object:nil];
  [[NSNotificationCenter defaultCenter]  removeObserver:self  name:@"showTabBar"    object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self
                                                        name:@"saveFMDBData"                  object:nil];
    
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
