//
//  DropitBehavior.m
//  Dropit
//
//  Created by houzq on 17/7/14.
//  Copyright (c) 2014 iOSLearning. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior()
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;
@property (strong, nonatomic) UIDynamicItemBehavior *animationOption;

@end

@implementation DropitBehavior


//UIDynamicBehavior的一种：重力行为
- (UIGravityBehavior *)gravityBehavior{
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        _gravityBehavior.magnitude = 5;
    }
    return _gravityBehavior;
}

//碰撞行为
- (UICollisionBehavior *)collisionBehavior{
    if (!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        //使用UIDynamicAnimator的ReferenceView作为边界
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collisionBehavior;
}

- (UIDynamicItemBehavior *)animationOption
{
    if (!_animationOption) {
        _animationOption = [[UIDynamicItemBehavior alloc] init];
        _animationOption.allowsRotation = NO;
    }
    return _animationOption;
}

- (void)addItem:(id<UIDynamicItem>)item;
{
    [self.gravityBehavior addItem:item];
    [self.collisionBehavior addItem:item];
    [self.animationOption addItem:item];
}
- (void)removeItem:(id<UIDynamicItem>)item;
{
    [self.gravityBehavior removeItem:item];
    [self.collisionBehavior removeItem:item];
    [self.animationOption removeItem:item];
}
- (instancetype)init
{
    self = [super init];
    [self addChildBehavior:self.gravityBehavior];
    [self addChildBehavior:self.collisionBehavior];
    [self addChildBehavior:self.animationOption];
    return self;
}

@end

