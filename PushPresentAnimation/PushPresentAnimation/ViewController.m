//
//  ViewController.m
//  PushPresentAnimation
//
//  Created by Echo_RSQ on 2018/6/21.
//  Copyright © 2018年 Echo_RSQ. All rights reserved.
//

#import "ViewController.h"
#import "TaskPresentDelegate.h"
#import "PrensentVC.h"

#import "PushAnimationDelegate.h"
#import "PushVC.h"

@interface ViewController ()
@property(nonatomic,strong) TaskPresentDelegate   *presentDelegate;//使用weak，会导致iOS8.3崩溃
@property(nonatomic,strong) PushAnimationDelegate *pushDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self addAllUI];
}

-(void)addAllUI{
    
    UIButton *pushBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pushBtn];
    pushBtn.frame =CGRectMake(100, 100, 100, 100);
    pushBtn.backgroundColor =[UIColor redColor];
    [pushBtn setTitle:@"pushLeft" forState:UIControlStateNormal];
    
    UIButton *pushBtn1 =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:pushBtn1];
    pushBtn1.frame =CGRectMake(200, 100, 100, 100);
    pushBtn1.backgroundColor =[UIColor greenColor];
    [pushBtn1 setTitle:@"pushRight" forState:UIControlStateNormal];
    
    UIButton *presentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:presentBtn];
    presentBtn.frame =CGRectMake(100, 200, 100, 100);
    presentBtn.backgroundColor =[UIColor greenColor];
    [presentBtn setTitle:@"present" forState:UIControlStateNormal];
    
    [pushBtn addTarget:self action:@selector(pushBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [pushBtn1 addTarget:self action:@selector(pushBtn1Click) forControlEvents:UIControlEventTouchUpInside];
    [presentBtn addTarget:self action:@selector(presentBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)pushBtnClick{
    
    PushVC *vc = [[PushVC alloc]init];
    PushAnimationDelegate *pushDelegate =[PushAnimationDelegate new];
    pushDelegate.isClickLeft = YES;
    self.pushDelegate =pushDelegate;
    self.navigationController.delegate =pushDelegate;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pushBtn1Click{
    
    PushVC *vc = [[PushVC alloc]init];
    PushAnimationDelegate *pushDelegate =[PushAnimationDelegate new];
    pushDelegate.isClickRight = YES;
    self.pushDelegate =pushDelegate;
    self.navigationController.delegate =pushDelegate;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)presentBtnClick{
    
    PrensentVC *vc =[[PrensentVC alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    TaskPresentDelegate *presentDelegate =[[TaskPresentDelegate alloc]init];
    presentDelegate.isTaskPresent =YES;
    self.presentDelegate =presentDelegate;
    navi.transitioningDelegate = presentDelegate;
    [self presentViewController:navi animated:YES completion:nil];
}

@end
