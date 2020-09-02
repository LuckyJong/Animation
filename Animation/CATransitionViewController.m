//
//  CoreViewController.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/2.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "CATransitionViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface CATransitionViewController()

@end

@implementation CATransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    
    NSArray *animationArray = @[@"淡化",@"Push",@"揭开",@"覆盖",@"3D立方",@"吮吸",@"翻转",@"波纹",
    @"翻页",@"反翻页",@"开镜头",@"关镜头",@"下翻页",@"上翻页",@"左翻转",@"右翻转"];
    
    int number = 4;
    CGFloat edgeWidth = 15;
    CGFloat btnWidth = (self.view.bounds.size.width - edgeWidth * (number + 1))/number;
    CGFloat btnHeigh = 35;
    
    for(NSInteger i = 0; i < animationArray.count ; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:animationArray[i] forState:UIControlStateNormal];
        [btn setTitle:animationArray[i] forState:UIControlStateHighlighted];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setBackgroundColor:[UIColor redColor]];
        
        btn.tag = i + 1;
        
        NSInteger row = i / number;
        NSInteger section = i % number;
        
        btn.frame = CGRectMake(edgeWidth + section * (btnWidth + edgeWidth),50+ edgeWidth + row * (btnHeigh + edgeWidth), btnWidth, btnHeigh);
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(setAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
}

typedef enum : NSUInteger {
    Fade = 1,                   //淡入淡出
    Push,                       //推挤
    Reveal,                     //揭开
    MoveIn,                     //覆盖
    Cube,                       //立方体
    SuckEffect,                 //吮吸
    OglFlip,                    //翻转
    RippleEffect,               //波纹
    PageCurl,                   //翻页
    PageUnCurl,                 //反翻页
    CameraIrisHollowOpen,       //开镜头
    CameraIrisHollowClose,      //关镜头
    CurlDown,                   //下翻页
    CurlUp,                     //上翻页
    FlipFromLeft,               //左翻转
    FlipFromRight,              //右翻转
    
} AnimationType;


- (void)setAnimation:(UIButton *)btn{
    
    // 决定动画加载的方向
    NSString *subtypeString = kCATransitionFromTop;
    
    switch (btn.tag) {
        case Fade:
            [self transitionWithType:kCATransitionFade WithSubtype:subtypeString ForView:self.view];
            break;
        
        case Push:
            [self transitionWithType:kCATransitionPush WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Reveal:
            [self transitionWithType:kCATransitionReveal WithSubtype:subtypeString ForView:self.view];
            break;
            
        case MoveIn:
            [self transitionWithType:kCATransitionMoveIn WithSubtype:subtypeString ForView:self.view];
            break;
            
        case Cube:
            [self transitionWithType:@"cube" WithSubtype:subtypeString ForView:self.view];
            break;
        
        case SuckEffect:
            [self transitionWithType:@"suckEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case OglFlip:
            [self transitionWithType:@"oglFlip" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case RippleEffect:
            [self transitionWithType:@"rippleEffect" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageCurl:
            [self transitionWithType:@"pageCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case PageUnCurl:
            [self transitionWithType:@"pageUnCurl" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowOpen:
            [self transitionWithType:@"cameraIrisHollowOpen" WithSubtype:subtypeString ForView:self.view];
            break;
            
        case CameraIrisHollowClose:
            [self transitionWithType:@"cameraIrisHollowClose" WithSubtype:subtypeString ForView:self.view];
            break;
        
        case CurlDown:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlDown];
            break;
        
        case CurlUp:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionCurlUp];
            break;
            
        case FlipFromLeft:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromLeft];
            break;
            
        case FlipFromRight:
            [self animationWithView:self.view WithAnimationTransition:UIViewAnimationTransitionFlipFromRight];
            break;

        default:
            break;
    }
    
    static BOOL isSingle = NO;
    if (isSingle) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    }else{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]];
    }
    isSingle = !isSingle;
}

#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView: (UIView *) view{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 1.0;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    
    //设置运动速度
    /*
    timingFunction : 动画的运动轨迹，用于变化起点和终点之间的插值计算,形象点说它决定了动画运行的节奏,比如是均匀变化(相同时间变化量相同)还是先快后慢,先慢后快还是先慢再快再慢.
    *  动画的开始与结束的快慢,有五个预置分别为(下同):
        *  kCAMediaTimingFunctionLinear            线性,即匀速
        *  kCAMediaTimingFunctionEaseIn            先慢后快
        *  kCAMediaTimingFunctionEaseOut           先快后慢
        *  kCAMediaTimingFunctionEaseInEaseOut     先慢后快再慢
        *  kCAMediaTimingFunctionDefault           实际效果是动画中间比较快.
    */
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)animationWithView:(UIView *)view WithAnimationTransition:(UIViewAnimationTransition) transition
{
    [UIView animateWithDuration:1.0 animations:^{
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
        
        #pragma clang diagnostic pop
    }];
}



@end
