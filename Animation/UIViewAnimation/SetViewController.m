//
//  SetViewController.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/8/31.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

@property (nonatomic,strong) UIImageView *bgView;
 
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    self.title = @"Set动画";
    self.view.backgroundColor = [UIColor whiteColor];

    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgView.frame = CGRectMake(0, 0, 300, 500);
    self.bgView.center = self.view.center;
    [self.view addSubview:self.bgView];
    
    
    NSArray *animationArray = @[@"转场上",@"转场下",@"转场左",@"转场右",@"2D平移",@"2D缩放",@"2D旋转",@"3D平移",@"3D缩放",@"3D旋转",@"还原"];
    
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
        
        [btn setBackgroundColor:[UIColor cyanColor]];
        
        btn.tag = i;
        
        NSInteger row = i / number;
        NSInteger section = i % number;
        
        btn.frame = CGRectMake(edgeWidth + section * (btnWidth + edgeWidth), edgeWidth + row * (btnHeigh + edgeWidth), btnWidth, btnHeigh);
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(setAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)setAnimation:(UIButton *)btn{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
    
    [UIView beginAnimations:@"demo" context:nil];
    [UIView setAnimationDuration:1.0f];
    switch (btn.tag) {
        case 0:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.bgView cache:YES];
            break;
        case 1:
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.bgView cache:YES];
            break;
        case 2:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.bgView cache:YES];
            break;
        case 3:
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.bgView cache:YES];
            break;
        case 4:
            self.bgView.transform = CGAffineTransformIdentity;
            self.bgView.transform = CGAffineTransformMakeTranslation(20, 20);
            break;
        case 5:
            self.bgView.transform = CGAffineTransformIdentity;
            self.bgView.transform = CGAffineTransformMakeScale(0.75, 0.5);
            break;
        case 6:
            self.bgView.transform = CGAffineTransformIdentity;
            self.bgView.transform = CGAffineTransformMakeRotation(M_PI*0.25);
            break;
        case 7:
            self.bgView.layer.transform = CATransform3DIdentity;
            self.bgView.layer.transform = CATransform3DMakeTranslation(10, 15, 20);
            break;
        case 8:
            self.bgView.layer.transform = CATransform3DIdentity;
            self.bgView.layer.transform = CATransform3DMakeScale(0.75, 0.5, 0.25);
            break;
        case 9:
            self.bgView.layer.transform = CATransform3DIdentity;
            self.bgView.layer.transform = CATransform3DMakeRotation(M_PI*0.4, 0.0, 1.0, 0.0);
            break;
        default:
            self.bgView.transform = CGAffineTransformIdentity;
            self.bgView.layer.transform = CATransform3DIdentity;
            break;
    }
    
    [UIView commitAnimations];
    #pragma clang diagnostic pop
}
/* iOS 13废弃
    //设置动画ID
    [UIView beginAnimations:@"demo" context:nil];

    //持续时间
    [UIView setAnimationDuration:2.f];
    //代理
    [UIView setAnimationDelegate:self];

    [UIView setAnimationWillStartSelector:@selector(startAnimation:)];
    [UIView setAnimationDidStopSelector:@selector(stopAnimation:)];

    //延时时长
    [UIView setAnimationDelay:0.5f];

    //重复次数
    [UIView setAnimationRepeatCount:4];

    //开始时间
    [UIView setAnimationStartDate:[NSDate date]];

    //变化曲线
    [UIView setAnimationCurve:curve];

    //是否反向动画
    [UIView setAnimationRepeatAutoreverses:NO];

    //是否从当前状态开始动画
    [UIView setAnimationBeginsFromCurrentState:YES];


    //设置是否使用动画
    [UIView setAnimationsEnabled:YES];

    //设置转场效果
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];

    //结束动画
    [UIView commitAnimations];
 */

@end
