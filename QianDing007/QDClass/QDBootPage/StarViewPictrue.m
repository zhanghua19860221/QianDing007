//
//  StarViewPictrue.m
//  StarPictureVC
//
//  Created by duogaojituan on 16/9/1.
//  Copyright © 2016年 duogaojituan. All rights reserved.
//

#import "StarViewPictrue.h"

@implementation StarViewPictrue{
    UIButton * button ;
    NSTimer * timer;
    int  timerCount;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    timerCount = 6;
    if (self) {
        self.frame = CGRectMake (0,0,SC_WIDTH,SC_HEIGHT);
        [self  createData];
        [self  createScrollView];
//      [self  createPageContorl];
        [self  createNSTimer];
        [self  function];
    }
    return self ;
}
//定时器
-(void)createNSTimer{

       timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(function) userInfo:nil repeats:YES];
}
-(void)function{
    timerCount =  timerCount-1;
    if (timerCount <= 0) {
        timerCount = 0;
        [timer setFireDate:[NSDate distantFuture]];
    }
    
    [button setTitle:[NSString stringWithFormat:@"%d",timerCount] forState:UIControlStateNormal];
    
    if (timerCount == 0) {
        
        button.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            self.alpha = 0.0;
            
        }completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
        
    }
}
//获取数据
-(void)createData{
    self.dataArray = [NSMutableArray arrayWithObjects:@"组44", nil];
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
            button.backgroundColor = COLORFromRGB(0x999999);
            [button setTitleColor:COLORFromRGB(0xffffff) forState:UIControlStateNormal];
            [button.layer setBorderWidth:1.0];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:3.0];
            button.layer.borderColor = [COLORFromRGB(0x999999) CGColor];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            button.frame = CGRectMake(SC_WIDTH-75, 64, 60, 20) ;
            [button addTarget:self action:@selector(bttonClick) forControlEvents:UIControlEventTouchUpInside];
            button.userInteractionEnabled = YES;
            [imageView addSubview:button];

        }
        [self.scrollView addSubview:imageView];
    }
    [self addSubview:self.scrollView];
    
}

-(void)bttonClick{
    button.hidden = YES;
    [timer setFireDate:[NSDate distantFuture]];
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
