//
//  StarViewPictrue.h
//  StarPictureVC
//
//  Created by duogaojituan on 16/9/1.
//  Copyright © 2016年 duogaojituan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarViewPictrue : UIView < UIScrollViewDelegate>

@property(strong ,nonatomic) UIScrollView   * scrollView;
@property(strong ,nonatomic) UIPageControl  * pageControl;
@property(strong ,nonatomic) NSMutableArray * dataArray ;

@end
