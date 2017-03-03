//
//  HFAlert.m
//  HeFanTV
//
//  Created by Mr.Zhang on 2017/2/8.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HFAlert.h"

#import <objc/runtime.h>

const char *HFAlertOkBlock = "HFAlertOkBlock";
const char *HFAlertCancelBlock = "HFAlertCancelBlock";

@implementation UIAlertController(HFAlert)

- (void)setOkBlock:(HFAlertOkClicked)okBlock{
    /**
     *  @brief 设置关联对象
     *
     *  @id object              获取谁的关联对象
     *  @const void *key        关联对象唯一的key，获取时会用到
     *  @id value               关联对象
     *  @objc_AssociationPolicy 关联策略(它可以指定Objc内存管理的引用计数机制)
     */
    objc_setAssociatedObject(self, HFAlertOkBlock, okBlock, OBJC_ASSOCIATION_COPY);
}

- (HFAlertOkClicked)okBlock{
    return objc_getAssociatedObject(self, HFAlertOkBlock);
}

- (void)setCancelBlock:(HFAlertCancelClicked)cancelBlock{
    objc_setAssociatedObject(self, HFAlertCancelBlock, cancelBlock, OBJC_ASSOCIATION_COPY);
}

- (HFAlertOkClicked)cancelBlock{
    return objc_getAssociatedObject(self, HFAlertCancelBlock);
}

@end

@implementation HFAlert

+ (void)showHFAlertInViewController:(UIViewController   *)vc
                              title:(NSString *)title
                            message:(NSString *)msg
                  cancleButtonTitle:(NSString *)cancelTitle
                      okButtonTitle:(NSString *)okTitle
                      okClickHandle:(HFAlertOkClicked)okHandle
                  cancelClickHandle:(HFAlertCancelClicked)cancelClickHandle {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction;
    UIAlertAction *okAction;
    
    if (okHandle) {alert.okBlock = okHandle;}
    if (cancelClickHandle) {alert.cancelBlock = cancelClickHandle;}
    
    if (cancelTitle != nil) {
        
       cancelAction  = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
           
           dispatch_after(0.1, dispatch_get_main_queue(), ^{
               
               if (alert.cancelBlock) alert.cancelBlock();
               
           });
       }];

    }
    
    if (okTitle != nil) {
        
       okAction  = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
           dispatch_after(0.1, dispatch_get_main_queue(), ^{
               
               if (alert.okBlock) alert.okBlock();
               
           });
       }];
    }
    
    if (cancelAction) {[alert addAction:cancelAction];}
    if (okAction) {[alert addAction:okAction];}
    
    [vc presentViewController:alert animated:YES completion:nil];

}


+ (void)showHFAlertInViewController:(UIViewController   *)vc
                              title:(NSString *)title
                            message:(NSString *)msg
                  cancleButtonTitle:(NSString *)cancelTitle
                      okButtonTitle:(NSString *)okTitle {

    [self showHFAlertInViewController:vc title:title message:msg cancleButtonTitle:cancelTitle okButtonTitle:okTitle okClickHandle:nil cancelClickHandle:nil];
    
}
@end
