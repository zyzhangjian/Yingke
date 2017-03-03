//
//  YFKit.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFKit.h"

@import AVFoundation;
@import AssetsLibrary;

typedef void(^YFUIAlertControllerBlock)(UIAlertController *dialog,NSInteger buttonIndx);

@implementation YFKit

//相机是否拒绝授权
+ (BOOL)isCameraDenied
{
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (author == AVAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied)
    {
        return YES;
    }
    return NO;
}

//相机权限是否还没有确认
+ (BOOL)isCameraNotDetermined
{
    AVAuthorizationStatus author = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (author == AVAuthorizationStatusNotDetermined)
    {
        return YES;
    }
    return NO;
}

//相册权限是否已经被拒绝
+ (BOOL)isPhotoAlbumDenied
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author == ALAuthorizationStatusDenied)
    {
        return YES;
    }
    return NO;
}

//相册权限是否还没确定
+ (BOOL)isPhotoAlbumNotDetermined
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusNotDetermined)
    {
        return YES;
    }
    return NO;
}



@end
