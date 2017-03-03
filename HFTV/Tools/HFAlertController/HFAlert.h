//
//  HFAlert.h
//  HeFanTV
//
//  Created by Mr.Zhang on 2017/2/8.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 点击确定按钮回调
 */
typedef void (^HFAlertOkClicked)();

/**
 点击取消按钮回调
 */
typedef void (^HFAlertCancelClicked)();

@interface HFAlert : NSObject


/**
 弹出提示框只有确定和取消
 
 @param vc                试图
 @param title             标题
 @param msg               提示信息
 @param cancelTitle       取消按钮文字
 @param okTitle           确定按钮文字
 @param okHandle          点击确定回调
 @param cancelClickHandle 点击取消回调
 */
+ (void)showHFAlertInViewController:(UIViewController *)vc
                              title:(NSString *)title
                            message:(NSString *)msg
                  cancleButtonTitle:(NSString *)cancelTitle
                      okButtonTitle:(NSString *)okTitle
                      okClickHandle:(HFAlertOkClicked)okHandle
                  cancelClickHandle:(HFAlertCancelClicked)cancelClickHandle;




/**
 弹出框没有回调
 
 @param vc          试图
 @param title       标题
 @param msg         提示信息
 @param cancelTitle 取消按钮文字
 @param okTitle     确定按钮文字
 */
+ (void)showHFAlertInViewController:(UIViewController *)vc
                              title:(NSString *)title
                            message:(NSString *)msg
                  cancleButtonTitle:(NSString *)cancelTitle
                      okButtonTitle:(NSString *)okTitle;

@end
