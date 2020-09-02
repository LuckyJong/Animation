//
//  DropitViewController.m
//  Dropit
//
//  Created by houzq on 17/7/14.
//  Copyright (c) 2014 iOSLearning. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"
@interface DropitViewController ()<UIDynamicAnimatorDelegate>

@property (strong, nonatomic) BezierPathView *gameView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) DropitBehavior *dropitBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property (strong, nonatomic) UIView *droppingView;

@end

@implementation DropitViewController

static const CGSize DROP_SIZE = { 40, 40 };

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.gameView = [[BezierPathView alloc] init];
    self.gameView.frame = self.view.frame;
    [self.view addSubview:self.gameView];
    
    [self.gameView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDidExecute:)]];
}

- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompletedRows];
}

- (BOOL)removeCompletedRows
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    
    for (CGFloat y = self.gameView.bounds.size.height-DROP_SIZE.height/2; y > 0; y -= DROP_SIZE.height)
    {
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for (CGFloat x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width-DROP_SIZE.width/2; x += DROP_SIZE.width)
        {
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if ([hitView superview] == self.gameView) {
                [dropsFound addObject:hitView];
            } else {
                rowIsComplete = NO;
                break;
            }
        }
        if (![dropsFound count]) break;
        if (rowIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
    }
    
    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
        return YES;
    }
    
    return NO;
}

- (void)animateRemovingDrops:(NSArray *)dropsToRemove
{
    [UIView animateWithDuration:1.0 animations:^{
        for (UIView *drop in dropsToRemove) {
            int x = (arc4random()%(int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
            int y = self.gameView.bounds.size.height;
            drop.center = CGPointMake(x, -y);
        }
    }completion:^(BOOL finished) {
        [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}

-(DropitBehavior *)dropitBehavior
{
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}


//随机生成方块的颜色
- (UIColor *)randomColor
{
    switch (arc4random()%5) {
        case 0: return [UIColor blueColor];
        case 1: return [UIColor grayColor];
        case 2: return [UIColor yellowColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor greenColor];
    }
    return [UIColor blackColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self drop];
}

- (void)panDidExecute:(UIPanGestureRecognizer *)gesture
{
    CGPoint gesturePoint = [gesture locationInView:self.gameView];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self attachDroppingViewToPoint:gesturePoint];
    } else if (gesture.state == UIGestureRecognizerStateChanged){
        self.attachmentBehavior.anchorPoint = gesturePoint;
    } else if (gesture.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attachmentBehavior];
        //手势结束后把连接线段清除
        self.gameView.path = nil;
    }
}

//
- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    if (self.droppingView) {
        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView attachedToAnchor:anchorPoint];
        UIView *droppingView = self.droppingView;
        __weak DropitViewController *weakSelf = self;
        
        self.attachmentBehavior.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachmentBehavior.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        
        self.droppingView = nil;
        [self.animator addBehavior:self.attachmentBehavior];
    }
}
//方块掉落的动画效果
- (void)drop{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    self.droppingView = dropView;
    [self.dropitBehavior addItem:dropView];
}

@end

