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
#import "MyPageCell.h"
#import "UserViewController.h"
#import "MydelegateViewController.h"
#import "SecuritySetController.h"
#import "AboutWeController.h"
#import "CallViewController.h"
#import "UpdateController.h"
@interface MyPage (){
    
    NSMutableArray*allArray;//table分组数组
    UIImageView *topView;//顶视图

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self createTopView];
    [self createTabelView];

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
 
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(40/SCALE_Y);
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
    MyPageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[MyPageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.layer.borderColor = [COLORFromRGB(0xf9f9f9) CGColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataSourceView:allArray[indexPath.section][indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyPageModel *tempModel = [[MyPageModel alloc] init];
    tempModel = allArray[indexPath.section][indexPath.row];
    NSString *tempStr = tempModel.firstStr;
    if ([tempStr isEqual:@"商户认证"]) {
        UserViewController *tempVc = [[UserViewController alloc] init];
        [self.navigationController pushViewController:tempVc animated:YES];
        
    }else if([tempStr isEqual:@"我的代理"]){
        MydelegateViewController *tempVc1 = [[MydelegateViewController alloc] init];
        [self.navigationController pushViewController:tempVc1 animated:YES];

    }else if([tempStr isEqual:@"安全设置"]){
        SecuritySetController *tempVc2 = [[SecuritySetController alloc] init];
        [self.navigationController pushViewController:tempVc2 animated:YES];
        
    }else if([tempStr isEqual:@"关于我们"]){
        AboutWeController *tempVc3 = [[AboutWeController alloc] init];
        [self.navigationController pushViewController:tempVc3 animated:YES];
        
    }else if([tempStr isEqual:@"联系我们"]){
        CallViewController *tempVc4 = [[CallViewController alloc] init];
        [self.navigationController pushViewController:tempVc4 animated:YES];
        
    }else if([tempStr isEqual:@"检查更新"]){
        UpdateController *tempVc5 = [[UpdateController alloc] init];
        [self.navigationController pushViewController:tempVc5 animated:YES];
    }

}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = COLORFromRGB(0xf9f9f9);
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
