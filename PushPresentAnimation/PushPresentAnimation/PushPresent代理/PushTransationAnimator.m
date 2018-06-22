//
//  PushTransationAnimator.m
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import "PushTransationAnimator.h"
#define  AnimationTime 2

@interface PushTransationAnimator()
@property (nonatomic, weak) UIView *backBlueView;

@end

@implementation PushTransationAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return AnimationTime;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView;
    UIView *toView;
   
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        // iOS8以上用此方法准确获取
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }
    else {
        fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
        toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    }

    UIView *containerView = [transitionContext containerView];
    UIView *backBlueViewTo =[[UIView alloc]init];
    self.backBlueView =backBlueViewTo;
    
    CGFloat top  =100;
    CGFloat btnW =100;
    CGFloat btnH =100;
    CGFloat left = ScreenW * 0.5- btnW;
    CGPoint endCenter  =CGPointZero;
    CGPoint fromCenter =CGPointZero;
    CGAffineTransform fromTransform = CGAffineTransformIdentity;
    CGAffineTransform endTransform  = CGAffineTransformIdentity;
    
    UIView *animationView =[[UIView alloc]init];
    if (self.isClickNote || self.isClickCloud){
        backBlueViewTo.backgroundColor = [UIColor blueColor];
        [containerView addSubview:toView];
        [containerView bringSubviewToFront:toView];
        animationView =toView;
        
        if (self.isClickNote) {
            backBlueViewTo.frame =CGRectMake(left, top, btnW, btnH);
        }
        if (self.isClickCloud) {
            backBlueViewTo.frame =CGRectMake(ScreenW -left - btnW, top, btnW, btnH);
        }
        [toView addSubview:backBlueViewTo];
        fromCenter = backBlueViewTo.center;
        backBlueViewTo.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        endCenter=CGPointMake(ScreenW * 0.5, ScreenH * 0.5);
        CGFloat scaleX = btnW/ScreenW;
        CGFloat scaleY = btnH/ScreenH;
        fromTransform  = CGAffineTransformMakeScale(scaleX, scaleY);
       
    }else if (self.isPopCloud || self.isPopNote){
        [containerView addSubview:toView];
        [containerView addSubview:fromView];
       
        if (self.isPopNote) {
            backBlueViewTo.frame =CGRectMake(left, top, btnW, btnH);
        }
        if (self.isPopCloud) {
            backBlueViewTo.frame =CGRectMake(ScreenW -left - btnW, top, btnW, btnH);
        }
        animationView = fromView;
        endCenter = backBlueViewTo.center;
        backBlueViewTo.frame =CGRectMake(0, 0, ScreenW, ScreenH);
        fromCenter  =CGPointMake(ScreenW *0.5, ScreenH *0.5);
        fromTransform = CGAffineTransformIdentity;
        CGFloat scaleX = btnW/ScreenW;
        CGFloat scaleY = btnH/ScreenH;
        endTransform = CGAffineTransformMakeScale(scaleX, scaleY);
    }
    
    //透明度
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anima.fromValue = [NSNumber numberWithFloat:1.0f];
    anima.toValue   = [NSNumber numberWithFloat:0.0f];
    anima.duration  = AnimationTime;
    anima.beginTime = CACurrentMediaTime() + 0.3;
    anima.timingFunction =[CAMediaTimingFunction functionWithControlPoints:0 :0.78 :1 :1];
    anima.removedOnCompletion = NO;
    anima.fillMode=kCAFillModeForwards;
    anima.delegate =self;
    [backBlueViewTo.layer addAnimation:anima forKey:@"opacityAniamtion"];
    
    animationView.center    = fromCenter;
    animationView.transform = fromTransform;
    
    [UIView animateWithDuration:AnimationTime animations:^{
        animationView.center    =endCenter;
        animationView.transform =endTransform;
        
    } completion:^(BOOL finished) {
        
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    self.backBlueView.hidden =YES;
    [self.backBlueView removeFromSuperview];
    self.backBlueView =nil;
}


@end
