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
    UIImageView *nullImageView;//暂无数据图片展示视图
    
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
    [self nsCreateTopView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = COLORFromRGB(0xe10000);
    [self nsGetDataSource];

}

/**
 初始化消息 数据
 */
- (void)nsGetDataSource{
    [self.dataArray removeAllObjects];
    [self.tempArray removeAllObjects];

    FMResultSet*result = [[shareDelegate shareFMDatabase] executeQuery:@"select * from collectBase"];
    //FMResultSet类似链表，他的头节点是nil，需要从第二位开始读取
    while ([result next]) {
        NSString * str = [result stringForColumn:@"userId"];
        if ([str isEqualToString:[shareDelegate sharedManager].b_userID]) {
            NewsModel *model = [[NewsModel alloc] init];
            model.extra = [result stringForColumn:@"extra"];
            model.content = [result stringForColumn:@"content"];
            model.title = [result stringForColumn:@"title"];
            model.time = [result stringForColumn:@"time"];
            model.money = [result stringForColumn:@"money"];
            [self.tempArray addObject:model];
            
        }
    }
    //将数据库中数据 倒序入data数组中
    for (NSInteger i = self.tempArray.count-1; i>=0; i--) {
        NewsModel *model = (NewsModel*)self.tempArray[i];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    
    if (self.dataArray.count == 0) {
        nullImageView = [[UIImageView alloc] init];
        [nullImageView setImage:[UIImage imageNamed:@"暂无1"]];
        [self.view addSubview:nullImageView];
        [nullImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(-30);
            make.width.mas_equalTo(125);
            make.height.mas_equalTo(115);

        }];
    }

}
/**
 懒加载临时数组
 */
- (NSMutableArray *)tempArray{
    if (nil == _tempArray) {
        _tempArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _tempArray;
}
/**
 懒加载数组
 */
- (NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}
/**
 懒加载tableview
 
 */
- (UITableView *)tableView{
    if (nil == _tableView) {
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
        
    return _tableView;
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
    return self.dataArray.count;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *ID = [NSString stringWithFormat:@"Cell%ld",(long)indexPath.row];
    CustomNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[CustomNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [cell addDataSourceToCell:self.dataArray[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsModel *model = self.dataArray[indexPath.row];
    float heightInfo = [shareDelegate labelHeightText:model.title Font:16 Width:280/SCALE_X];
    float heightFail = 0;
    float heightCell = 0;

    if ([model.extra isEqualToString:@"auth_fail"]) {
        heightFail =  [shareDelegate labelHeightText:model.content Font:12 Width:280/SCALE_X];
        heightCell = heightInfo + heightFail + 60 + 12;

    }else{
        heightCell = heightInfo + heightFail + 50 + 12;
    }
    // cell的高度 ＝ 商户信息的高度 ＋ 失败时信息的高度 ＋ 控件间隙高度 + 时间控件高度
    return heightCell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [nullImageView removeFromSuperview];
    
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
