//
//  AppDelegate.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign , nonatomic) BOOL isForceLandscape;
@property (assign , nonatomic) BOOL isForcePortrait;
@property(nonatomic,assign)BOOL allowRotation;//是否允许转向
@end

