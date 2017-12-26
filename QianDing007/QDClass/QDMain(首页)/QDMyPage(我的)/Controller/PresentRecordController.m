//
//  PresentRecordController.m
//  QianDing007
//
//  Created by 张华 on 17/12/25.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "PresentRecordController.h"
#import "PresentRecordCell.h"
@interface PresentRecordController (){

    UIView *topView ;//顶部视图

    NSMutableArray *dataArray;//tableView数据

}

@end

@implementation PresentRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavgation];
    [self  getDataSource];
    [self createTabelView];

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);

    // Do any additional setup after loading the view.
}
-(void)getDataSource{
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    PresentRecordModel * model = [[PresentRecordModel alloc] init];
    model.orderStr = @"2312431241";
    model.accountStr = @"3525235325";
    model.moneyStr= @"9999.00";
    model.stateStr= @"已到账";
    model.timeStr= @"2017.12.12 01：23";
    [dataArray addObject:model];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UINavigationBar * bar = self.navigationController.navigationBar;
    bar.barTintColor = COLORFromRGB(0xe10000);
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:COLORFromRGB(0xffffff),NSForegroundColorAttributeName,nil]];
    
}
-(void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(114);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-114);
        
    }];
    
}

/**
 创建导航栏
 */
- (void)createNavgation{
    
    self.navigationItem.title = @"提现记录";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20,20);
    [leftButton setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    topView = [[UIView alloc] init];
    topView.backgroundColor = COLORFromRGB(0xe10000);
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"已提现：";
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [nameLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView).offset(25);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(16);
 
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"234566元";
    moneyLabel.font = [UIFont systemFontOfSize:16];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    [moneyLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(nameLabel.mas_right);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(16);
        
    }];


}
/**
 导航栏左侧按钮
 */
- (void)leftBackClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    PresentRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[PresentRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceView:dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 165/SCALE_Y;
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
