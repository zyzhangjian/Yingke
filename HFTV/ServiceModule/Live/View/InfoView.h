//
//  InfoView.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/9.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TMBlock)(int);

@interface InfoView : UIView

@property(nonatomic,strong)TMBlock tmBlock;

-(instancetype)initWithFrame:(CGRect)frame WithBlock:(TMBlock)block;

@end
