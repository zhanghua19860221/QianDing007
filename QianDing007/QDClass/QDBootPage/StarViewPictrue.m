//
//  StarViewPictrue.m
//  StarPictureVC
//
//  Created by duogaojituan on 16/9/1.
//  Copyright © 2016年 duogaojituan. All rights reserved.
//

#import "StarViewPictrue.h"

@implementation StarViewPictrue
{
    UIButton * button ;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake (0,0,SC_WIDTH,SC_HEIGHT);
        [self  createData];
        [self  createScrollView];
//        [self  createPageContorl];
//       [self  createNSTimer];
        
    }
    return self ;
}
//定时器
-(void)createNSTimer{

    NSTimer * timer =  [NSTimer scheduledTimerWithTimeInterval:2.2 target:self selector:@selector(function:) userInfo:nil repeats:YES];

}
//获取数据
-(void)createData{
    self.dataArray = [NSMutableArray arrayWithObjects:@"启动页3", nil];
}
//创建PageContorl
-(void)createPageContorl{
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, SC_HEIGHT*0.8, SC_WIDTH, 40)];
    self.pageControl.numberOfPages   = [self.dataArray count];
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
}
//此方法用来 点击pageControl上的圆点时 让 scrollView 停留在相应的 界面上
-(void)pageTurn:(UIPageControl*)sender  {
    
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
    
}
//创建ScrollView
-(void)createScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsHorizontalScrollIndicator = NO ;
    self.scrollView.showsVerticalScrollIndicator   = NO ;
    self.scrollView.delegate = self ;
    self.scrollView.bounces  = NO   ;
    self.scrollView.pagingEnabled = YES ;
    self.scrollView.scrollEnabled = YES ;

    self.scrollView.contentSize = CGSizeMake(SC_WIDTH, SC_HEIGHT);
    
    for (int i = 0; i < self.dataArray.count; i++) {
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SC_WIDTH*i,0, SC_WIDTH, SC_HEIGHT)];
        [imageView  setImage:[UIImage imageNamed:self.dataArray[i]]];
        imageView.userInteractionEnabled = YES;
        
        if (i==0) {
            
            
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = COLORFromRGB(0xf9f9f9);
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setTitleColor:COLORFromRGB(0x333333) forState:UIControlStateNormal];
            [button.layer setBorderWidth:1.0];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:3.0];
            button.layer.borderColor = [COLORFromRGB(0x333333) CGColor];
            button.titleLabel.font = [UIFont systemFontOfSize:23];
            button.frame = CGRectMake(SC_WIDTH/2-60, SC_HEIGHT*0.85, 120, 30) ;
            [button addTarget:self action:@selector(bttonClick) forControlEvents:UIControlEventTouchUpInside];
            button.userInteractionEnabled = YES;
            [imageView addSubview:button];

            
        }
        [self.scrollView addSubview:imageView];
    }
    [self addSubview:self.scrollView];
    
}
////立即体验按钮 添加 简单的动画效果
//-(void)function:(NSInteger)count{
//
//    [UIView animateWithDuration:1 animations:^{
//        button.frame = CGRectMake(SC_WIDTH/2-60, SC_HEIGHT*0.85, 120, 30) ;
//         button.alpha = 1.0 ;
//        
//    }completion:^(BOOL finished) {
//
//        [UIView animateWithDuration:2 animations:^{
//        button.frame = CGRectMake(SC_WIDTH/2-70, SC_HEIGHT*0.85, 140, 40) ;
//        button.alpha = 0.5 ;
//        button.titleLabel.alpha = 1 ;
//        }];
//    }];
//
//}
-(void)bttonClick{

        [UIView animateWithDuration:1 animations:^{
            
            self.alpha = 0.0;

        }completion:^(BOOL finished) {
    
            [self removeFromSuperview];
        }];
    
}
#pragma mark *******************UIScrollview*********************************
//scorllview开始滚动的时候调用此方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    
}
// scorllview停止滚动时调用此方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isMemberOfClass:[UITableView class]]) {
        
    }else{
        
        int pageCount = fabs(scrollView.contentOffset.x)/scrollView.frame.size.width;
        self.pageControl.currentPage = pageCount ;
        
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
