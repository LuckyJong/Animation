//
//  DropitBehavior.h
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/2.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DropitBehavior : UIDynamicBehavior

- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;

@end

NS_ASSUME_NONNULL_END
