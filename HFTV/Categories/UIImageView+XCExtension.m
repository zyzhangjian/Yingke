//
//  UIImageView+XCExtension.m
//  HHXC_Student
//
//  Created by wangrui on 16/4/5.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "UIImageView+XCExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+XCExtension.h"

@implementation UIImageView (XCExtension)

/**
 *  @brief 设置图片控件显示为圆角
 *
 *  @param url       图片的地址
 *  @param imageName 占位图片名称
 */
-(void)setCircleHeader:(NSString *)url placeholderName:(NSString *)imageName{
    
    UIImage *placeholder = [UIImage imageNamed:imageName];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image circleImage] : placeholder;
    }];
}


@end
