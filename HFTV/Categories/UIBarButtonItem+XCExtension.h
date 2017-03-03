//
//  UIBarButtonItem+XCExtension.h
//  HHXC_Student
//
//  Created by 王锐 on 16/3/30.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XCExtension)

/**
 *  @brief UIBarButtonItem里面包UIButton
 *
 *  @param imageName     背景图片
 *  @param highImageName 高亮图片
 *  @param target        哪个类
 *  @param action        类的方法名
 *
 *  @return UIBarButtonItem
 */
+(instancetype)itemWithImage:(NSString *)imageName highImage:(NSString *)highImageName target:(id)target action:(SEL)action;

+(instancetype)itemWithImageName:(NSString *)imageName selectedImage:(NSString *)selectedImage title:(NSString *)title target:(id)target action:(SEL)action;

@end
