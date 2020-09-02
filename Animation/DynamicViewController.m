//
//  DynamicViewController.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/2.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "DynamicViewController.h"

@interface DynamicViewController ()


@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (nonatomic,strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic,strong) UICollisionBehavior *collider;


@property (nonatomic,strong) UIView *redBoxView;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.title = @"Dynamic动画";

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
    
    
    NSArray *animationArray = @[@"重力行为",@"碰撞行为",@"附着行为",@"推动行为",@"动力行为",@"捕获行为"];
    
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
        
        btn.frame = CGRectMake(edgeWidth + section * (btnWidth + edgeWidth),50+ edgeWidth + row * (btnHeigh + edgeWidth), btnWidth, btnHeigh);
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(setAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.redBoxView]];
    self.collider = [[UICollisionBehavior alloc] initWithItems:@[self.redBoxView]];
}

- (UIView *)redBoxView{
    if (!_redBoxView) {
        _redBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.view addSubview:_redBoxView];
        _redBoxView.backgroundColor = [UIColor redColor];
        _redBoxView.center = self.view.center;
    }
    return _redBoxView;
}

/*
 UIGravityBehavior     重力行为
 UICollisionBehavior   碰撞行为
 UIAttachmentBehavior  附着行为
 UIPushBehavior        推动行为
 UIDynamicItemBehavior 动力行为
 UISnapBehavior        捕获行为
 */


- (void)setAnimation:(UIButton *)btn{

    switch (btn.tag) {
        case 0:
        {
            self.gravityBehavior.gravityDirection = CGVectorMake(0, 1);
            self.gravityBehavior.magnitude = 2.5;
            [self.animator addBehavior:self.gravityBehavior];
        }
            break;
        case 1:
        {
            self.collider.translatesReferenceBoundsIntoBoundary = YES;
            [self.animator addBehavior:self.collider];
        }
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        case 5:
            
            break;

        default:
            break;
    }
}

@end
