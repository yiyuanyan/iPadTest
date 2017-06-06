//
//  GGT_Singleton.h
//  GoGoTalk
//
//  Created by XieHenry on 2017/4/26.
//  Copyright © 2017年 XieHenry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGT_Singleton : NSObject

+ (GGT_Singleton *)sharedSingleton;
//userToken
@property (nonatomic, copy) NSString *userTokenStr;

//isComplete
@property (nonatomic, copy) NSString *isCompleteStr;

//studentName
@property (nonatomic, copy) NSString *studentNameStr;

//网络状态
@property (nonatomic) BOOL netStatus;

@end
