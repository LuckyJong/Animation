
#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic,strong) UIImageView *bgView;

@end

@implementation AnimationViewController


/* 接口说明
 
 duration : 动画时长
 delay    : 延迟时间
 options  : 动画选项
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0, // 动画过程中,子视图随着一起动画
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // 动画过程中,允许用户交互
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // 是否从旧动画的当前状态开始新动画
 UIViewAnimationOptionRepeat                    = 1 <<  3, // 无限次数重复动画
 UIViewAnimationOptionAutoreverse               = 1 <<  4, // 是否开启反向动画
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // 忽略嵌套动画中外层动画的时长设置(只适用于嵌套动画)
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // 忽略嵌套动画中外层动画的时间函数设置(只适用于嵌套动画)
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // 视图每一帧都会渲染,在动画过程中可以实时更新视图(只适用于转场动画)
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // 视图切换时直接隐藏旧视图并显示新视图,而不是将旧视图从父视图移除并添加新视图(只适用于转场动画)
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // 不继承动画选择项(只适用于嵌套动画)
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // 默认,淡入淡出,先慢后快再慢
 UIViewAnimationOptionCurveEaseIn               = 1 << 16, // 淡入,先慢后快
 UIViewAnimationOptionCurveEaseOut              = 2 << 16, // 淡出,先快后慢
 UIViewAnimationOptionCurveLinear               = 3 << 16, // 线性
 UIViewAnimationOptionTransitionNone            = 0 << 20, // 默认,无效果
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20, // 从左侧翻转
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20, // 从右侧翻转
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20, // 向后翻页
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20, // 向前翻页
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20, // 旧视图溶解显示新视图
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20, // 从上方翻转
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20, // 从下方翻转
 
 普通动画
 + (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
 
 + (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
 
 + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
 
 
 弹性动画
 + (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
 
 转场动画
 + (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
 
 + (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^ __nullable)(BOOL finished))completion;
 
 多动画
 + (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray<__kindof UIView *> *)views options:(UIViewAnimationOptions)options animations:(void (^ __nullable)(void))parallelAnimations completion:(void (^ __nullable)(BOOL finished))completion;
 
 循环动画
 + (void)modifyAnimationsWithRepeatCount:(CGFloat)count autoreverses:(BOOL)autoreverses animations:(void(NS_NOESCAPE ^)(void))animations;
 
 
 关键帧动画
 options
 UIViewKeyframeAnimationOptionLayoutSubviews            = UIViewAnimationOptionLayoutSubviews, // 动画过程中,子视图随着一起动画
 UIViewKeyframeAnimationOptionAllowUserInteraction      = UIViewAnimationOptionAllowUserInteraction, // 动画过程中,允许用户交互
 UIViewKeyframeAnimationOptionBeginFromCurrentState     = UIViewAnimationOptionBeginFromCurrentState, // 是否从旧动画的当前状态开始新动画
 UIViewKeyframeAnimationOptionRepeat                    = UIViewAnimationOptionRepeat, // 无限次数重复动画
 UIViewKeyframeAnimationOptionAutoreverse               = UIViewAnimationOptionAutoreverse, // 是否开启反向动画
 UIViewKeyframeAnimationOptionOverrideInheritedDuration = UIViewAnimationOptionOverrideInheritedDuration, // 忽略嵌套动画中外层动画的时长设置(只适用于嵌套动画)
 UIViewKeyframeAnimationOptionOverrideInheritedOptions  = UIViewAnimationOptionOverrideInheritedOptions, // 忽略嵌套动画中外层动画的时间函数设置(只适用于嵌套动画)
 
 // 设置两个关键帧之间的动画模式(可理解为补间动画模式)(只可同时设置一项)
 UIViewKeyframeAnimationOptionCalculationModeLinear     = 0 << 10, // 默认,线性运算模式(匀速补间动画)
 UIViewKeyframeAnimationOptionCalculationModeDiscrete   = 1 << 10, // 离散运算模式(无补间动画)
 UIViewKeyframeAnimationOptionCalculationModePaced      = 2 << 10, // 均匀运算模式
 UIViewKeyframeAnimationOptionCalculationModeCubic      = 3 << 10, // 平滑运算模式
 UIViewKeyframeAnimationOptionCalculationModeCubicPaced = 4 << 10  // 平滑均匀运算模式
 
 + (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion;
 
 frameStartTime 帧动画相对开始时间,取值为0~1
 frameDuration  帧动画相对持续时长,取值为0~1
 + (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations;
 */


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    
    self.title = @"Animation动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    self.bgView.frame = CGRectMake(0, 0, 300, 500);
    self.bgView.center = self.view.center;
    [self.view addSubview:self.bgView];
    
    
    NSArray *animationArray = @[@"普通动画",@"弹性动画",@"转场动画1",@"转场动画2",@"多动画",@"帧动画1",@"帧动画2",@"还原"];
    
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
        
        btn.tag = i;
        
        NSInteger row = i / number;
        NSInteger section = i % number;
        
        btn.frame = CGRectMake(edgeWidth + section * (btnWidth + edgeWidth), edgeWidth + row * (btnHeigh + edgeWidth), btnWidth, btnHeigh);
        
        [self.view addSubview:btn];
        
        [btn addTarget:self action:@selector(setAnimation:) forControlEvents:UIControlEventTouchUpInside];
    }

}


- (void)setAnimation:(UIButton *)btn{
    self.bgView.transform = CGAffineTransformIdentity;
    
    switch (btn.tag) {
        case 0:
        {
            self.bgView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:3.0 delay:2.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
                self.bgView.transform = CGAffineTransformMakeScale(2.0, 2.0);
            } completion:^(BOOL finished) {
                self.bgView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case 1:
        {
            self.bgView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:3.0f delay:0.0f usingSpringWithDamping:0.7f initialSpringVelocity:5.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.bgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
                
            } completion:^(BOOL finished) {
                if (finished)
                {
                    self.bgView.transform = CGAffineTransformIdentity;
                }
            }];
        }
            break;
        case 2:
        {
            self.bgView.transform = CGAffineTransformIdentity;
            [UIView transitionWithView:self.view duration:3.0f options:UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionAllowAnimatedContent animations:^{
                self.bgView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            } completion:^(BOOL finished) {
                if (finished)
                {
                    self.bgView.transform = CGAffineTransformIdentity;
                }
            }];
        }
            
            break;
        case 3:
        {
            UIImageView *toImageView = [[UIImageView alloc] init];
            toImageView.frame = self.bgView.frame;
            toImageView.image = [UIImage imageNamed:@"bg2"];
            
            [UIView transitionFromView:self.bgView toView:toImageView duration:3.0f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
                if (finished)
                {
                    NSLog(@"TransitionAnimation finished");
                }
            }];
        }
            break;
        case 4:
        {
            [UIView performSystemAnimation:UISystemAnimationDelete onViews:@[self.bgView] options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 5:
        {
            [UIView animateKeyframesWithDuration:3.0f delay:0.5f options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
                self.bgView.transform = CGAffineTransformScale(self.bgView.transform, 0.5, 0.5);
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        case 6:
        {
            [UIView animateKeyframesWithDuration:3.0f delay:0.5f options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.75 animations:^{
                    self.bgView.transform = CGAffineTransformScale(self.bgView.transform, 0.5, 0.5);
                }];
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
        default:
            
            break;
    }
}

@end


