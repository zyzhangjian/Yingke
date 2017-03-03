//
//  HFTabBar.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/16.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HFTabBar.h"

@interface HFTabBar()

@property (nonatomic,weak) UIButton *orderButton;

@end
@implementation HFTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //添加开播按钮
        UIButton *orderButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        orderButton.adjustsImageWhenHighlighted = NO;
        [orderButton setImage:[UIImage imageNamed:@"tab_launch"] forState:(UIControlStateNormal)];
        [orderButton setImage:[UIImage imageNamed:@"tab_launch"] forState:(UIControlStateSelected)];
        [orderButton addTarget:self action:@selector(orderButtonClcik) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:orderButton];
        self.orderButton = orderButton;

    }
    
    return self;
}

-(void)orderButtonClcik{
    
    if (self.clickBlock) {
        self.clickBlock();
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.orderButton.bounds = CGRectMake(0, 0, self.orderButton.currentImage.size.width, self.orderButton.currentImage.size.height);
    self.orderButton.center = CGPointMake(self.width*0.5, self.height - self.orderButton.currentImage.size.height * 0.5);
    CGFloat width = (self.width - self.orderButton.width) * 0.5;
    
    CGFloat height = self.height;
    int index = 0;
    for (UIView *view in self.subviews) {
        //NSClassFromString可以根据类名得到类
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.frame = CGRectMake(index > 0? width + self.orderButton.width:0 , 0, width, height);
            index ++;
        }
    }
    
    //修改UITabBarItem图片位置
    for (UITabBarItem *item in self.items) {
        
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    
    [self bringSubviewToFront:self.orderButton];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.orderButton];
        
        if ([self.orderButton pointInside:newP withEvent:event]) {
            return self.orderButton;
        }else{
            return [super hitTest:point withEvent:event];
        }
        
    }
    else{
        return [super hitTest:point withEvent:event];
    }
}


@end
