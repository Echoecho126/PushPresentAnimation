//
//  TaskPresentDelegate.h
//  RSQ
//
//  Created by Echo_RSQ on 2017/11/14.
//  Copyright © 2017年 rishiqing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TaskPresentDelegate : NSObject<UIViewControllerTransitioningDelegate>
@property(nonatomic,  assign) BOOL isTaskPresent;//日程创建

@end
