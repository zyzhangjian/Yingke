//
//  UITabBarController+Autorotate.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/3/2.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "UITabBarController+Autorotate.h"

@implementation UITabBarController (Autorotate)
//- (BOOL)shouldAutorotate
//{
////    return [self.selectedViewController shouldAutorotate];
//    return YES;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return [self.selectedViewController supportedInterfaceOrientations];
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
//}



/**
 *   shouldAutorotate  supportedInterfaceOrientations调用顺序最底层容器控制器有优先权级别，先判断tabbarController,再判断navgationController，在具体的某个contoller
 *
 */
- (BOOL)shouldAutorotate
{
    if ([self.selectedViewController isEqual:[self.viewControllers objectAtIndex:0]]) {
        return [self.selectedViewController shouldAutorotate];
    }
    return NO; // tabbar第一栏旋转控制交给下级控制器，其他栏不支持自动旋转
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([self.selectedViewController isEqual:[self.viewControllers objectAtIndex:0]]) {
        return [self.selectedViewController supportedInterfaceOrientations];
    }
    return UIInterfaceOrientationMaskPortrait; // tabbar第一栏控制器所支持旋转方向交给下级控制器处理，其他栏只支持竖屏方向
}

@end
