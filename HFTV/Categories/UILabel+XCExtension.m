//
//  UILabel+XCExtension.m
//  HHXC_Student
//
//  Created by wangrui on 16/4/16.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "UILabel+XCExtension.h"

@implementation UILabel (XCExtension)


+(instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:fontsize]];
    [label setText:title];
    label.textColor = titleColor;
    label.textAlignment = alignment;
    [label sizeToFit];
    return label;
}


@end
