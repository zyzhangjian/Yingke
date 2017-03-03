//
//  LiveRoomViewController.h
//  HFTV
//
//  Created by Mr.Zhang on 2017/1/23.
//  Copyright © 2017年 Mr.Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotModel.h"



@interface LiveRoomViewController : UIViewController

//模型所有数组
@property(nonatomic,strong)NSArray *modelArray;

//当前房间model
@property(nonatomic,strong)HotModel *nowRoomModel;

//当前房间位置
@property(nonatomic,assign)NSInteger index;



@end
