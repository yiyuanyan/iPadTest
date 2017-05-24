//
//  BaseService.h
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^AFNSuccessResponse)(id responseObject);
typedef void(^AFNFailureResponse)(NSError *error);
typedef void(^AFNBOOLResponse)(BOOL result);

typedef NS_ENUM(NSInteger, HttpRequestType) {
    XCHttpRequestGet,
    XCHttpRequestPost,
    XCHttpRequestDelete,
    XCHttpRequestPut,
};


@interface BaseService : NSObject

/** 网络状态 */
@property (nonatomic, assign) AFNetworkReachabilityStatus netWorkStaus;

// 请求管理者
@property (strong, nonatomic) AFHTTPSessionManager *manager;

+ (instancetype)share;

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                  token:(BOOL)isLoadToken
         viewController:(UIViewController *)viewController
                success:(AFNSuccessResponse)success
                failure:(AFNFailureResponse)failure;

#pragma mark - POST
- (void)sendPostRequestWithPath:(NSString *)url
                     parameters:(NSDictionary *)parameters
                          token:(BOOL)isLoadToken
                 viewController:(UIViewController *)viewController
                        success:(AFNSuccessResponse)success
                        failure:(AFNFailureResponse)failure;

#pragma mark - GET
- (void)sendGetRequestWithPath:(NSString *)url
                viewController:(UIViewController *)viewController
                       success:(AFNSuccessResponse)success
                       failure:(AFNFailureResponse)failure;



@end
