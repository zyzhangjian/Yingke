//
//  NSString+XCExtension.h
//  HHXC_Student
//
//  Created by wangrui on 16/4/14.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XCExtension)

// 判断手机号码
+(BOOL)validatePhoneNumber:(NSString *)string;

// 是否是邮箱地址
+(BOOL)validateEmailAddr:(NSString *)string;

// 是否是纯数字
+(BOOL)isNumber:(NSString *)string;

// 是否是身份证
+(BOOL)isIdCard:(NSString *)string;

// 是否包括中文
+(BOOL)isHaveChinese:(NSString *)string;

// 是否只包含中文
+(BOOL)isChinese:(NSString *)string;

/** 改变手机号4-7位为'*' */
+ (NSString *)changePhoneNumWithPhone:(NSString *)phone;

/** 改变身份证7-14位为'*' */
+ (NSString *)changeIDNumWithID:(NSString *)IDNum;

// md5加密
- (NSString *)md5Str;

/**
 *  根据传入字符串返回viewFrame
 *
 *  @param string 传入字符串
 *  @param font   字体大小
 *  @param width  默认宽
 *  @param height 默认高
 *
 *  @return 返回ViewFrame
 */
+(CGFloat)sizeWithString:(NSString *)string
                    font:(UIFont *)font
           withSizeWidth:(CGFloat)width
               andHeight:(CGFloat)height;
@end
