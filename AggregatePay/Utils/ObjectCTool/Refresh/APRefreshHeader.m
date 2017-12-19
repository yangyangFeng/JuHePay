//
//  APRefreshHeader.m
//  Intercommerce
//
//  Created by 沈陈 on 16/7/26.
//  Copyright © 2016年 Cnepay. All rights reserved.
//

#import "APRefreshHeader.h"
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
/***  宽高比率**/
#define BaseWidth (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])?320:568)
#define BaseHeight (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])?568:320)

#define WRATIO MAX(1.0f,roundf(ScreenWidth / BaseWidth * 100) / 100)
#define HRATIO MAX(1.0f,roundf(ScreenHeight / BaseHeight * 100) / 100)

@interface APRefreshHeader()
@property (weak, nonatomic) UIView *headRefreshView;
@property (weak, nonatomic) UILabel *stateLabel;
@property (weak, nonatomic) UIView *refreshImageView;
@property (weak, nonatomic) UIImageView *refreshOutwordImageView;
@property (weak, nonatomic) UIImageView *refreshInnerImageView;

@end

@implementation APRefreshHeader
#define padding 16*WRATIO
#define imageH  31*HRATIO*0.6
#define imageW  31*WRATIO*0.6

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare {
    [super prepare];
    
    //设置控件的高度
    self.mj_h = 50;
    
    UIView *headRefreshView = [[UIView alloc]init];
    headRefreshView.backgroundColor = [UIColor clearColor];
    [self addSubview:headRefreshView];
    self.headRefreshView = headRefreshView;
    
    UILabel *stateLabel = [[UILabel alloc] init];
    stateLabel.textAlignment = NSTextAlignmentCenter;
    stateLabel.backgroundColor = [UIColor clearColor];
    stateLabel.textColor = [UIColor blackColor];
    stateLabel.font = [UIFont systemFontOfSize:13];
    [self.headRefreshView addSubview:stateLabel];
    self.stateLabel = stateLabel;
    
    
    UIView *refreshImageView = [[UIView alloc]init];
    refreshImageView.backgroundColor = [UIColor clearColor];
    self.refreshImageView = refreshImageView;
    [headRefreshView addSubview:refreshImageView];
    
    UIImageView *refreshOutwordImageView = [[UIImageView alloc]init];
    UIImage *outwordImage = [UIImage imageNamed:@"AP_Loading"];
    refreshOutwordImageView.image = outwordImage;
    refreshOutwordImageView.frame = CGRectMake(0, 0, outwordImage.size.width* WRATIO * 1, outwordImage.size.height* WRATIO * 1);
    self.refreshOutwordImageView = refreshOutwordImageView;
    [refreshImageView addSubview:refreshOutwordImageView];
    
    UIImageView *refreshInnerImageView = [[UIImageView alloc]init];
    UIImage *innerImage = [UIImage imageNamed:@"AP_Loading"];
    refreshInnerImageView.image = innerImage;
    refreshInnerImageView.frame = CGRectMake(0, 0, innerImage.size.width* WRATIO * 1, innerImage.size.height* WRATIO * 1);
    self.refreshInnerImageView = refreshInnerImageView;
    [refreshImageView addSubview:refreshInnerImageView];
    
    [self addAnimation:refreshOutwordImageView.layer];
    
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews {
    [super placeSubviews];
    
    self.headRefreshView.bounds = CGRectMake(0, 0, imageW + padding + self.stateLabel.mj_textWith, imageH);
    self.headRefreshView.center = CGPointMake(self.mj_w*0.5, self.mj_h*0.5);
    
    self.refreshImageView.frame = CGRectMake(0, 0,  imageW,  imageW);
    self.stateLabel.frame = CGRectMake(imageW+padding, 0, self.stateLabel.mj_textWith, imageH);

}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.stateLabel.text = @"下拉可以刷新";
//             [self pauseLayer:self.refreshOutwordImageView.layer];
              [self removeAnimation:self.refreshOutwordImageView.layer];
            break;
        case MJRefreshStatePulling:
            self.stateLabel.text = @"松开立即刷新";
             [self removeAnimation:self.refreshOutwordImageView.layer];
            break;
        case MJRefreshStateRefreshing:
            self.stateLabel.text = @"加载中.....";
            [self addAnimation:self.refreshOutwordImageView.layer];
            break;
        default:
            break;
    }
}

- (void)addAnimation:(CALayer *)layer {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.5;
    animation.fromValue = 0;
    animation.toValue = @(M_PI * 2);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.beginTime = CACurrentMediaTime();
    animation.repeatCount = HUGE_VALF;
    layer.speed = 1.0f;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"transformZ"];
}

- (void)removeAnimation:(CALayer *)layer {
    [layer removeAllAnimations];
}

//-(void)pauseLayer:(CALayer*)layer {
//    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
//    layer.speed = 0.0;
//    layer.timeOffset = pausedTime;
//}
//
//-(void)resumeLayer:(CALayer*)layer {
//    CFTimeInterval pausedTime = [layer timeOffset];
//    layer.speed = 1.0;
//    layer.timeOffset = 0.0;
//    layer.beginTime = 0.0;
//    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
//    layer.beginTime = timeSincePause;
//}

@end
