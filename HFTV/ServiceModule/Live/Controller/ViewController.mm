//
//  ViewController.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/6.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>

#import <UIKit/UIKit.h>

#import "InfoView.h"

#import "LiveRoomViewController.h"

#import "BaseNavController.h"

#import "SDCycleScrollView.h"

#import "HotModel.h"

#import "HotCell.h"

#import "GIFHeaderView.h"

#import "BannerModel.h"

#import "ViewControllerTwo.h"

#import "HFAlert.h"
#import "SDImageCache.h"
@interface ViewController ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    BOOL _isBack;
}

@property(nonatomic,strong)InfoView *infoView;

@property (strong, nonatomic)UITableView *myTableView;

@property(nonatomic,strong)SDCycleScrollView *bannerView;

@property(nonatomic,strong)NSMutableArray *modelArray;

@property(nonatomic,strong)NSMutableArray *bannerModelArray;

@end

@implementation ViewController

#pragma mark - VC Life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelArray = [NSMutableArray array];
    
    [self initBannerView];

    [self bannerRequest];
    
    [self hotListRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - bannerViewList

- (void)bannerRequest {
    

    [[HFNetworkTools sharedTools]requestWithMethod:GET URLString:BannerList parameters:nil finished:^(id result, NSError *error) {
        
        if ([result[@"error_msg"] isEqualToString:@"操作成功"]) {

            _bannerModelArray = [NSMutableArray array];

            _bannerModelArray = [BannerModel mj_objectArrayWithKeyValuesArray:result[@"ticker"]];
            
            NSMutableArray *imageArray = [NSMutableArray array];
            
            for (BannerModel *model in _bannerModelArray) {
                
                ![model.image hasPrefix:@"http://"] ? [imageArray addObject:[NSString stringWithFormat:@"http://img2.inke.cn/%@",model.image]] : [imageArray addObject:YKNSString(model.image)];
            }
            
            _bannerView.imageURLStringsGroup = imageArray;
        }
        
        
    } nonetwork:^{
        
        
    }];

}

#pragma mark - hotList

-(void)hotListRequest {
    
    
    YK(ws);
    [[HFNetworkTools sharedTools]requestWithMethod:GET URLString:HotList parameters:nil finished:^(id result, NSError *error) {
        
        if ([result[@"error_msg"] isEqualToString:@"操作成功"]) {
            
            _modelArray = [HotModel mj_objectArrayWithKeyValuesArray:result[@"lives"]];

            [ws.myTableView reloadData];
            
            [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        }
        
        [ws.myTableView.mj_header endRefreshing];
        
    } nonetwork:^{
        
        [ws.myTableView.mj_header endRefreshing];
        
    }];
}



- (void)initBannerView {
    
    SDCycleScrollView *bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 107)];
    bannerView.autoScrollTimeInterval = 5.0;
    self.bannerView = bannerView;
    bannerView.layer.cornerRadius = 5;
    bannerView.layer.masksToBounds = YES;
    bannerView.delegate = self;
    self.myTableView.tableHeaderView = bannerView;
    
    bannerView.placeholderImage = [UIImage imageNamed:@"default_ticker"];
    bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    bannerView.currentPageDotColor = [UIColor whiteColor];
    bannerView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - BannerViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@"点击了%ld张图片",(long)index);
    
}
#pragma mark - 开启直播

- (IBAction)startLive:(id)sender {
    
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        // 应用第一次申请权限调用这里
//        if ([YFKit isCameraNotDetermined])
//        {
//            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (granted)
//                    {
//                        [CameraManage openCamera:@{@"FrameRate": @"30", @"sessionPreset":@"AVCaptureSessionPreset1280x720"} callbackBlock:^(bool authorize) {
//                            
//                            if (!authorize) {
//                                
//                                NSLog(@"需要先授权!");
//                                return;
//                            }
//                            
//                            
//                        }];
//                        
//                        [CameraManage openPreview:self.rootView];
//                        [kKeyWindow addSubview:self.infoView];
//                        
//                        
//                        
//                    }else{
//                        
//                        // 用户拒绝授权
//                        NSLog(@"用户拒绝授权");
//                    }
//                });
//            }];
//        
//        }else if ([YFKit isCameraDenied]){
//            
//             NSLog(@"拒绝访问摄像头，可去设置隐私里开启");
//    
//        }else{
//         
//         [CameraManage openCamera:@{@"FrameRate": @"30", @"sessionPreset":@"AVCaptureSessionPreset1280x720"} callbackBlock:^(bool authorize) {
//                
//             if (!authorize) {
//                 
//                 NSLog(@"需要先授权!");
//                 return;
//             }
//             
//             
//            }];
// 
//            [CameraManage openPreview:self.rootView];
//            [kKeyWindow addSubview:self.infoView];
//            
//        }
//    
//    }else{
//        // 当前设备不支持摄像头，比如模拟器
//        NSLog(@"当前设备不支持拍照");
//        
//    }
    
//    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc]init];
//    liveRoomVC.playURL =
//    BaseNavController *nav = [[BaseNavController alloc]initWithRootViewController:two];
//    [self presentViewController:nav animated:NO completion:nil];

//    http://120.55.238.158/api/live/simpleall?lc=0000000000000045&cc=TG0001&cv=IK3.8.30_Iphone&proto=7&idfa=5FED1AF6-AC64-48E7-B0F0-F1BB312637EE&idfv=160C30D7-F2C7-4E5E-968C-8DA6E694BD7A&devi=dc7d189690d3bc7cad51f3758c7faf976aca04f3&osversion=ios_9.300000&ua=iPhone5_2&imei=&imsi=&uid=343582398&sid=20oc7POdbiFXX87QrkXJCOJdX364KW3AJLv5CpW1VCC2kyUqRi1&conn=wifi&mtid=68d4e8b89c0c2a991eeff7ada1666749&mtxid=882593cacc6f&logid=5&s_sg=abf760e15a4febd36e93878053827244&s_sc=100&s_st=1485068773
}



//-(InfoView *)infoView {
//    
//    if (_infoView == nil) {
//        
//        _infoView = [[InfoView alloc]initWithFrame:kKeyWindow.frame WithBlock:^(int type) {
//            
//            NSLog(@"%d",type);
//            
//            
//            if (type == 1) {
//            
//                if (!_isBack) {
//                    
//                     [CameraManage setCameraState:CameraPosition_back];
//               
//                    _isBack = YES;
//                    
//                }else{
//                    
//                    _isBack = NO;
//                    
//                     [CameraManage setCameraState:CameraPosition_front];
//                }
//           
//            
//            }else if (type == 2){
//                
//                self.rootView.hidden = YES;
//                self.infoView.hidden = YES;
//                [CameraManage closePreview];
//            }
//            
//        }];
//    }
//    
//    _infoView.hidden = NO;
//    
//    return _infoView;
//}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 375;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ViewControllerTwo *two = [[ViewControllerTwo alloc]init];
//    [two orientationToPortrait:UIInterfaceOrientationLandscapeLeft];
//    BaseNavController *nav = [[BaseNavController alloc]initWithRootViewController:two];
//    [self presentViewController:nav animated:NO completion:nil];

    LiveRoomViewController *roomVC = [[LiveRoomViewController alloc]init];
    roomVC.modelArray = _modelArray;
    roomVC.index = indexPath.row;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:roomVC];
//    [self.navigationController pushViewController:roomVC animated:YES];
    [self presentViewController:nav animated:YES completion:nil];
    [self setTabBarHidden:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *iden = @"Cell";
    
    HotModel *model = [_modelArray objectAtIndex:indexPath.row];
    
    HotCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    cell.model = model;
    
    return cell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat translationY = [scrollView.panGestureRecognizer translationInView:scrollView.superview].y;
    
    [self setTabBarHidden:translationY < 0];
    
    _myTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (translationY < 0 ? -20 : 114));
}



-(UITableView *)myTableView {
    
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_myTableView];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"HotCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        
        _myTableView.mj_header = [GIFHeaderView headerWithRefreshingTarget:self refreshingAction:@selector(refreshHotList)];
    }
    
    return _myTableView;
}

-(void)refreshHotList {
    
    [self hotListRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
