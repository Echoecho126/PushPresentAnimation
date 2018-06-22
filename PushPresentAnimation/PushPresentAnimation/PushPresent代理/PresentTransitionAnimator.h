//
//  PresentTransitionAnimator.h
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PresentTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
    
@property(nonatomic,  assign) BOOL isDismissNow;
    
@end
