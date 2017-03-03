//
//  LiveMessageView.m
//  HFTV
//
//  Created by Mr.Zhang on 2017/2/10.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import "LiveMessageView.h"

#import "LiveInfoView.h"

@interface LiveMessageView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)LiveInfoView *infoView;

@end

@implementation LiveMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"GKRoomShowView"];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self addSubview:collectionView];
        
        [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1  inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GKRoomShowView" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row==1) {
        [cell.contentView addSubview:self.infoView];
    }
    
    return cell;
}


-(LiveInfoView *)infoView {
    
    if (!_infoView) {
        
        _infoView = [[[NSBundle mainBundle]loadNibNamed:@"LiveInfoView" owner:self options:nil]objectAtIndex:0];
        _infoView.frame = self.bounds;
    }
    
    return _infoView;
}

-(void)dealloc {
    
    [_infoView removeFromSuperview];
    _infoView = nil;
    NSLog(@"=======LiveMessageView=====");
}

@end
