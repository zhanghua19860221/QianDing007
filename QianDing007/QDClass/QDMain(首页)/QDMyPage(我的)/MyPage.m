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
#import "BecomeDelegateController.h"

@interface MyPage (){
    
    NSMutableArray*allArray;//table分组数组
    UIImageView *topView ;//顶视图
    UIButton *codeButton ;//二维码展示button
    UIView *myMaskView;   //蒙板视图
    UIButton *maskCodeButton; //蒙板button

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
    [self createCodeView];
    [self createMaskView];


    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
 
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

- (void)createCodeView{
    
    codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    codeButton.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:codeButton];
    [codeButton addTarget:self action:@selector(myCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-15);
        make.width.height.mas_equalTo(44);
        
        
    }];
    
}
- (void)myCodeButton:(UIButton*)btn{
    
    [maskCodeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(myMaskView);
        make.height.width.mas_equalTo(200);
        
    }];
    myMaskView.hidden = NO;
    btn.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
       [myMaskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
       
        
    }];
}
-(void)createMaskView{
    
    myMaskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    myMaskView.hidden = YES;
    myMaskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:myMaskView];
    
    maskCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maskCodeButton.backgroundColor = COLORFromRGB(0xf9f9f9);
    [myMaskView addSubview:maskCodeButton];
    [maskCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myMaskView).offset(20);
        make.right.equalTo(myMaskView).offset(-15);
        make.width.height.mas_equalTo(44);
        
    }];

    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myTapAction:)];
    [myMaskView addGestureRecognizer:tapGesturRecognizer];
    
}
/**
 
 蒙板点击事件
 */
-(void)myTapAction:(id)tap{
    
    [maskCodeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myMaskView).offset(20);
        make.right.equalTo(myMaskView).offset(-15);
        make.width.height.mas_equalTo(44);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [myMaskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        codeButton.hidden = NO;
        myMaskView.hidden = YES;
    }];

}

#pragma **************UITableViewDelegate**************************

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
        int i = 1;
        if (i == 10) {
            
            MydelegateViewController *tempVc1 = [[MydelegateViewController alloc] init];
            [self.navigationController pushViewController:tempVc1 animated:YES];
            
        }else{
            
            BecomeDelegateController *tempVc = [[BecomeDelegateController alloc] init];
            [self.navigationController pushViewController:tempVc animated:YES];
            
        }

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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, SC_WIDTH, 20);
    imageView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:imageView];
    
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
