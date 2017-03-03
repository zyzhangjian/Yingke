//
//  HotModel.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel

+(NSDictionary *)replacedkeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

@end


@implementation HotUser

+(NSDictionary *)replacedkeyFromPropertyName {
    
    return @{@"userID" : @"id"};
}

@end
