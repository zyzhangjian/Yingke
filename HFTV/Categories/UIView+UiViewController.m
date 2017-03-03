//
//  UIView+UiViewController.m
//  HeFanTV
//
//  Created by PT4 on 16/7/24.
//  Copyright © 2016年 SAGA. All rights reserved.
//

#import "UIView+UiViewController.h"

@implementation UIView (UiViewController)

- (UIViewController *)viewController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    } while (next);
    
    return nil;
}

- (UINavigationController *)navigationController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)next;
        }
        
        next = next.nextResponder;
    } while (next);
    
    return nil;
}

- (UITabBarController *)tabBarController
{
    UIResponder *next = self.nextResponder;
    
    do {
        if ([next isKindOfClass:[UITabBarController class]]) {
            return (UITabBarController *)next;
        }
        
        next = next.nextResponder;
    } while (next);
    
    return nil;
}

@end
