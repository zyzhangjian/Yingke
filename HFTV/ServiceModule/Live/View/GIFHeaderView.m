//
//  GIFHeaderView.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/2/4.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "GIFHeaderView.h"

#import "UIImage+GIF.h"
@implementation GIFHeaderView

- (void)prepare {
    
    [super prepare];
    
    self.lastUpdatedTimeLabel.hidden = YES;
    
    self.stateLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    
    for (NSInteger i = 1; i < 30; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_fly_00%02d",(int)i]];
        [idleImages addObject:image];
    }
    
    // 设置普通状态刷新状态的动画图片
    [self setImages:idleImages duration:1 forState:MJRefreshStateIdle];

    // 设置松开就可以刷新状态的动画图片
    [self setImages:idleImages duration:1 forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:idleImages duration:1 forState:MJRefreshStateRefreshing];
}
@end
