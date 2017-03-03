//
//  ViewControllerTwo.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/11.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewControllerTwo.h"

#import "AppDelegate.h"

#import "LiveRoomDetailViewController.h"

@interface ViewControllerTwo ()

@end

@implementation ViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TWO初始化");
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textFiel = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, 100, 44)];
    textFiel.backgroundColor = [UIColor redColor];
    [self.view addSubview:textFiel];
    
    YK(weakSelf);
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 200, 50, 50)];
    backBtn.backgroundColor = [UIColor redColor];
    [backBtn bk_whenTapped:^{
//        [self orientationToPortrait:UIInterfaceOrientationUnknown];
//        [self dismissViewControllerAnimated:NO completion:nil];

        LiveRoomDetailViewController *vc = [[LiveRoomDetailViewController alloc]init];
        
        [self presentViewController:vc animated:NO completion:nil];
    }];
    
    
    [self.view addSubview:backBtn];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //强制旋转竖屏
    [self forceOrientationPortrait];
    
    //设置屏幕的转向为竖屏
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
       }

#pragma  mark 横屏设置
//强制横屏
- (void)forceOrientationLandscape
{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForceLandscape=YES;
    appdelegate.isForcePortrait=NO;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
}

//强制竖屏
- (void)forceOrientationPortrait
{
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForcePortrait=YES;
    appdelegate.isForceLandscape=NO;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:self.view.window];
}

- (BOOL)prefersStatusBarHidden{
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //强制旋转竖屏
    [self forceOrientationLandscape];
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];

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
