//
//  BaseTabBarController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "BaseTabBarController.h"

#import "ClubViewController.h"

#import "MeViewController.h"

#import "BaseNavController.h"

#import "ViewControllerTwo.h"

#import "HFTabBar.h"

#import "ViewController.h"

#import "HFAlert.h"
@interface BaseTabBarController (){
    BOOL shouldAutorotate;
}


@end

@implementation BaseTabBarController

#pragma mark - VC Life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSMutableDictionary *dictAttrs = [NSMutableDictionary dictionary];
    dictAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:dictAttrs forState:(UIControlStateNormal)];
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [[UITabBarItem appearance] setTitleTextAttributes:dictAttrs forState:(UIControlStateSelected)];
    
    //添加子控制器
    [self setupChildVc:[self p_defaultController] title:@"" image:@"tab_live" selectImage:@"tab_live_p"];
    
    [self setupChildVc:[[MeViewController alloc] init] title:@"" image:@"tab_me" selectImage:@"tab_me_p"];
    
    //自定义tabBar
    [self setValue:[[HFTabBar alloc] init] forKey:@"tabBar"];
    
    self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    [(HFTabBar *)self.tabBar setClickBlock:^{
       
        [HFAlert showHFAlertInViewController:self title:nil message:@"123" cancleButtonTitle:@"取消" okButtonTitle:nil okClickHandle:^{
            
            NSLog(@"22222222");
            
        } cancelClickHandle:^{
            
            NSLog(@"1111111");
            
        }];
        
    }];
}



- (WMPageController *)p_defaultController {
    NSMutableArray *viewControllers = [NSMutableArray array];
    NSArray *titles = @[@"关注",@"热门",@"附近",@"才艺",@"好声音"];
    for (int i = 0; i < titles.count; i++) {
        Class vcClass;
        switch (i) {
            case 0:
                vcClass = [ViewController class];
                break;
            case 1:
                vcClass = [ViewController class];
                break;
            case 2:
                vcClass = [ViewControllerTwo class];
                break;
            default:
                vcClass = [ViewController class];
                break;
        }
        [viewControllers addObject:vcClass];
    }
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    pageVC.showOnNavigationBar = YES;
    pageVC.menuHeight = 44;
    pageVC.menuBGColor = [UIColor clearColor];
    pageVC.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    pageVC.menuItemWidth = 66;
    pageVC.postNotification = YES;
    pageVC.titleColorNormal = [UIColor whiteColor];
    pageVC.titleColorSelected = [UIColor whiteColor];
    pageVC.titleSizeSelected = 21;
    pageVC.selectIndex = 1;
    pageVC.bounces = NO;
    
    pageVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"searchbar_search"] style:UIBarButtonItemStylePlain target:nil action:nil];
    pageVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStylePlain target:nil action:nil];

    return pageVC;
}
-(void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImag {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] originalImage];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImag] originalImage];
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}



#pragma mark - - orientation
//// 是否支持转屏
//- (BOOL)shouldAutorotate
//{
////    NSLog(@"tabbar是否运行方向旋转%d",[self.selectedViewController shouldAutorotate]);
//    
//    return [self.selectedViewController shouldAutorotate];
//}
//// 返回nav栈中的最后一个对象支持的旋转方向
////- (UIInterfaceOrientationMask)supportedInterfaceOrientations
////{
//////    NSLog(@"%@",NSStringFromClass([self.selectedViewController class]));
////    return [self.selectedViewController supportedInterfaceOrientations];
////}



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
