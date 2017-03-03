//
//  HotModel.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotUser : NSObject
@property(nonatomic,strong)NSString *portrait;
@property(nonatomic,strong)NSString *nick;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *level;
@property(nonatomic,strong)NSString *userID;
@end

@interface HotModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *share_addr;
@property(nonatomic,strong)NSString *stream_addr;
@property(nonatomic,strong)NSString *version;
@property(nonatomic,strong)NSString *slot;
@property(nonatomic,strong)NSString *live_type;
@property(nonatomic,strong)NSString *online_users;
@property(nonatomic,strong)NSString *group;
@property(nonatomic,strong)HotUser *creator;
@end


