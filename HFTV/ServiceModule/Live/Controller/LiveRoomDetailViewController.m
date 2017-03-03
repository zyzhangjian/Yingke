//
//  LiveRoomDetailViewController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/2/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "LiveRoomDetailViewController.h"

@interface LiveRoomDetailViewController ()

@end

@implementation LiveRoomDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    NSLog(@"横屏页面初始化");
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UITextField *textFiel = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 100, 44)];
    textFiel.backgroundColor = [UIColor redColor];
    [self.view addSubview:textFiel];
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 50, 50)];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn bk_whenTapped:^{

        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [self.view addSubview:backBtn];

}

//设置样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//设置是否隐藏
- (BOOL)prefersStatusBarHidden {
    return NO;
}
////进入界面时强制横屏
//- (void)viewWillAppear:(BOOL)animated
//{
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeRight;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//    
//}
////退出界面时强制竖屏
//- (void)viewWillDisappear:(BOOL)animated
//{
//    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIDeviceOrientationPortrait;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
//}



//进入界面时强制横屏
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:YES];//调用转屏代码
}
//退出界面时强制竖屏
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    appDelegate.allowRotation = NO;//(以上2行代码,可以理解为打开横屏开关)
    
    [self setNewOrientation:NO];//调用转屏代码}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
