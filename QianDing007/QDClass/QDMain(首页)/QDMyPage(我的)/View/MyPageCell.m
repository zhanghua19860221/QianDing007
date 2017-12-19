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
    //    self.iconView.backgroundColor = [UIColor redColor];
    [self addSubview:self.iconView];
    
    self.directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [self addSubview:self.directionBtn];
    
    self.firstLabel = [[UILabel alloc] init];
    self.firstLabel.font = [UIFont systemFontOfSize:16];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:self.firstLabel];

    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.secondLabel];

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@22);
        make.height.mas_offset(22);
        
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.width.mas_offset(70);
        make.height.mas_offset(22);
        
    }];
    
    [self.directionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.width.mas_offset(20);
        make.height.mas_offset(22);
        
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.right.equalTo(self.directionBtn.mas_left).offset(-15);
        make.width.mas_offset(90);
        make.height.mas_offset(22);
        
    }];

}
//@property(strong , nonatomic) UIImageView *iconView;
//@property(strong , nonatomic) UILabel *firstLabel;
//@property(strong , nonatomic) UILabel *secondLabel;
//@property(strong , nonatomic) UIButton *directionBtn;

-(void)addDataSourceView:(MyPageModel*)model{
    
    [self.iconView setImage:[UIImage imageNamed:model.firstStr]];
//    self.firstLabel.text = model.
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
