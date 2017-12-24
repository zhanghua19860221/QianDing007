//
//  GetProfitController.m
//  QianDing007
//
//  Created by 张华 on 17/12/22.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "GetProfitController.h"
#import "MyGetProfitModel.h"
#import "MyGetProfitCell.h"
@interface GetProfitController (){

    NSMutableArray *dataArray;//tableView
}
@end

@implementation GetProfitController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  getDataSource];
    [self createTabelView];

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)getDataSource{
    dataArray = [[NSMutableArray alloc] initWithCapacity:2];
    MyGetProfitModel * model = [[MyGetProfitModel alloc] init];
    model.timeStr = @"2017-12-21  20:23:08";
    model.userStr = @"北京商务会所";
    model.getMoneyStr= @"17238元";
    model.iconStr= @"银牌会员44*44";
    model.levelStr= @"普通会员";
    model.profitStr= @"81.22元";
    [dataArray addObject:model];
    
}
-(void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-124);
        
    }];
}
#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    MyGetProfitCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[MyGetProfitCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xffffff);
    [cell addDataSourceView:dataArray[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 134/SCALE_Y;
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
