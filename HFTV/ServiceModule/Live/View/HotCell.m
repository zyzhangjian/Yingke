//
//  HotCell.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = UIColorFromRGB(0xf3f8f9);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HotModel *)model {
    
    YK(weak);
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:YKNSString([self imageUserName:model.creator.portrait])] placeholderImage:[UIImage imageNamed:@"default_head"] options:SDWebImageRetryFailed  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            weak.iconImageView.image = [image circleImageWithRadius:weak.iconImageView.width];
        }
    }];

    [self.userBigImageView sd_setImageWithURL:[NSURL URLWithString:YKNSString([self imageUserName:model.creator.portrait] )] placeholderImage:[UIImage imageNamed:@"default_room"] options:SDWebImageRetryFailed  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            weak.userBigImageView.image = image;
        }
    }];
    
    self.userNameLabel.text = YKNSString(model.creator.nick);
    self.userAddressLabel.text = [NSString stringWithFormat:@"%@ >",model.city.isBlankString ? @"难道在火星?" : model.city];
    self.audienceCountLabel.text = YKNSString(model.online_users);
}

//判断图片地址是否http://开头
- (NSString *)imageUserName:(NSString *)userName {
    
    return ![userName hasPrefix:@"http://"] ? [NSString stringWithFormat:@"http://img2.inke.cn/%@",userName] : userName;
}

@end
