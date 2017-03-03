//
//  InfoView.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/9.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "InfoView.h"

@implementation InfoView

-(instancetype)initWithFrame:(CGRect)frame WithBlock:(TMBlock)block {
    
    if (self = [super initWithFrame:frame]) {
        
        self.tmBlock = block;
        
        [self initUI];
    }
    
    return self;
}

-(void)initUI {
    
    UIImageView *addressImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 34, 11, 14)];
    addressImage.image = [UIImage imageNamed:@"btn_dingwei_press"];
    addressImage.alpha = 0.8;
    [self addSubview:addressImage];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(addressImage.right + 2.5 , 31, [NSString sizeWithString:@"北京市" font:[UIFont systemFontOfSize:13] withSizeWidth:0 andHeight:17], 17)];
    addressLabel.text = @"北京市";
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = UIColorFromRGB(0xffffff);
    addressLabel.alpha =0.8;
    [self addSubview:addressLabel];
                                                                    
                                                                    
    

    UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 36, 35, 21, 21)];
    [closeBtn setImage:[UIImage imageNamed:@"btn_tuichu2"] forState:(UIControlStateNormal)];
    [closeBtn bk_whenTapped:^{
        
        
        if (self.tmBlock != nil) {
            
            self.tmBlock(2);
        }
        
    }];
    [self addSubview:closeBtn];
    
    UIButton *changedDirection = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 86, 32, 25, 25)];
    [changedDirection setImage:[UIImage imageNamed:@"icon_fanzhuan2"] forState:(UIControlStateNormal)];
    [changedDirection bk_whenTapped:^{
        
        
        if (self.tmBlock != nil) {
            
            self.tmBlock(1);
        }
        
    }];
    [self addSubview:changedDirection];
}

@end
