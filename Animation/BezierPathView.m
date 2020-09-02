//
//  BezierPathView.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/2.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "BezierPathView.h"

@implementation BezierPathView

- (void)setPath:(UIBezierPath *)path{
    _path = path;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

    [self.path stroke];
}

@end
