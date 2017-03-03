//
//  HotCell.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
@interface HotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userBigImageView;
@property (weak, nonatomic) IBOutlet UILabel *audienceCountLabel;
@property (nonatomic,strong)HotModel *model;
@end
