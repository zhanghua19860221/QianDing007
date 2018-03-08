//
//  MyPageCell.m
//  QianDing007
//
//  Created by 张华 on 17/12/19.
//  Copyright © 2017年 张华. All rights reserved.
//

#import "MyPageCell.h"

@implementation MyPageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configCell];
    }
    return self;
}
- (void)configCell{

    self.iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconView];
    
    self.directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.directionBtn];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.font = [UIFont systemFontOfSize:16];
    self.firstLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.firstLabel];

    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.font = [UIFont systemFontOfSize:14];
    self.secondLabel.textAlignment = NSTextAlignmentRight;
    [self.secondLabel setTextColor:COLORFromRGB(0x999999)];
    [self.contentView addSubview:self.secondLabel];

    UIImageView *lineView = [[UIImageView alloc] init];
    lineView.backgroundColor = COLORFromRGB(0xf9f9f9);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];

}

-(void)addDataSourceView:(MyPageModel*)model Version:(NSString*)version{
    
    [self.iconView setImage:[UIImage imageNamed:model.firstStr]];
    self.firstLabel.text = model.secondStr;
    self.secondLabel.text = model.thirdStr;
    
    [self.directionBtn setImage:[UIImage imageNamed:model.fourStr] forState:UIControlStateNormal];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(22);
        
    }];
    
    [self.directionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self).offset(-15);
        make.width.mas_offset(20);
        make.height.mas_offset(22);
        
    }];
        
    //判断我的界面 cell认证状态，及是否显示
    if ([self.firstLabel.text isEqualToString:@"商户认证"]) {
        
        if ([model.thirdStr isEqualToString:@"1"]){
            self.secondLabel.text = @"已认证";
            [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.directionBtn.mas_left).offset(-5);
                make.width.mas_offset(50);
                make.height.mas_offset(14);
                
            }];
            
        }else {
            self.secondLabel.text = @"未认证";
            [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView.mas_centerY);
                make.right.equalTo(self.directionBtn.mas_left).offset(-5);
                make.width.mas_offset(50);
                make.height.mas_offset(14);
                
            }];
        }
        
    }
    if ([self.firstLabel.text isEqualToString:@"检查更新"]) {
        self.secondLabel.text = version;
        [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.directionBtn.mas_left).offset(-5);
            make.width.mas_offset(50);
            make.height.mas_offset(14);
            
        }];
        
    }
    

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
