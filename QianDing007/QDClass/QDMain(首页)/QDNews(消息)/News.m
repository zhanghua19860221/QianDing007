//
//  News.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "News.h"
#import "CustomNewsCell.h"
#import "NewsSetController.h"
#import "NewsModel.h"
@interface News (){
    UIView *topView;//导航视图
    NSMutableArray *dataArray;//消息数组
    
}
@end

@implementation News
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
    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self nsGetDataSource];
    [self nsCreateTopView];
    [self nsCreateTabelView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xe10000);
    
}

/**
 初始化消息 数据
 */
- (void)nsGetDataSource{
    dataArray = [NSMutableArray arrayWithCapacity:2];
    NSArray *dayArray = @[@"今天",@"",@"05",@"",@"04",@"05"];
    NSArray *monthArray = @[@"10月",@"",@"12月",@"",@"11月",@"07月"];
    NSArray *nameArray = @[@"商户认证失败。",@"收款234.00元已到账。",@"您的代理商提现234.00元，已成功到账。",@"您的代理商提现234.00元失败",@"来自0000公司升级的1.50元分润已到账",@"来自0000公司的1.50元分润已到账"];
    NSArray *timeArray = @[@"11:20:28",@"11:20:18",@"11:10:28",@"11:30:28",@"11:01:28",@"11:20:28"];
    NSArray *reasonFailArray = @[@"0",@"1",@"2",@"3",@"4",@"5"];

    for (int i = 0; i<nameArray.count; i++ ) {
        NewsModel *model = [[NewsModel alloc] init];
        model.newsDay = dayArray[i];
        model.newsMonth = monthArray[i];
        model.newsInfo = nameArray[i];
        model.newsReasonFail = reasonFailArray[i];
        model.newsTime = timeArray[i];
        [dataArray addObject:model];
    }
}

/**
 创建tableview
 */
- (void)nsCreateTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-130);
        
    }];
    
}

/**
 创建导航栏视图
 */
- (void)nsCreateTopView{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, SC_WIDTH, 20);
    imageView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:imageView];
    
    topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 20, SC_WIDTH, 44);
    topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"消息";
    topLabel.font = [UIFont systemFontOfSize:17];
    topLabel.textColor = COLORFromRGB(0xffffff);
    topLabel.backgroundColor = COLORFromRGB(0xe10000);
    [topView addSubview:topLabel];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
        make.height.mas_offset(17);
        make.width.mas_offset(35);
        
    }];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setImage:[UIImage imageNamed:@"设置图标"] forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(setBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topBtn];
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView).offset(-15);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
        
    }];
    
}

/**
 设置按钮点击事件
 */
-(void)setBtnClick{
    
    NewsSetController *newVc= [[NewsSetController alloc] init];
    [self.navigationController pushViewController:newVc animated:YES];
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    CustomNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[CustomNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [cell addDataSourceToCell:dataArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = dataArray[indexPath.row];
    float heightInfo = [shareDelegate labelHeightText:model.newsInfo Font:16 Width:280/SCALE_X];
    

    float heightFail = 0;
    float heightCell = 0;

    if ([model.newsReasonFail isEqualToString:@"0"]) {
        heightFail =  [shareDelegate labelHeightText:model.newsReasonFail Font:12 Width:280/SCALE_X];
        heightCell = heightInfo + heightFail + 60 + 12;

    }else{
        heightCell = heightInfo + heightFail + 50 + 12;
    }
    // cell的高度 ＝ 商户信息的高度 ＋ 失败时信息的高度 ＋ 控件间隙高度 + 时间控件高度
    return heightCell;
};
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
