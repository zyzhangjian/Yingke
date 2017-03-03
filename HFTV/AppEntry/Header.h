//
//  Header.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#ifndef Header_h
#define Header_h

/** 打印输出 */
#ifdef DEBUG
#define HFLog(...) NSLog(__VA_ARGS__)
#else
#define HFLog(...)
#endif

#define XCLogFunc XCLog(@"%s",__func__)

/**
 *  字符串 空值处理
 */
#define YKNSString(string)          [NSString stringWithFormat:@"%@",string]

/** 颜色 */
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((rgbValue >> 16) & 0xFF)/255.f \
green:((rgbValue >> 8) & 0xFF)/255.f \
blue:(rgbValue & 0xFF)/255.f \
alpha:1.0f]
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XCGlobalBg XCRGBColor(240,240,240)
#define XCCellLineBg [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.7]

/** 屏幕大小,tabBar高度,statusBar高度,nav高度 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define kTabBarH        49.0f
#define kStatusBarH     20.0f
#define kNavigationBarH 44.0f

#define  autoSizeScaleWidth  SCREEN_WIDTH / 375.0
#define  autoSizeScaleHeight  SCREEN_HEIGHT / 667.0

// 系统版本号
#define kCurrentDevice          [UIDevice currentDevice]
#define IOS7 [kCurrentDevice.systemVersion floatValue] >= 7.0 //iOS7
#define IOS8 [kCurrentDevice.systemVersion floatValue] >= 8.0 //iOS8
#define PhoneUUID [[UIDevice currentDevice].identifierForVendor UUIDString]

// 设备
#define kDevice_Is_iPhone4 ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) && SCREEN_HEIGHT < 568.0)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/** 当前window */
#define kKeyWindow              [UIApplication sharedApplication].keyWindow

/** 客服电话 */
#define kServicePhone @"400-184-0880"

/** 当前版本号 */
#define kVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

/** weakSelf的替换 使用 XC(xc) xc<==>weakSelf*/
#define YK(weakSelf) __weak __typeof(&*self)weakSelf = self;

/** 提示弹框*/
#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]

/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */

#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);

#endif /* Header_h */
