//
//  MyRequestController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyRequestController.h"
#import "MyRequestModel.h"
#import "MyRequestCell.h"
@interface MyRequestController (){

    NSMutableArray *dataArray;//数据数组
    UIView *requestView;      //商户邀请记录
    UIScrollView *scrollview; //视图滚动展示
    UIView *requestIconView;  //我要邀请视图
    UIView *maskView;         //蒙板视图
}

@end

@implementation MyRequestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self getDataSource];
    [self createStatistics];
    [self createTabelView];
    [self createMaskView];
    [self createRequestView];
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];

}
- (void)getDataSource{
    
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    for (int i = 0 ; i <5; i++) {
        
        MyRequestModel *model = [[MyRequestModel alloc] init];
        model.userNameStr = @"张学友";
        model.userTeleStr = @"1889998899";
        model.merchantNameStr = @"北京南站";
        model.addressStr = @"北京丰台";
        model.activationTimeStr = @"2017-11-11";
        model.receivablesStr = @"234 元";
        model.listStr = @"432 笔";
        [dataArray addObject:model];
        
    }
    
}
-(void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(74+90/SCALE_Y);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-74-90/SCALE_Y);
        
    }];
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    MyRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MyRequestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceToCell:dataArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220/SCALE_Y;
}

/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"我的邀请";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回图标白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40,40);
    [rightButton setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
    [rightButton setTitle:@"邀请" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
/**
 导航栏左侧按钮
 */
- (void)leftBackClick{
    
    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
    
}
/**
 导航栏右侧按钮
 */
- (void)rightBackClick{
    
    maskView.hidden = NO;
    
    //修改下边距约束
    [requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maskView.mas_bottom).offset(-190/SCALE_Y);
    }];
    //更新约束
    [UIView animateWithDuration:0.5 animations:^{
        [maskView layoutIfNeeded];
    }];
    
}

/**
 顶部统计视图
 */
- (void)createStatistics{
    
    requestView = [[UIView alloc] init];
    requestView.backgroundColor = COLORFromRGB(0xffffff);
    requestView.layer.shadowColor = COLORFromRGB(0xe10000).CGColor;
    [self.view addSubview:requestView];
    [requestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(90/SCALE_Y);
        
    }];
    
    UILabel *orderLabel = [[UILabel alloc] init];
    orderLabel.font = [UIFont systemFontOfSize:20];
    orderLabel.text = @"234";
    [orderLabel setTextColor:COLORFromRGB(0xe10000)];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    [requestView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(requestView).offset(30/SCALE_Y);
        make.left.equalTo(requestView).offset(50/SCALE_X);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    
    }];

    UILabel *orderLabelOne = [[UILabel alloc] init];
    orderLabelOne.font = [UIFont systemFontOfSize:14];
    orderLabelOne.text = @"成功邀请";
    orderLabelOne.textAlignment = NSTextAlignmentCenter;
    [requestView addSubview:orderLabelOne];
    [orderLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderLabel.mas_bottom).offset(10);
        make.left.equalTo(orderLabel);
        make.width.equalTo(orderLabel);
        make.height.mas_equalTo(14);
        
    }];

    UILabel *telephoneLabel = [[UILabel alloc] init];
    telephoneLabel.font = [UIFont systemFontOfSize:20];
    telephoneLabel.text = @"18241499999";
    [telephoneLabel setTextColor:COLORFromRGB(0xe10000)];
    telephoneLabel.textAlignment = NSTextAlignmentRight;
    [requestView addSubview:telephoneLabel];
    [telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(orderLabel.mas_centerY);
        make.right.equalTo(requestView).offset(-50/SCALE_X);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.font = [UIFont systemFontOfSize:14];
    codeLabel.text = @"邀请码";
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [requestView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telephoneLabel.mas_bottom).offset(10);
        make.left.equalTo(telephoneLabel.mas_left).offset(20);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(14);
    
    }];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [copyBtn setTitleColor:COLORFromRGB(0x999999) forState:UIControlStateNormal];
    [requestView addSubview:copyBtn];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeLabel.mas_centerY);
        make.left.equalTo(codeLabel.mas_right);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(14);
    
    }];
    
    UIImageView *line = [[UIImageView alloc] init];
    line.backgroundColor = COLORFromRGB(0x999999);
    [requestView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(copyBtn.mas_bottom).offset(1);
        make.left.right.equalTo(copyBtn);
        make.height.mas_equalTo(2);
    }];
}

/**
 创建邀请视图
 */
- (void)createRequestView{
    
    requestIconView = [[UIView alloc] init];
    requestIconView.backgroundColor = COLORFromRGB(0xffffff);
    [maskView addSubview:requestIconView];
    
    UILabel *typeLable = [[UILabel alloc] init];
    typeLable.text = @"邀请方式:";
    typeLable.textAlignment = NSTextAlignmentLeft;
    typeLable.font = [UIFont systemFontOfSize:18];
    [typeLable setTextColor:COLORFromRGB(0x333333)];
    [requestIconView addSubview:typeLable];
    
    [requestIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(maskView).offset(190/SCALE_Y);
        make.left.right.equalTo(maskView);
        make.height.mas_equalTo(190/SCALE_Y);
        
    }];
    
    [typeLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(requestIconView).offset(25/SCALE_Y);
        make.left.equalTo(requestIconView).offset(15);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(100);

    }];
   
    UIView *iconBJView = [[UIView alloc] init];
    iconBJView.backgroundColor = COLORFromRGB(0xffffff);
    [requestIconView addSubview:iconBJView];
    [iconBJView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(typeLable.mas_bottom).offset(5/SCALE_Y);
        make.left.equalTo(requestIconView).offset(50/SCALE_X);
        make.right.equalTo(requestIconView).offset(-50/SCALE_X);
        make.height.mas_equalTo(95/SCALE_Y);
        
    }];
    
    NSArray *loginViewArray = @[@"微信@2x",@"QQ",@"通讯录"];
    NSArray *loginLabelArrya = @[@"微信邀请",@"QQ邀请",@"通讯录邀请"];
    UIButton *tempBtn = nil;
    for (int i = 0; i<3 ; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:loginViewArray[i]] forState:UIControlStateNormal];
        button.tag = 180+i;
        [iconBJView addSubview:button];
        [button addTarget:self action:@selector(requestViewClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = loginLabelArrya[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        [label setTextColor:COLORFromRGB(0x333333)];
        [iconBJView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button.mas_centerX);
            make.top.equalTo(button.mas_bottom).offset(10);
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(80);
            
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconBJView).offset(15);
            if (tempBtn) {
                make.left.equalTo(tempBtn.mas_right).offset(46/SCALE_X);
            }else{
                
                make.left.equalTo(iconBJView);
            }
            make.width.height.mas_equalTo(60/SCALE_Y);
            
        }];
        tempBtn = button;
    }
    
}
-(void)createMaskView{

    maskView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    maskView.hidden = YES;
    maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];

    [maskView addGestureRecognizer:tapGesturRecognizer];

}

/**

 蒙板点击事件
 */
-(void)tapAction:(id)tap{
    
    [requestIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maskView.mas_bottom).offset(190/SCALE_Y);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [maskView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        maskView.hidden = YES;

    }];
    //更新约束
    
    
}

/**
 邀请对应类型按钮点击事件
 */
- (void)requestViewClick:(UIButton *)btn{
    
    switch (btn.tag) {
        case 180:
            
            break;
        case 181:
            
            break;
        case 182:
            
            break;
            
        default:
            break;
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
