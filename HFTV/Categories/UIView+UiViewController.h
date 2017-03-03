//
//  UIView+UiViewController.h
//  HeFanTV
//
//  Created by PT4 on 16/7/24.
//  Copyright © 2016年 SAGA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UiViewController)

- (UIViewController *)viewController;
- (UINavigationController *)navigationController;
- (UITabBarController *)tabBarController;

@end
