//
//  UIWebView+Category.m
//  HHXC_Teacher
//
//  Created by 张健 on 16/5/25.
//  Copyright © 2016年 teacher. All rights reserved.
//

#import "UIWebView+Category.h"

@implementation UIWebView (Category)

- (void) removeAllCached
{
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

@end
