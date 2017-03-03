//
//  UILabel+XCExtension.h
//  HHXC_Student
//
//  Created by wangrui on 16/4/16.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XCExtension)

/**
 *  @brief 快速创建UILabel
 *
 *  @param title      显示文字
 *  @param titleColor 文字颜色
 *  @param fontsize   文字大小
 *  @param alignment  文字位置
 *
 *  @return UILabel
 */
+(instancetype)labelWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontsize:(CGFloat)fontsize alignment:(NSTextAlignment)alignment;

@end
