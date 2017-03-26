//
//  ZWAnimationPresentDelegate.m
//  03转场动画介绍
//
//  Created by 郑亚伟 on 2017/3/14.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ZWAnimationPresentProxy.h"

@implementation ZWAnimationPresentProxy

#pragma mark - UIViewControllerAnimatedTransitioning
//返回转场动画的持续时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}
//编写具体的转场动画代码[呈现的时候]
//说明：只要实现了这个代理方法，必须自己来编写具体的转场代码，系统的转场方式消失。如果不实现此方法，界面无法跳转
//参数transitionContext表示的是转场中包含的信息，所有转场过程中包含的信息都可以从这里面获取
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    /*
     转场设置的思路：
       1、拿到容器视图containerView
       2、拿到目标视图toView
       3、toView添加到containerView上
       4、根据实际需求设置转场动画效果
       5、转场动画结束后必须调用[transitionContext completeTransition:YES];方法*/
    //1、获取容器view
    UIView *containerView = [transitionContext containerView];
    //2、获取目标view
    /*UITransitionContextToViewKey
     UITransitionContextFromViewKey*/
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //3、把目标view添加到容器view中
    [containerView addSubview:toView];
    //4、实现动画
    //4.1 设置初始值
    toView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    //4.2 通过动画的方式旋转到默认位置
    //动画时间直接设置为转场动画的时间，系统默认时间是0.25s
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //5、转场动画结束后必须调用[transitionContext completeTransition:YES];方法。
        //如果不调用该方法，模态进入的界面将无法监听任何事件，界面直接不能进行交互
        [transitionContext completeTransition:YES];
    }];
    
}

@end
