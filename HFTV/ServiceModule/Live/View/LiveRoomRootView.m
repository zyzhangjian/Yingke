//
//  LiveRoomRootView.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/2/10.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "LiveRoomRootView.h"

#import "LiveMessageView.h"

#import "HotModel.h"

@interface LiveRoomRootView()<UIScrollViewDelegate>

//所有试图数组
@property (nonatomic,strong) NSMutableArray* subViewsArray;

//聊天试图
@property(nonatomic,strong)LiveMessageView *messageView;

/**正在显示的视图*/
@property (nonatomic,strong) UIView* showView;

//播放试图
@property(nonatomic,strong)IJKFFMoviePlayerController *moviePlayer;
@end

@implementation LiveRoomRootView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        UIScrollView *scrollerView = [[UIScrollView alloc]initWithFrame:frame];
        scrollerView.delegate = self;
        scrollerView.bounces = NO;
        scrollerView.pagingEnabled = YES;
        [self addSubview:scrollerView];
        
        for (NSInteger i = 0; i < 3; i ++ ){
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
            [self generateDimImage:imageView];
            CGFloat imageY = CGRectGetHeight(self.bounds)*i;
            imageView.frame = CGRectMake(0, imageY,SCREEN_WIDTH, SCREEN_HEIGHT);
            [scrollerView addSubview:imageView];
            [self.subViewsArray addObject:imageView];
        }
        scrollerView.contentSize = CGSizeMake(0, SCREEN_HEIGHT * 3);
        scrollerView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);

    }
    
    return self;
}

#pragma mark - 生成磨玻璃图片
-(void)generateDimImage:(UIImageView *)imageView{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height);
    [imageView addSubview:effectView];
}


-(void)setModelArray:(NSArray *)modelArray {
    
    _modelArray = modelArray;
    
    [self setUpImageWith:self.index];
}

// 设置当前图片根据当前的索引
-(void)setUpImageWith:(NSInteger )index{
    
    for (NSInteger i = 0; i < self.subViewsArray.count; i ++) {
        UIImageView *imageView = self.subViewsArray[i];
        imageView.userInteractionEnabled = YES;
        NSInteger currentIndex;
        if (i==0) {
            currentIndex = index==0 ? self.modelArray.count-1 : index -1;
            
        }else if (i==1){
            currentIndex = index;
            
        }else{
            currentIndex = index==self.modelArray.count-1 ? 0 : index + 1;
        }
        
        //获取model
        HotModel *model = self.modelArray[currentIndex];
        
        /**此处非常重要 可以根据自己是实际需要选折是显示本地照片或者网路照片,若显示网路照片,请将下面的方法换成sdwebimage显示图片方法*/
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.creator.portrait] placeholderImage:[UIImage imageNamed:((int)(arc4random() % 2) + 1) == 1 ? @"loading_bg.png" : @"swipe_bg.jpg"]];
        [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
    }
   
    //主需要将播放视图展示在i==1的界面即可
    UIView *currentView = self.subViewsArray[1];
   
    
    //添加播放器
    _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:[self getPlayerURL]] withOptions:nil];
    _moviePlayer.view.frame = self.bounds;
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    _moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    _moviePlayer.shouldShowHudView = NO;
    [currentView addSubview:_moviePlayer.view];
    [_moviePlayer prepareToPlay];
    [_moviePlayer setScalingMode:IJKMPMovieScalingModeAspectFill];
    
    
    [currentView addSubview:self.messageView];
    
    // 设置监听
    [self addObserver];
}

#pragma mark - 添加监听
- (void)addObserver
{
    //监听加载状态改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadStateDidChange:) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_moviePlayer];
}

- (void)loadStateDidChange:(NSNotification *) notification
{
    //状态为缓冲几乎完成，可以连续播放
    if ((_moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!_moviePlayer.isPlaying) {
            //开始播放
            [_moviePlayer play];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
//                 UIImageView *imageView = self.subViewsArray[1];
//                 imageView.hidden = YES;
                
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            //            if ([_activity isAnimating]) {
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //
            //                });
            //            }
        }
    }
    //缓冲中
    else if (_moviePlayer.loadState & IJKMPMovieLoadStateStalled){
        
        /*
         这里主播可能已经结束直播了。我们需要请求服务器查看主播是否已经结束直播。
         方法：
         1、从服务器获取主播是否已经关闭直播。
         优点：能够正确的获取主播端是否正在直播。
         缺点：主播端异常crash的情况下是没有办法通知服务器该直播关闭的。
         2、用户http请求该地址，若请求成功表示直播未结束，否则结束
         优点：能够真实的获取主播端是否有推流数据
         缺点：如果主播端丢包率太低，但是能够恢复的情况下，数据请求同样是失败的。
         */
    }
}


#pragma mark UIScrollViewDelegate 此处解决了scrollerview的循环引用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index  = scrollView.contentOffset.y / SCREEN_HEIGHT;
    
    if (index==1) return;
    
    for (NSInteger i = 0; i < self.subViewsArray.count; i ++ ) {
        UIView *subView = self.subViewsArray[i];
        if (index == i) {
            self.showView = subView;
            continue;
        }
        [subView removeFromSuperview];
    }
    [self.subViewsArray removeAllObjects];
   
    self.index = scrollView.contentOffset.y/SCREEN_HEIGHT <1 ? --self.index :++self.index;
    if (self.index<0) {
        self.index = self.modelArray.count - 1;
    }else if (self.index>=self.modelArray.count){
        self.index = 0;
    }
    for (NSInteger i = 0; i < 3; i ++ ) {
        if (i == 1) {
            self.showView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
            [self.subViewsArray addObject: self.showView];
            continue;
        }
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        [self generateDimImage:imageView];
        CGFloat imageY = CGRectGetHeight(self.bounds)*i;
        imageView.frame = CGRectMake(0, imageY, SCREEN_WIDTH , SCREEN_HEIGHT);
        [scrollView addSubview:imageView];
        [self.subViewsArray addObject:imageView];
    }
    scrollView.contentOffset = CGPointMake(0, SCREEN_HEIGHT);

    [_moviePlayer shutdown];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    
    [_messageView removeFromSuperview];
    _messageView = nil;
    
    [self setUpImageWith:self.index];
}

#pragma mark - 获取最新直播URL
-(NSString *)getPlayerURL{
    
    return ((HotModel *)self.modelArray[self.index]).stream_addr;
}


#pragma mark - 懒加载
-(NSMutableArray *)subViewsArray {
    
    if (!_subViewsArray) {
        
        _subViewsArray = [NSMutableArray array];
    }
    
    return _subViewsArray;
}

-(LiveMessageView *)messageView {
    
    if (!_messageView) {
        
        _messageView = [[LiveMessageView alloc]initWithFrame:self.bounds];
    }
    
    return _messageView;
}

-(void)dealloc {
    
    _modelArray = nil;
    [_subViewsArray removeAllObjects];
    _subViewsArray = nil;
    [_messageView removeFromSuperview];
    _messageView = nil;
    [_showView removeFromSuperview];
    _showView = nil;
   
    [_moviePlayer pause];
    [_moviePlayer stop];
     [_moviePlayer shutdown];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"=====LiveRoomRootView====");
}

@end
