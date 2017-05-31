//
//  GGT_MineLeftMode.h
//  iPadTest
//
//  Created by 何建新 on 2017/5/31.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGT_MineLeftMode : NSObject
//迟到
@property(nonatomic, copy) NSString *chi;
//缺席
@property(nonatomic, copy) NSString *que;
//已说
@property(nonatomic, copy) NSString *shuo;
//lv
@property(nonatomic, copy) NSString *lv;
//姓名
@property(nonatomic, copy) NSString *Name;
//头像
@property(nonatomic, copy) NSString *ImageUrl;
//剩余课时
@property(nonatomic, copy) NSString *totalCount;
@end
