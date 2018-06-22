//
//  PushAnimationDelegate.m
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import "PushAnimationDelegate.h"
#import "PushTransationAnimator.h"

@implementation PushAnimationDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    //operation 判断是push还是pop
    if (operation == UINavigationControllerOperationPush){
        if ([fromVC isKindOfClass:NSClassFromString(@"ViewController")]) {
            if(self.isClickLeft || self.isClickRight){
                
                PushTransationAnimator *animator = [PushTransationAnimator new];
                animator.isClickNote =self.isClickLeft;
                animator.isClickCloud=self.isClickRight;
                
                return animator;
            }
        }
    }else if (operation == UINavigationControllerOperationPop){
        if ([fromVC isKindOfClass:NSClassFromString(@"PushVC")]) {

            PushTransationAnimator *animator = [PushTransationAnimator new];
            animator.isPopNote =self.isClickLeft;
            animator.isPopCloud=self.isClickRight;
            return animator;
        }
    }
    
    return nil;
}

    

@end
