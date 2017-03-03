//
//  YFKit.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFKit : NSObject

+ (BOOL)isCameraDenied;
+ (BOOL)isCameraNotDetermined;

+ (BOOL)isPhotoAlbumDenied;
+ (BOOL)isPhotoAlbumNotDetermined;

@end
