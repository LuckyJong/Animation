//
//  RootViewController.m
//  Animation
//
//  Created by ShuYu Zeng on 2020/9/1.
//  Copyright © 2020 luckyjong. All rights reserved.
//

#import "RootViewController.h"

#import "SetViewController.h"
#import "AnimationViewController.h"

#import "CATransitionViewController.h"
#import "CAViewController.h"


#import "DynamicViewController.h"
#import "DropitViewController.h"


@interface RootViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation RootViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray arrayWithCapacity:0];
    
    [self.dataSource addObject:[[UINavigationController alloc] initWithRootViewController:[SetViewController new]]];
    [self.dataSource addObject:[[UINavigationController alloc] initWithRootViewController:[AnimationViewController new]]];
    
    [self.dataSource addObject:[CATransitionViewController new]];
    [self.dataSource addObject:[[UINavigationController alloc] initWithRootViewController:[CAViewController new]]];
    
    
    [self.dataSource addObject:[[UINavigationController alloc] initWithRootViewController:[DynamicViewController new]]];
    
    [self.dataSource addObject:[DropitViewController new]];
    
    
    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    UIViewController *vc = [self.dataSource lastObject];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}


- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == 0 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index--;
    
    return [self.dataSource objectAtIndex:index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger index = [self.dataSource indexOfObject:viewController];
    
    if (index == self.dataSource.count - 1 || (index == NSNotFound)) {
        
        return nil;
    }
    
    index++;
    
    return [self.dataSource objectAtIndex:index];
}


@end
