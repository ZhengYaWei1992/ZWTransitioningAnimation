//
//  ZWAnimationDismissDelegate.m
//  03转场动画介绍
//
//  Created by 郑亚伟 on 2017/3/14.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWAnimationDismissProxy.h"

@implementation ZWAnimationDismissProxy

#pragma mark - UIViewControllerAnimatedTransitioning
//返回转场动画的持续时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

//编写具体的转场动画代码[消失的时候]
//说明：只要实现了这个代理方法，必须自己来编写具体的转场代码，系统的转场方式消失。如果不实现此方法，界面无法跳转
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //1、获取这个转场动画的fromView
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    //2、执行动画
    //动画时间直接设置为转场动画的时间，系统默认时间是0.25s
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
         //判断view的旋转角度
        if (fromView.transform.b > 0) {
            fromView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }else{
            fromView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        }
    } completion:^(BOOL finished) {
        //3、转场动画结束后必须调用[transitionContext completeTransition:YES];方法。
        //如果不调用该方法，dismiss的界面将无法监听任何事件，界面直接不能进行交互
        [transitionContext completeTransition:YES];
    }];
}

@end
