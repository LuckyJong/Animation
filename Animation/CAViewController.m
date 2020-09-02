//
//  CAViewController.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/2.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "CAViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface CAViewController ()<CAAnimationDelegate>

@property (nonatomic,strong) UIImageView *bgView;

@end

@implementation CAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.title = @"QuartzCore动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgView.frame = self.view.frame;
    self.bgView.center = self.view.center;
    self.bgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.bgView];
    
    
    NSArray *animationArray = @[@"BasicAnimation",@"KeyframeAnimation",@"AnimationGroup"];
    
    int number = 3;
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
        
        btn.tag = i;
        
        NSInteger row = i / number;
        NSInteger section = i % number;
        
        btn.frame = CGRectMake(edgeWidth + section * (btnWidth + edgeWidth), edgeWidth + row * (btnHeigh + edgeWidth), btnWidth, btnHeigh);
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(setAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setAnimation:(UIButton *)btn{
    
    switch (btn.tag) {
        case 0:
        {
//KeyPath参考https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html
            CABasicAnimation *postionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
            postionAnimation.duration = 1.0f;
            postionAnimation.fromValue = @(self.bgView.center.y);
            postionAnimation.toValue = @(self.bgView.center.y + 100);
            postionAnimation.removedOnCompletion = NO;
            postionAnimation.delegate = self;
            postionAnimation.autoreverses = YES;//是否还原
            postionAnimation.fillMode = kCAFillModeForwards;
            postionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            [self.bgView.layer addAnimation:postionAnimation forKey:@"posstionAnimation"];
        }
            break;
        case 1:
        {
            CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            keyAnimation.duration = 1.0f;
            keyAnimation.beginTime = CACurrentMediaTime();
            CATransform3D transform1 = CATransform3DMakeScale(1.5, 1.5, 0);
            CATransform3D transform2 = CATransform3DMakeScale(0.5, 0.5, 0);
            CATransform3D transform3 = CATransform3DMakeScale(1, 1, 0);
            keyAnimation.values = @[[NSValue valueWithCATransform3D:transform1],
                                    [NSValue valueWithCATransform3D:transform2],
                                    [NSValue valueWithCATransform3D:transform3]];
            
            keyAnimation.keyTimes = @[@0,@0.5,@1];
            
            keyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            keyAnimation.removedOnCompletion = NO;
            keyAnimation.fillMode = kCAFillModeForwards;
            [self.bgView.layer addAnimation:keyAnimation forKey:nil];

        }
            break;
        case 2:
        {
            CABasicAnimation *rotationYAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            rotationYAnimation.fromValue = @0;
            rotationYAnimation.toValue = @(M_PI*2);
            rotationYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            CABasicAnimation *postionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
            postionAnimation.fromValue = @(self.bgView.center.y);
            postionAnimation.toValue = @(self.bgView.center.y - 100);
            postionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
            animationGroup.duration = 1.0;
            animationGroup.removedOnCompletion = NO;
            animationGroup.fillMode = kCAFillModeForwards;
            animationGroup.delegate = self;
            animationGroup.animations = @[rotationYAnimation, postionAnimation];
            
            [self.bgView.layer addAnimation:animationGroup forKey:@"jumpDown"];

        }
            break;
        default:
            break;
    }
    
}


@end
