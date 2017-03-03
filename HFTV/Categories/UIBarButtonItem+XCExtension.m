//
//  UIBarButtonItem+XCExtension.m
//  HHXC_Student
//
//  Created by 王锐 on 16/3/30.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "UIBarButtonItem+XCExtension.h"

@implementation UIBarButtonItem (XCExtension)

+(instancetype)itemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:(UIControlStateHighlighted)];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+(instancetype)itemWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImage title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.adjustsImageWhenHighlighted = NO;
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    if (selectedImage != nil) {
        [button setImage:[UIImage imageNamed:selectedImage] forState:(UIControlStateSelected)];
    }
    [button setTitle:title forState:(UIControlStateNormal)];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0,0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [button sizeToFit];
    button.size = CGSizeMake(button.size.width + 5, button.currentImage.size.height);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
