//
//  AllLevelController.m
//  QianDing007
//
//  Created by 张华 on 17/12/24.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "AllLevelController.h"
#import "UserListModel.h"
@interface AllLevelController (){

    NSMutableArray *dataArray;//tableView数据

}

@end
@implementation AllLevelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        dataArray = [[NSMutableArray alloc] initWithCapacity:2];
        UserListModel * model = [[UserListModel alloc] init];
        model.userNameStr = @"北京商务会所";
        model.teleStr = @"13888888888";
        model.allMoneyStr= @"17238.00元";
        model.openTimeStr= @"2017-12-12 20：23：18";
        model.mebIconStr= @"普通会员等级图标";
        model.mebLevelStr= @"普通会员";
        [dataArray addObject:model];
    
        self.basicDataArray = dataArray;

    self.view.backgroundColor = COLORFromRGB(0xf9f9f9);
    // Do any additional setup after loading the view.
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
