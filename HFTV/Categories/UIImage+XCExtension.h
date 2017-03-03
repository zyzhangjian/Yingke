//
//  UIImage+XCExtension.h
//  HHXC_Student
//
//  Created by 王锐 on 16/3/30.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XCExtension)

/**
 *  @brief 图片变成圆形的
 *
 *  @return 圆形的图片
 */
- (UIImage *)circleImage;

/**
 *  @brief 显示图片的原始颜色
 *
 *  @return 原始颜色的图片
 */
-(UIImage *)originalImage;

/**
 *  根据颜色生成图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 返回颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  根据颜色生成图片
 *
 *  @param color 颜色
 *
 *  @return 根据颜色生成图片
 */
+ (UIImage*) createImageWithColor:(UIColor*) color;

- (UIImage *)circleImageWithRadius:(CGFloat)radius;
@end
