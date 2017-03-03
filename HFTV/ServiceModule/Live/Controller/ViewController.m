//
//  ViewController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - VC Life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

#pragma mark - 开启直播

- (IBAction)startLive:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 应用第一次申请权限调用这里
        if ([YFKit isCameraNotDetermined])
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted)
                    {
                        // 用户授权
                         NSLog(@"用户授权");
                        [CameraManage openPreview:self.view];
                    }
                    else
                    {
                        // 用户拒绝授权
                        NSLog(@"用户拒绝授权");
                    }
                });
            }];
        }
        // 用户已经拒绝访问摄像头
        else if ([YFKit isCameraDenied])
        {
             NSLog(@"拒绝访问摄像头，可去设置隐私里开启");
    
        }
        
        // 用户允许访问摄像头
        else
        {
            [CameraManage openPreview:self.view];
             NSLog(@"用户允许访问摄像头");
        }
    }
    else
    {
        // 当前设备不支持摄像头，比如模拟器
        NSLog(@"当前设备不支持拍照");
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
