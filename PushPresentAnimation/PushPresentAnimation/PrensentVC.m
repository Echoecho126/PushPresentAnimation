//
//  PrensentVC.m
//  PushPresentAnimation
//
//  Created by Echo_RSQ on 2018/6/22.
//  Copyright © 2018年 Echo_RSQ. All rights reserved.
//

#import "PrensentVC.h"

@interface PrensentVC ()

@end

@implementation PrensentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title =@"Present动画";
    
    UIBarButtonItem *closeItem =[[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeVC)];
    self.navigationItem.leftBarButtonItem =closeItem;
    
    UIView *redView =[[UIView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    [self.view addSubview:redView];
    redView.backgroundColor =[UIColor redColor];
}

-(void)closeVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
