//
//  AppDelegate.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "AppDelegate.h"

#import "BaseTabBarController.h"

#import <AVFoundation/AVFoundation.h>

#import <JPFPSStatus/JPFPSStatus.h>

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier  backgroundTaskIdentifier;

@property (nonatomic, retain) NSTimer                     *myTimer;

@end

@implementation AppDelegate

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window {
    
    return _allowRotation ? UIInterfaceOrientationMaskLandscapeLeft : UIInterfaceOrientationMaskPortrait;

}

-(void)setUpAudio
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL ok;
    NSError *setCategoryError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    ok = [audioSession setCategory:AVAudioSessionCategoryPlayback        error:&setCategoryError];
    if (!ok) {
        NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //白色状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[BaseTabBarController alloc]init];
    [self setUpAudio];
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    if (![self isMultitaskingSupported])
    {
        return;
    }
    
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                    target:self
                                                  selector:@selector(timerMethod:)
                                                  userInfo:nil
                                                   repeats:YES];
    
    self.backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^(void){
        [self endBackgroundTask];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid)
    {
        [self endBackgroundTask];
    }
}
// 判断是否支持后台多任务
- (BOOL) isMultitaskingSupported
{
    BOOL result = NO;
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    
    return result;
}

// 在2min时间内，切回前台是会继续推送的，超出2min后，通知app去关闭推流或者播放（50sec建议不要往低改，会影响到稳定性）
- (void) timerMethod:(NSTimer *) paramSender
{
    NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    
    if (backgroundTimeRemaining == DBL_MAX) {
        NSLog(@"Background Time Remaining = Undetermined");
    }else{
        // limit time: two min
        if ((NSInteger)backgroundTimeRemaining == 50) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"recorderStop" object:nil];
        }
        
        NSLog(@"Background Time Remaining = %.02f Seconds",backgroundTimeRemaining);
    }
}

// 停止后台申请任务以及定时器
- (void) endBackgroundTask
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    __block AppDelegate *weakSelf = self;
    
    dispatch_async(mainQueue, ^(void){
        AppDelegate *strongSelf = weakSelf;
        
        if (strongSelf)
        {
            [strongSelf.myTimer invalidate];
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
            strongSelf.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}


//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _historyY = scrollView.contentOffset.y;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (_historyY < scrollView.contentOffset.y ) {
//        [self setTabBarHidden:YES];
//    }else{
//        [self setTabBarHidden:NO];
//    }
//}
////隐藏显示tabbar
//- (void)setTabBarHidden:(BOOL)hidden
//{
//        UIView *tab = self.tabBarController.view;
//        CGRect  tabRect=self.tabBarController.tabBar.frame;
//        if ([tab.subviews count] < 2) {
//            return;
//        }
//    
//        UIView *view;
//        if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
//            view = [tab.subviews objectAtIndex:1];
//        } else {
//            view = [tab.subviews objectAtIndex:0];
//        }
//    
//        if (hidden) {
//            view.frame = kKeyWindow.frame;
//            tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
//        } else {
//            view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
//            tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
//        }
//    
//    
//        [UIView animateWithDuration:0.3f animations:^{
//            self.tabBarController.tabBar.frame=tabRect;
//        }];
//    
//        [UIView animateWithDuration:0.3f animations:^{
//            self.tabBarController.tabBar.frame=tabRect;
//    
//        } completion:^(BOOL finished) {
//    
//            self.tabBarController.tabBar.hidden = hidden;
//            [self.navigationController setNavigationBarHidden:hidden];
//    
//        }];
//    
//    
//        if (self.tabBarController.tabBar.hidden == YES) {
//            return;
//        }
//    
//    UIView *contentView;
//    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
//        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//    else
//        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
//    
//    self.tabBarController.tabBar.hidden = hidden;
//    
//    [UIView animateWithDuration:0.3f animations:^{
//        
//        [self.navigationController setNavigationBarHidden:hidden animated:NO];
//    }];
//    
//}



@end
