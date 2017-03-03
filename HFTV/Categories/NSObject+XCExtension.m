//
//  NSObject+XCExtension.m
//  HHXC_Student
//
//  Created by wangrui on 16/5/4.
//  Copyright © 2016年 eCar. All rights reserved.
//

#import "NSObject+XCExtension.h"

@implementation NSObject (XCExtension)

// 字典按照Key进升序排序 value值进行md5加密
-(NSString *)md5encrypt:(NSDictionary *)dict {
    NSMutableString *str = [NSMutableString string];
    
    NSArray *keys = [dict allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    for (NSString *currentStr in sortedArray) {
        NSString *value;
        if ([[dict objectForKey:currentStr] isKindOfClass:[NSArray class]]) {
            NSArray *result = [dict objectForKey:currentStr];
            value = [NSString stringWithFormat:@"%lu",[result count]];
        }else if ([[dict objectForKey:currentStr] isKindOfClass:[NSDictionary class]]){
            NSDictionary *result = [dict objectForKey:currentStr];
            value = [NSString stringWithFormat:@"%lu",[result count]];
        }else{
            value = [dict objectForKey:currentStr];
        }
        [str appendString:[NSString stringWithFormat:@"%@",value]];
    }
    str = str.md5Str.copy;
    return str;
}

@end
