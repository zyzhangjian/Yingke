//
//  UIColor+XCExtension.h
//  HHXC_Student
//
//  Created by wangrui on 16/4/12.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XCExtension)

/**
 *  根据另一个颜色,和色差 获得一个新颜色(总值255)
 *
 *  @param color 另一个颜色
 *  @param red   红色色差(总值255)
 *  @param green 绿色色差(总值255)
 *  @param blue  蓝色色差(总值255)
 *  @param alpha 透明色差(总值255)
 *
 *  @return 返回新的颜色
 */
+ (UIColor *)colorWithColor:(UIColor *)color
                  AndGapRed:(CGFloat)red
                      Green:(CGFloat)green
                       Blue:(CGFloat)blue
                      Alpha:(CGFloat)alpha;


/**
 *  根据一个16进制颜色获得一个 RGB 数值,也可以设置透明度
 *
 *  @param color 16进制数值(color:支持@"#123456"、 @"0X123456"、 @"123456"三种格式)
 *  @param alpha 透明度
 *
 *  @return 返回一个 对应的UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  根据一个16进制颜色获得一个 RGB 数值,也可以设置透明度,默认透明度1
 *
 *  @param color @param color 16进制数值(color:支持@"#123456"、 @"0X123456"、 @"123456"三种格式)
 *
 *  @return 返回一个 对应的UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;

@end
