//
//  HFTabBar.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/16.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFTabBar : UITabBar

@property (nonatomic,copy) void(^clickBlock)();

@end
