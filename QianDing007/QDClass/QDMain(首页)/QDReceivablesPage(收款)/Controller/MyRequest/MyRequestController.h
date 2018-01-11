//
//  MyRequestController.h
//  QianDing007
//
//  Created by 张华 on 17/12/20.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ContactsUI/ContactsUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface MyRequestController : UIViewController<UITableViewDelegate,UITableViewDataSource,CNContactPickerDelegate>

@property (strong , nonatomic) UITableView *tableView;

@end
