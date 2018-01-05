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

    NSMutableArray *lv_tableArray;//tableView 数组
    UILabel *lv_upLabel;//升级提示文本
    NSMutableDictionary *lv_TopDic;//数据字典
    UIImageView *lv_headView ;//头视图会员等级icon
    UILabel *lv_levelLabel;//头视图等级

}
@end

@implementation MyLevelController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataSource];
    [self createTopView];
    [self createTableView];
    self.view.backgroundColor = COLORFromRGB(0xffffff);

    // Do any additional setup after loading the view.
}

- (void)getDataSource{
    
    lv_TopDic = [[NSMutableDictionary alloc] init];
    lv_tableArray = [NSMutableArray arrayWithCapacity:2];
    NSString *oldSession  = [[shareDelegate shareNSUserDefaults] objectForKey:@"auth_session"];
    
    NSDictionary *levelDic =@{@"auth_session":oldSession};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    
    [manager POST:LEVEL_URL parameters:levelDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [lv_TopDic addEntriesFromDictionary:responseObject];
        [self mlGetUrlDataToSubview:lv_TopDic[@"my_level_info"]];
        NSArray *dicArray  =  lv_TopDic[@"promote_level_list"] ;
        [self addDataToTabelAarry:dicArray];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
    
}
/**
 添加头视图数据
 
 */
- (void)mlGetUrlDataToSubview:(NSDictionary*)dic{
    
    NSString *amount = dic[@"amount"];
    lv_upLabel.text = [NSString stringWithFormat:@"还差%@元升级",amount];
    
    switch ([dic[@"id"] intValue]) {
        case 1:
            [lv_headView setImage:[UIImage imageNamed:@"普通会员132*132"]];
            lv_levelLabel.text = @"普通会员";
            break;
        case 2:
            [lv_headView setImage:[UIImage imageNamed:@"银牌会员132*132"]];
            lv_levelLabel.text = @"银牌会员";
            break;
        case 3:
            [lv_headView setImage:[UIImage imageNamed:@"金牌会员132*132"]];
            lv_levelLabel.text = @"金牌会员";
            break;
        case 4:
            [lv_headView setImage:[UIImage imageNamed:@"钻石会员132*132"]];
            lv_levelLabel.text = @"钻石会员";
            break;
            
        default:
            break;
    }
    
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:lv_upLabel.text];
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
    [lv_upLabel setAttributedText:noteStr];
    
}

/**
 添加tabelArray数组数据
 */
- (void)addDataToTabelAarry:(NSArray*)array{

    NSArray *imageArray = @[@"普通会员132*132",@"银牌会员44*44",@"金牌会员44*44",@"钻石会员44*44"];
    for (NSDictionary * dic in array) {
        MyLeveLModel *model = [[MyLeveLModel alloc] init];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:3];
        int ID = [dic[@"id"] intValue];
        model.levelView  = imageArray[ID-1];
        model.mebLevel   = dic[@"level_name"];
        model.mebRate    = dic[@"scale"];
        model.mebMoney   = dic[@"amount"];
        model.mebRequest = dic[@"invite_num"];
        model.mebBuyMoney= dic[@"price"];
        [tempArray addObject:model];
        [lv_tableArray addObject:tempArray];
    }
    [_tableView reloadData];
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
        make.top.equalTo(lv_upLabel.mas_bottom).offset(15);
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
    
    lv_headView = [[UIImageView alloc] init];
    lv_headView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.view addSubview:lv_headView];
    lv_headView.layer.masksToBounds = YES;
    lv_headView.layer.cornerRadius  = 33;

    [lv_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(-33/SCALE_Y);
        make.centerX.equalTo(topView.mas_centerX);
        make.height.width.mas_equalTo(66/SCALE_Y);
        
    }];
    
    lv_levelLabel = [[UILabel alloc] init];
    lv_levelLabel.text = @"会员等级";
    lv_levelLabel.textAlignment = NSTextAlignmentCenter;
    [lv_levelLabel setTextColor:COLORFromRGB(0x333333)];
    lv_levelLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:lv_levelLabel];
    
    lv_upLabel = [[UILabel alloc] init];
    lv_upLabel.text = @"还差NNNN元升级";
    lv_upLabel.textAlignment = NSTextAlignmentCenter;
    [lv_upLabel setTextColor:COLORFromRGB(0x333333)];
    lv_upLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:lv_upLabel];

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



    [lv_levelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lv_headView.mas_centerX);
        make.top.equalTo(lv_headView.mas_bottom).offset(10);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(70);
        
    }];
    
    [lv_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(lv_levelLabel.mas_centerX);
        make.top.equalTo(lv_levelLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(150);
        
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

    return  lv_tableArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [lv_tableArray[section] count];;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"reuseIdentifier";
    MyLevelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell= [[MyLevelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addDataToCell:lv_tableArray[indexPath.section][indexPath.row]];
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
