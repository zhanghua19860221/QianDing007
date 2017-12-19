//
//  MyPage.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyPage.h"
#import "CustomLabelView.h"
#import "MyPageModel.h"
@interface MyPage (){
    
    NSMutableArray*allArray;
    UIImageView *topView;
    UIView *firstView;
    UIView *secondView;
}

@end

@implementation MyPage
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self createTabelView];
//    [self createBasicFirstView];
//    [self createBasicSecondView];
//    [self createLabelView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)createTabelView{

    NSArray *imageFirstArray = @[@"商户认证",@"我的代理"];
    NSArray *stateFirstArray = @[@"未认证",@"空"];
    NSArray *imageSecondArray = @[@"安全设置",@"关于我们",@"联系我们",@"检查更新"];
    NSArray *stateSecondArray= @[@"空",@"空",@"空",@"空"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc] init];
    NSMutableArray *secondArray = [[NSMutableArray alloc] init];
    for (int i = 0; i<imageFirstArray.count ; i++) {
        
        MyPageModel *dataModle = [[MyPageModel alloc] init];
        dataModle.firstStr  = imageFirstArray[i];
        dataModle.secondStr = imageFirstArray[i];
        dataModle.thirdStr  = stateFirstArray[i];
        dataModle.fourStr   = @"更多图标";
        [firstArray addObject:dataModle];
        
    }
    for (int i = 0; i<imageSecondArray.count ; i++) {
        
        MyPageModel *dataModle = [[MyPageModel alloc] init];
        dataModle.firstStr  = imageSecondArray[i];
        dataModle.secondStr = imageSecondArray[i];
        dataModle.thirdStr  = stateSecondArray[i];
        dataModle.fourStr   = @"更多图标";
        [secondArray addObject:dataModle];
    }
    
    allArray = [[NSMutableArray alloc] initWithCapacity:2];
    [allArray addObject:firstArray];
    [allArray addObject:secondArray];
    
    NSLog(@"allArray.count == %lu",(unsigned long)allArray.count);
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = NO;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(20/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT);
    }];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return allArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [allArray[section] count];;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSLog(@"xxxxx == %@" ,allArray[indexPath.section][indexPath.row]);
    
    cell.contentView.backgroundColor = [UIColor cyanColor];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20/SCALE_Y;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)createBasicSecondView{
    
    secondView = [[UIView alloc] init];
    secondView.backgroundColor = [UIColor whiteColor];
    secondView.frame = CGRectMake(0,firstView.frame.origin.y+firstView.frame.size.height+20/SCALE_Y, SC_WIDTH, 203/SCALE_Y);
    [self.view addSubview:secondView];
    
    CustomLabelView *view = [[CustomLabelView alloc] initWithFrame:@"安全设置" firstLabel:@"安全设置" secondLabel:@"空" secondImage:@"更多图标"];
    view.frame = CGRectMake(0, 0,SC_WIDTH,50);
    [secondView addSubview:view];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    lineView.frame = CGRectMake(0, view.frame.size.height+view.frame.origin.y, SC_WIDTH, 1);
    [secondView addSubview:lineView];

    CustomLabelView *view1 = [[CustomLabelView alloc] initWithFrame:@"关于我们" firstLabel:@"关于我们" secondLabel:@"空" secondImage:@"更多图标"];
    view1.frame = CGRectMake(0,lineView.frame.origin.y+1,SC_WIDTH,50);
    [secondView addSubview:view1];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = COLORFromRGB(0xf9f9f9);
    lineView1.frame = CGRectMake(0, view1.frame.size.height+view1.frame.origin.y, SC_WIDTH, 1);
    [secondView addSubview:lineView1];
    
    CustomLabelView *view2 = [[CustomLabelView alloc] initWithFrame:@"联系我们" firstLabel:@"联系我们" secondLabel:@"空" secondImage:@"更多图标"];
    view2.frame = CGRectMake(0,lineView1.frame.origin.y+1,SC_WIDTH,50);
    [secondView addSubview:view2];

    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = COLORFromRGB(0xf9f9f9);
    lineView2.frame = CGRectMake(0, view2.frame.size.height+view2.frame.origin.y, SC_WIDTH, 1);
    [secondView addSubview:lineView2];
    
    
    CustomLabelView *view3 = [[CustomLabelView alloc] initWithFrame:@"检查更新" firstLabel:@"检查更新" secondLabel:@"空" secondImage:@"更多图标"];
    view3.frame = CGRectMake(0,lineView2.frame.origin.y+1,SC_WIDTH,50);
    [secondView addSubview:view3];



}
- (void)createBasicFirstView{

    firstView = [[UIView alloc] init];
    firstView.backgroundColor = [UIColor whiteColor];
    firstView.frame = CGRectMake(0,topView.frame.origin.y+topView.frame.size.height+40/SCALE_Y, SC_WIDTH, 101/SCALE_Y);
    [self.view addSubview:firstView];
    
    CustomLabelView *view = [[CustomLabelView alloc] initWithFrame:@"商户认证" firstLabel:@"商户认证" secondLabel:@"未认证" secondImage:@"更多图标"];
    view.frame = CGRectMake(0, 0,SC_WIDTH,50);
    [firstView addSubview:view];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    lineView.frame = CGRectMake(0, view.frame.size.height+view.frame.origin.y, SC_WIDTH, 1);
    [firstView addSubview:lineView];
    
    CustomLabelView *view1 = [[CustomLabelView alloc] initWithFrame:@"我的代理" firstLabel:@"我的代理" secondLabel:@"空" secondImage:@"更多图标"];
    view1.frame = CGRectMake(0,lineView.frame.origin.y+1,SC_WIDTH,50);
    [firstView addSubview:view1];
    
    
}
/**
 创建label视图
 */
- (void)createLabelView{

}
/**
 创建头视图
 */
- (void)createTopView{
    
    topView = [[UIImageView alloc] init];
    topView.frame = CGRectMake(0,20, SC_WIDTH, 160/SCALE_Y);
    [topView setImage:[UIImage imageNamed:@"红色背景"]];
    [self.view addSubview:topView];
    
    UIImageView *headView = [[UIImageView alloc] init];
    headView.backgroundColor = [UIColor orangeColor];
    headView.layer.cornerRadius = 35;
    headView.layer.masksToBounds = YES;
    [topView addSubview:headView];
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.text = @"未认证";
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textColor = COLORFromRGB(0xffffff);
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.font = [UIFont systemFontOfSize:16];
    [topView addSubview:stateLabel];
    
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.center.equalTo(topView);
        
    }];
    
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
    
}
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
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
