//
//  NSString+XCExtension.m
//  HHXC_Student
//
//  Created by wangrui on 16/4/14.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "NSString+XCExtension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XCExtension)

//判断手机号码
+(BOOL)validatePhoneNumber:(NSString *)string {
    NSString *Regex = @"(13[0-9]|14[57]|15[012356789]|17[03678]|18[0-9])\\d{8}";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:string];
}

+ (BOOL)validateEmailAddr:(NSString *)string{
    NSString *regex = @"^[a-zA-Z0-9._%+-]+@(?!.*\\.\\..*)[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isNumber:(NSString *)string{
    NSString *regex = @"^\\d{1,9}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [predicate evaluateWithObject:string];
}

+ (BOOL)isIdCard:(NSString *)string{
    
    NSString *regex = @"^(\\d{15}$|^\\d{18}$|^\\d{17}(\\d|X|x))$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [predicate evaluateWithObject:string];
}

+ (NSString *)changePhoneNumWithPhone:(NSString *)phone
{
    if (phone.length == 11) {
        NSString * newPhoneNum = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return newPhoneNum;
    }
    return phone;
}

+ (NSString *)changeIDNumWithID:(NSString *)IDNum
{
    if (IDNum.length == 18) {
        NSString * newIDNum = [IDNum stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
        return newIDNum;
    }
    return IDNum;
}

+ (BOOL)isHaveChinese:(NSString *)string{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [predicate evaluateWithObject:string];
}

+(BOOL)isChinese:(NSString *)string{
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES%@", regex];
    return [predicate evaluateWithObject:string];
}

- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark - 根据传入字符串返回ViewFrame
+(CGFloat)sizeWithString:(NSString *)string
                    font:(UIFont *)font
           withSizeWidth:(CGFloat)width
               andHeight:(CGFloat)height {
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    
    return width == 0 ? rect.size.width : rect.size.height;
}

@end
