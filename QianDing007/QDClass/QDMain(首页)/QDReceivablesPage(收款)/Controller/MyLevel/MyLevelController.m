//
//  MyLevelController.m
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyLevelController.h"
#import "MyLevelCell.h"
#import "MyLeveLModel.h"
@interface MyLevelController (){

    NSMutableArray *tableArray;//tableView 数组
    UILabel *upLabel;//升级提示文本
}
@end

@implementation MyLevelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTopView];
    [self getDataSource];
    [self createTableView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);

    // Do any additional setup after loading the view.
}

- (void)getDataSource{
    
    tableArray = [[NSMutableArray alloc] initWithCapacity:2];
    NSArray *imageArray = @[@"银牌会员44*44",@"金牌会员44*44",@"钻石会员44*44"];
    NSArray *levelArray = @[@"银牌会员",@"金牌会员",@"钻石会员"];
    NSArray *rateArray  = @[@"100%",@"200%",@"300%"];
    
    for (int i = 0; i<3 ; i++) {
        MyLeveLModel *model = [[MyLeveLModel alloc] init];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:1];
        model.levelView  = imageArray[i];
        model.mebLevel   = levelArray[i];
        model.mebRate    = rateArray[i];
        model.mebList    = @"满足下列条件后升级";
        model.mebMoney   = @"收款1000万";
        model.mebRequest = @"邀请一千万个会员";
        model.mebBuyMoney= @"直接购买1000万";
        model.listView   = @"金牌会员提示水印";
        [tempArray addObject:model];
        [tableArray addObject:tempArray];
    }
}
/**
 创建tableview
 */
- (void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SC_HEIGHT-213/SCALE_Y);
        
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)createTopView{

    UIImageView *topView = [[UIImageView alloc] init];
    [topView setImage:[UIImage imageNamed:@"标题栏红色底"]];
    [self.view addSubview:topView];
    topView.userInteractionEnabled = YES;

    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maskBtn.backgroundColor = COLORFromRGB(0xe10000);
    [topView addSubview:maskBtn];
    [maskBtn addTarget:self action:@selector(leftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"返回箭头白色"] forState:UIControlStateNormal];
    [topView addSubview:button];
    [button addTarget:self action:@selector(leftBackClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"等级";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [titleLabel setTextColor:COLORFromRGB(0xffffff)];
    [topView addSubview:titleLabel];
    
    UIImageView *headView = [[UIImageView alloc] init];
    [headView setImage:[UIImage imageNamed:@"普通会员132*132"]];
    [self.view addSubview:headView];
    
    UILabel *levelLabel = [[UILabel alloc] init];
    levelLabel.text = @"普通会员";
    levelLabel.textAlignment = NSTextAlignmentCenter;
    [levelLabel setTextColor:COLORFromRGB(0x333333)];
    levelLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:levelLabel];
    
    upLabel = [[UILabel alloc] init];
    upLabel.text = @"还差10000元升级";
    upLabel.textAlignment = NSTextAlignmentCenter;
    [upLabel setTextColor:COLORFromRGB(0x333333)];
    upLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:upLabel];
    
// 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:upLabel.text];
// 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:@"差"].location+1;
// 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:@"元"].location;
// 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
// 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:COLORFromRGB(0xe10000) range:range];
// 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
// 为label添加Attributed
    [upLabel setAttributedText:noteStr];
    

    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(topView).offset(35/SCALE_Y);
        make.height.mas_equalTo(22/SCALE_Y);
    }];

    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(122/SCALE_Y);
        
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView).offset(35/SCALE_Y);
        make.left.equalTo(topView).offset(15);
        make.height.mas_equalTo(22/SCALE_Y);
    }];
    

    [maskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(button);
        make.height.width.mas_equalTo(30/SCALE_Y);
    }];

    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(-33/SCALE_Y);
        make.centerX.equalTo(topView.mas_centerX);
        make.height.width.mas_equalTo(66/SCALE_Y);
        
    }];

    [levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView.mas_centerX);
        make.top.equalTo(headView.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
        
    }];
    
    [upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(levelLabel.mas_centerX);
        make.top.equalTo(levelLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(100);
        
    }];
    
}

/**
 返回按钮
 */
- (void)leftBackClick:(UIButton*)btn{
    
//    //展示tabBar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil userInfo:@{@"color":@"1",@"title":@"1"}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma ******************tabelViewDelegate*****************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return  tableArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableArray[section] count];;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"reuseIdentifier";
    MyLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell= [[MyLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataToCell:tableArray[indexPath.section][indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 235/SCALE_Y;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
