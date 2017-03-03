//
//  LiveRoomViewController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "LiveRoomViewController.h"

#import "LiveRoomRootView.h"

@interface LiveRoomViewController ()

@property(nonatomic,strong)IJKFFMoviePlayerController   *moviePlayer;
@property(nonatomic,strong)LiveRoomRootView             *rootView;
@property(nonatomic,strong)UIButton                     *outBtn;

@end

@implementation LiveRoomViewController

#pragma mark - VC Life
- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.rootSV];

    [self.view addSubview:self.outBtn];
    
    //传入当前试图索引
    self.rootView.index = self.index;
    
    //传入试图数组
    self.rootView.modelArray = self.modelArray;

}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
// 只支持竖向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

 //画面一开始加载时就是竖向
 - (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
     return UIInterfaceOrientationPortrait;
 }
#pragma mark - 懒加载
- (UIButton *)outBtn {
    
    if (!_outBtn) {
        
        _outBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, SCREEN_HEIGHT - 52, 40 , 40)];
        [_outBtn setBackgroundImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:(UIControlStateNormal)];
        __weak LiveRoomViewController *weakself = self;
        [_outBtn bk_whenTapped:^{
            
            [weakself.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    return _outBtn;
}

- (LiveRoomRootView *)rootSV {
    
    if (!_rootView) {
        
        _rootView = [[LiveRoomRootView alloc]initWithFrame:self.view.bounds];

    }
    
   return _rootView;
}

- (void)dealloc{

    NSLog(@"========直播间dealloc=======");
    //    if (_moviePlayer) {
    [_moviePlayer shutdown];
    [_moviePlayer stop];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    [_rootView removeFromSuperview];
    _rootView = nil;
    _modelArray = nil;
    //    }
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
