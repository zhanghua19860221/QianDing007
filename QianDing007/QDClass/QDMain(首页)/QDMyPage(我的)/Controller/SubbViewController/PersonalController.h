//
//  PersonalController.h
//  QianDing007
//
//  Created by 张华 on 17/12/26.
//  Copyright © 2017年 张华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalController : UIViewController<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
//遵循协议
@property (nonatomic,strong)UIPickerView * pickerView;//自定义pickerview
@property (nonatomic,strong)NSMutableArray * dataArray;//保存要展示内容

@end
