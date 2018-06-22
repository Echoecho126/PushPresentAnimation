//
//  TaskPresentDelegate.m
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/14.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import "TaskPresentDelegate.h"
#import "PresentTransitionAnimator.h"

@implementation TaskPresentDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    if (self.isTaskPresent) {
        PresentTransitionAnimator *animator = [[PresentTransitionAnimator alloc] init];
        return animator;
    }
    
    return nil;
}

    
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    PresentTransitionAnimator *animator = [[PresentTransitionAnimator alloc] init];
    animator.isDismissNow =YES;
    return  animator;
}

@end
