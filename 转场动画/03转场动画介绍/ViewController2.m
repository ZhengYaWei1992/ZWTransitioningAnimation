//
//  ViewController2.m
//  03转场动画介绍
//
//  Created by 郑亚伟 on 2017/3/14.
//  Copyright © 2017年 zhengyawei. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
//控制器的view的创建是通过调用loadView的方法创建的。
//为了保证先设置anchorPoint，再设置frame，所以要在系统的loadView方法中，手动创建控制器的view
/*
 关于坐标设置：
 设置一个控件的位置，最好使用UIView的center属性，或者是CALayer的position属性（位置）。设置控件的大小，最好使用UIView的bounds属性。因为frame这个属性是根据控件的center、bounds、transform最终计算出来的，如果先是设置了frame，之后改变这些属性之一就会改变控件的位置。
 */
- (void)loadView{
    //要调用此方法，不调用也无法触控
    [super loadView];
    //手动创建控制器的view
    self.view = [[UIView alloc]init];
    self.view.backgroundColor = [UIColor blueColor];
    self.view.layer.anchorPoint = CGPointMake(0.5, 2.0);
    self.view.frame = [UIScreen mainScreen].bounds;
    //控制器view添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    /*
     struct CGAffineTransform {
     CGFloat a, b, c, d;
     CGFloat tx, ty;
     };*/
    //CGAffineTransform
    //CGAffineTransformMake(<#CGFloat a#>, <#CGFloat b#>, <#CGFloat c#>, <#CGFloat d#>, <#CGFloat tx#>, <#CGFloat ty#>)
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //根据transform的b值来判断旋转的情况，只要b值大于0.16，就让蓝色view掉下来
        if (ABS(self.view.transform.b) > 0.16 ) {
            [UIView animateWithDuration:0.25 animations:^{
                //dismiss控制器
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }else{
        CGFloat offsetX = [pan translationInView:self.view].x;
        CGFloat percent = offsetX / self.view.bounds.size.width;
        CGFloat radians = M_PI_4 * percent ;
        self.view.transform = CGAffineTransformMakeRotation(radians);
    }
}



//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
