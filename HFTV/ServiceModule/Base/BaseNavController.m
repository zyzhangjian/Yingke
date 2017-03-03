//
//  BaseNavController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "BaseNavController.h"

#import "LiveRoomDetailViewController.h"

#import "ViewControllerTwo.h"

#import "BaseTabBarController.h"

#import "LiveRoomViewController.h"

@interface BaseNavController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseNavController

/**
 *  @brief 当第一次使用这个类的时候会调用一次
 */
+(void)initialize{
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [bar setBarTintColor:UIColorFromRGB(0x00dac9)];
    
    bar.titleTextAttributes = @{NSForegroundColorAttributeName: RGB(255, 255, 255),
                                NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    
    //设置左右item的样式
    //    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:XCRGBColor(255, 255, 255),
    //                                   NSFontAttributeName:[UIFont boldSystemFontOfSize:14]
    //                                   } forState:(UIControlStateNormal)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    
}

//- (BOOL)shouldAutorotate
//{
//    NSLog(@"%@",NSStringFromClass([self.topViewController class]));
//    
//    if ([self.topViewController isKindOfClass:[LiveRoomViewController class]]) {
//        
//        return [self.topViewController shouldAutorotate];
//    }
//    
//    return NO;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    if ([self.topViewController isKindOfClass:[LiveRoomViewController class]]) {
//        return [self.topViewController supportedInterfaceOrientations];
//    } else {
//        return UIInterfaceOrientationMaskPortrait; // LiveRoomViewController所支持旋转交给改控制器自己处理，其他控制器则只支持竖屏
//    }
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    NSLog(@"%s",__func__);
//    return  UIInterfaceOrientationPortrait;
//}



- (BOOL)shouldAutorotate
{
    if ([self.topViewController isKindOfClass:[LiveRoomViewController class]]) {

        return [self.topViewController shouldAutorotate];
    }
    return NO; // RotateAblePushController自动旋转交给改控制器自己控制，其他控制器则不支撑自动旋转
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //    NSLog(@"%@",NSStringFromClass([self.topViewController class]));
    //    NSLog(@"%lu",(unsigned long)self.viewControllers.count);
    if ([self.topViewController isKindOfClass:[LiveRoomViewController class]]) {
        return [self.topViewController supportedInterfaceOrientations];
    } else {
        return UIInterfaceOrientationMaskPortrait; // RotateAblePushController所支持旋转交给改控制器自己处理，其他控制器则只支持竖屏
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    
    return  UIInterfaceOrientationPortrait;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    UIViewController *vc =  self.topViewController;
//    if([vc isKindOfClass:[LiveRoomDetailViewController class]]){//要横屏的界面
//        return (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
//    }
//    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//- (BOOL)shouldAutorotate
//
//{
//    UIViewController *vc =  self.topViewController;
////    NSLog(@"%@",NSStringFromClass([self.topViewController class]));
//    NSLog(@"%d",self.viewControllers.count);
//    if([vc isKindOfClass:[LiveRoomDetailViewController class]]){//要横屏的界面
//        return YES;
//    }
//    //横屏的上一个界面，要返回为YES,否则横屏返回的时候上一界面不能还原成竖屏
//    if([vc isKindOfClass:[WMPageController class]]){
//        return YES;
//    }
//    
//    
//    return NO;
//}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setImage:[UIImage imageNamed:@"arrow_back"] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"arrow_backClick­"] forState:(UIControlStateHighlighted)];
        button.size = CGSizeMake(10, 30);
        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}

/**
 *  @brief 手势识别将要开始
 *  @param gestureRecognizer 手势识别
 *  @return 返回NO，放弃当前识别到的手势
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果是根视图控制器，则不支持手势返回
    return self.childViewControllers.count > 1;
}

/**
 *  @brief 返回上一个界面
 */
-(void)back{
    [self popViewControllerAnimated:YES];
}


@end
