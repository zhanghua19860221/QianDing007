//
//  News.m
//  QianDing007
//
//  Created by 张华 on 17/12/12.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "News.h"
#import "CustomNewsCell.h"
@interface News (){
    UIView *topView;//导航视图
    
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
    [self createTopView];
    [self createTabelView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)createTabelView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    _tableView.separatorStyle = NO;
    _tableView.backgroundColor = COLORFromRGB(0xf9f9f9);
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(SC_HEIGHT-64);
        
    }];
    
}
- (void)createTopView{
    topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 20, SC_WIDTH, 44);
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"消息";
    topLabel.font = [UIFont systemFontOfSize:17];
    topLabel.textColor = [UIColor whiteColor];
    topLabel.backgroundColor = [UIColor redColor];
    [topView addSubview:topLabel];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(topView);
        make.height.mas_offset(17);
        make.width.mas_offset(35);
        
    }];
    
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBtn setImage:[UIImage imageNamed:@"设置图标"] forState:UIControlStateNormal];
    [topView addSubview:topBtn];
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.right.equalTo(topView).offset(-15);
        make.height.mas_offset(22);
        make.width.mas_offset(22);
        
    }];
    
}

#pragma *********************tabelViewDelegate*************************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"tableViewCellIdentifier";
    CustomNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[CustomNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = COLORFromRGB(0xf9f9f9);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
};
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
