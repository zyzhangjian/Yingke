//
//  UIImageView+XCExtension.h
//  HHXC_Student
//
//  Created by wangrui on 16/4/5.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XCExtension)

/**
 *  @brief 设置图片控件显示为圆角
 *
 *  @param url       图片的地址
 *  @param imageName 占位图片名称
 */
-(void)setCircleHeader:(NSString *)url placeholderName:(NSString *)imageName;


@end
