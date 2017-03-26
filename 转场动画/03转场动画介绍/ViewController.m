//
//  ViewController.m
//  03转场动画介绍
//
//  Created by 郑亚伟 on 2017/3/14.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "ZWAnimationPresentProxy.h"
#import "ZWAnimationDismissProxy.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.frame = CGRectMake(50, 100 , self.view.frame.size.width - 100, 40);
    [btn setTitle:@"模态进入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnClick:(UIButton *)sender  {
    ViewController2 *vc = [[ViewController2 alloc]init];
    //设置自定义转场
    vc.modalPresentationStyle = UIModalPresentationCustom;
    //注意不是modalTransitionStyle而是modalPresentationStyle，如果这里写错了，则模态到下一界面的时候，上一界面的背景不在显示
    //vc.modalTransitionStyle = UIModalPresentationCustom;
    //设置代理自定义转场
    vc.transitioningDelegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
//控制器A----B的转场动画
//方法的返回值表示当View呈现的时候要通过那个对象来执行动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //在此方法中要返回一个对象，该对象要遵守<UIViewControllerAnimatedTransitioning>协议，在该对象对应的类中实现代理方法
    ZWAnimationPresentProxy *presentProxy = [[ZWAnimationPresentProxy alloc]init];
    
    return presentProxy;
}


////控制器B----A的转场动画
////控制器在dismiss的时候通过那个对象来执行转场动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //在此方法中要返回一个对象，该对象要遵守<UIViewControllerAnimatedTransitioning>协议，在该对象对应的类中实现代理方法
    ZWAnimationDismissProxy *dismissProxy = [[ZWAnimationDismissProxy alloc]init];
    
    return dismissProxy;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

@end
