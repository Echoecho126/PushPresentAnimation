//
//  PushTransationAnimator.h
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/15.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PushTransationAnimator : NSObject <UIViewControllerAnimatedTransitioning,CAAnimationDelegate>
@property (nonatomic, assign) BOOL isClickNote;//点击笔记
@property (nonatomic, assign) BOOL isClickCloud;//点击云盘
@property (nonatomic, assign) BOOL isPopNote;//笔记列表返回到工作界面
@property (nonatomic, assign) BOOL isPopCloud;//云盘列表返回到工作界面

@end
