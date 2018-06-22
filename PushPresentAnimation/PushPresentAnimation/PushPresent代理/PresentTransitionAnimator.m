//
//  PresentTransitionAnimator.m
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import "PresentTransitionAnimator.h"

@interface PresentTransitionAnimator()<CAAnimationDelegate>
{
    id<UIViewControllerContextTransitioning> myTransitionContext;
}

@property (weak, nonatomic) UIView *backBlueView;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGRect  originFrame;

@end

@implementation PresentTransitionAnimator

- (instancetype)init {
    if (self = [super init]) {
        
        self.duration = 2.0;
        //初始按钮的位置，可自行更改成自己需要的位置
        self.originFrame =  CGRectMake(ScreenW*0.5, ScreenH, 50, 50);
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isDismissNow) {
        return  0.5;
    }
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
         // iOS8以上用此方法准确获取
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else{
        fromView = fromViewController.view;
        toView   = toViewController.view;
    }
    
    [containerView addSubview:fromView];
    [containerView addSubview:toView];
    if (self.isDismissNow) {
        [containerView bringSubviewToFront:fromView];
    }else{
        [containerView bringSubviewToFront:toView];
    }
    
    //present和dismiss的动画都在这里写
    if (!self.isDismissNow){
        
        myTransitionContext =transitionContext;
        UIView *backBlueView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,ScreenW, ScreenH)];
        backBlueView.backgroundColor = [UIColor blueColor];
        [toView addSubview:backBlueView];
        self.backBlueView = backBlueView;
        //透明度
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anima.fromValue= [NSNumber numberWithFloat:1.0f];
        anima.toValue  = [NSNumber numberWithFloat:0.0f];
        anima.duration = self.duration;
        anima.beginTime =CACurrentMediaTime();
        anima.timingFunction =[CAMediaTimingFunction functionWithControlPoints:0 :0.78 :1 :1];
        anima.removedOnCompletion = NO;
        anima.fillMode=kCAFillModeForwards;
        [backBlueView.layer addAnimation:anima forKey:@"opacityAniamtion"];
        
        //算半径
        UIBezierPath *originPath = [UIBezierPath bezierPathWithOvalInRect:self.originFrame];
        float radius = sqrtf (ScreenH * ScreenH + ScreenW * ScreenW);//按照最大半径算，否则横竖屏旋转时可能出现半径空白
        radius =1.05 * radius;
        UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.originFrame, -radius, - radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.path = finalPath.CGPath;
        toView.layer.mask = maskLayer;
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id _Nullable)(originPath.CGPath);
        animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
        animation.duration = self.duration;
        animation.delegate = self;
        animation.timingFunction =[CAMediaTimingFunction functionWithControlPoints:0 :0 :0.51 :1];
        [maskLayer addAnimation:animation forKey:@"pathRadius"];
        
    }else{
        
        CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
        CGRect toFrame   = [transitionContext finalFrameForViewController:toViewController];
        fromView.frame = fromFrame;
        toView.frame   = toFrame;
        
        [UIView animateWithDuration:0.5 animations:^{
            fromView.frame = CGRectOffset(fromFrame, 0, fromFrame.size.height);
        }completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //present动画结束。移除backBlueView。
    [myTransitionContext completeTransition:![myTransitionContext transitionWasCancelled]];
    self.backBlueView.hidden =YES;
    [self.backBlueView removeFromSuperview];
    self.backBlueView =nil;
}
@end
