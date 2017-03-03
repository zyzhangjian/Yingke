//
//  LiveRoomRootView.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/2/10.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveRoomRootView : UIView

//房间数组
@property(nonatomic,strong)NSArray *modelArray;

//当前房间位置
@property(nonatomic,assign)NSInteger index;

@end
