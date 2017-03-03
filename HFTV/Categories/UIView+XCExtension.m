//
//  UIView+XCExtension.m
//  HHXC_Student
//
//  Created by 王锐 on 16/3/30.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "UIView+XCExtension.h"

@implementation UIView (XCExtension)

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX{
    return self.x + self.width/2;
}
- (void)setCenterX:(CGFloat)centerX{
    self.frame = CGRectMake(centerX - self.width/2, self.y, self.width, self.height);
}


#pragma mark view centerY:
- (CGFloat)centerY{
    return self.y + self.height/2;
}
- (void)setCenterY:(CGFloat)centerY{
    self.frame = CGRectMake(self.x, centerY-self.height/2, self.width, self.height);
}


#pragma mark view center:
- (CGPoint)center{
    return CGPointMake(self.centerX, self.centerY);
}
- (void)setCenter:(CGPoint)center{
    self.centerX = center.x;
    self.centerY = center.y;
}

@end
