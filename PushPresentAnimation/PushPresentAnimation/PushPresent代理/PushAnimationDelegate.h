//
//  PushAnimationDelegate.h
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushAnimationDelegate : NSObject<UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL isClickLeft;
@property (nonatomic, assign) BOOL isClickRight;

@end
