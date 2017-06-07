//
//  BaseService.m
//  GoGoTalkHD
//
//  Created by 辰 on 16/7/29.
//  Copyright © 2016年 Chn. All rights reserved.
//

#import "BaseService.h"

// 自定义的code
static NSInteger const kErrorCode_1001 = 1001;
static NSInteger const kErrorCode_1002 = 1002;
static BOOL isRefreshToken;


@interface BaseService()

@end

@implementation BaseService

+ (instancetype)share
{
    static BaseService *shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        GGT_Singleton *singleton = [GGT_Singleton sharedSingleton];
        isRefreshToken = NO;
        
        // 1. 获得网络监控管理者
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        
        // 2. 设置网络状态改变后的处理
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            // 当网络状态改变了, 就会调用这个block
            switch (status) {
                case AFNetworkReachabilityStatusUnknown: // 未知网络
                    self.netWorkStaus = AFNetworkReachabilityStatusUnknown;
                    singleton.netStatus = NO;
#ifdef DEBUG
                    [self showExceptionDialog:@"未知网络"];
#endif
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                    self.netWorkStaus = AFNetworkReachabilityStatusNotReachable;
                    singleton.netStatus = NO;
                    
#ifdef DEBUG
                    [self showExceptionDialog:@"没有网络(断网)"];
#endif
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                    self.netWorkStaus = AFNetworkReachabilityStatusReachableViaWWAN;
                    singleton.netStatus = YES;
                    
#ifdef DEBUG
                    [self showExceptionDialog:@"手机自带网络"];
#endif
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                    self.netWorkStaus = AFNetworkReachabilityStatusReachableViaWiFi;
                    singleton.netStatus = YES;
                    
#ifdef DEBUG
                    [self showExceptionDialog:@"WIFI"];
#endif
                    break;
            }
        }];
        
        // 3.开始监控
        [mgr startMonitoring];
        
    }
    return self;
}

#pragma mark - public method
#pragma mark 不带 参数加密
- (void)requestWithPath:(NSString *)urlStr
                 method:(NSInteger)method
             parameters:(id)parameters
                  token:(BOOL)isLoadToken
         viewController:(UIViewController *)viewController
                success:(AFNSuccessResponse)success
                failure:(AFNFailureResponse)failure
{
    
    self.manager = [AFHTTPSessionManager manager];
    NSString *pinjieUrlStr = urlStr;
    
    urlStr = [BASE_REQUEST_URL stringByAppendingPathComponent:urlStr];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSLog(@"打印token----%@",[UserDefaults() objectForKey:K_userToken]);
    [MBProgressHUD hideHUDForView:viewController.view];
    [MBProgressHUD showLoading:viewController.view];
    
    switch (method) {
        case XCHttpRequestGet:
        {
            
            self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"charset=utf-8", nil];
            
            if (isLoadToken == YES) {
                //可不写，但是不能写在判断外，否则会出错
                //self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                //在设置header头
                [self.manager.requestSerializer setValue:[UserDefaults() objectForKey:K_userToken] forHTTPHeaderField:@"Authorization"];
            }
            
            
            [self.manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [MBProgressHUD hideHUDForView:viewController.view];
                
                NSDictionary *dic = responseObject;
                if ([[dic objectForKey:xc_returnCode]integerValue] == 1)
                {
                    success(responseObject);
                    NSLog(@"%@-Get请求地址:\n%@---success日志:\n%@",[viewController class],urlStr,responseObject);
                    
                } else if ([[dic objectForKey:xc_returnCode]integerValue] == 1000) {
                    NSLog(@"%@-Get请求地址:\n%@---登陆过期日志:\n%@",[viewController class],urlStr,responseObject);
                    [self refreshToken:pinjieUrlStr method:method parameters:parameters token:isLoadToken viewController:viewController success:success failure:failure];
                    
                    return ;
                    
                } else {
                    NSError *error;
                    if ([dic objectForKey:xc_returnMsg] && [dic objectForKey:xc_returnCode]) {
                        error = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:[dic objectForKey:xc_returnMsg], xc_returnCode:[dic objectForKey:xc_returnCode]}];
                    } else {
                        error = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1002 userInfo:@{xc_message:xc_alert_message}];
                    }
                    failure(error);
                    
                    NSLog(@"%@-Get请求地址:\n%@---success日志:\n%@",[viewController class],urlStr,error);
                    //                    NSDictionary *userInfoDic = error.userInfo;
                    //                    [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
                    
                    //暂时不需要进行跳转处理，因为有的状态是提醒。
                    // [self performSelector:@selector(turnToHomeClick:) withObject:viewController afterDelay:0.0f];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:viewController.view];
                failure(error);
                NSLog(@"%@-Get请求地址:\n%@---error日志:\n%@",[viewController class],urlStr,error);
                
#ifdef DEBUG
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1002 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#else
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#endif
                
            }];
        }
            break;
        case XCHttpRequestPost:
        {
            
            self.manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
            
            if (isLoadToken == YES) {
                //在设置header头
                [self.manager.requestSerializer setValue:[UserDefaults() objectForKey:K_userToken] forHTTPHeaderField:@"Authorization"];
            }
            
            [self.manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [MBProgressHUD hideHUDForView:viewController.view];
                
                
                NSDictionary *dic = responseObject;
                if ([[dic objectForKey:xc_returnCode]integerValue] == 1)
                {
                    success(responseObject);
                    NSLog(@"%@-Post请求地址:\n%@---success日志:\n%@",[viewController class],urlStr,responseObject);
                    
                }  else if ([[dic objectForKey:xc_returnCode]integerValue] == 1000) {
                    NSLog(@"%@-Post请求地址:\n%@---登陆过期日志:\n%@",[viewController class],urlStr,responseObject);
                    
                    [self refreshToken:pinjieUrlStr method:method parameters:parameters token:isLoadToken viewController:viewController success:success failure:failure];
                    
                    return ;
                    
                }
                else {
                    NSError *error;
                    if ([dic objectForKey:xc_returnMsg] && [dic objectForKey:xc_returnCode]) {
                        error = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:[dic objectForKey:xc_returnMsg], xc_returnCode:[dic objectForKey:xc_returnCode]}];
                    } else {
                        error = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1002 userInfo:@{xc_message:xc_alert_message}];
                    }
                    
                    failure(error);
                    NSLog(@"%@-Post请求地址:\n%@---success日志:\n%@",[viewController class],urlStr,error);
                    
                    //                    NSDictionary *userInfoDic = error.userInfo;
                    //                    [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
                    
                    //暂时不需要进行跳转处理，因为有的状态是提醒。
                    //[self performSelector:@selector(turnToHomeClick:) withObject:viewController afterDelay:0.0f];
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [MBProgressHUD hideHUDForView:viewController.view];
                
                failure(error);
                NSLog(@"%@-Post请求地址:\n%@---error日志:\n%@",[viewController class],urlStr,error);
                
                
#ifdef DEBUG
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1002 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#else
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#endif
                
            }];
        }
            break;
        case XCHttpRequestDelete:
        {
            [self.manager DELETE:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:viewController.view];
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:viewController.view];
                failure(error);
#ifdef DEBUG
                NSDictionary *userInfoDic = error.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#else
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#endif
            }];
        }
            break;
        case XCHttpRequestPut:
        {
            [self.manager PUT:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:viewController.view];
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:viewController.view];
                failure(error);
#ifdef DEBUG
                NSDictionary *userInfoDic = error.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#else
                NSError *newError = [[NSError alloc]initWithDomain:@"com.gogo-talk.GoGoTalk" code:1001 userInfo:@{xc_message:xc_alert_message}];
                NSDictionary *userInfoDic = newError.userInfo;
                [MBProgressHUD showMessage:userInfoDic[xc_message] toView:viewController.view];
#endif
            }];
        }
            break;
            
        default:
            break;
    }
}


- (void)sendPostRequestWithPath:(NSString *)url
                     parameters:(NSDictionary *)parameters
                          token:(BOOL)isLoadToken
                 viewController:(UIViewController *)viewController
                        success:(AFNSuccessResponse)success
                        failure:(AFNFailureResponse)failure
{
    [self requestWithPath:url method:XCHttpRequestPost parameters:parameters token:isLoadToken viewController:viewController success:success failure:failure];
}

- (void)sendGetRequestWithPath:(NSString *)url
                         token:(BOOL)isLoadToken
                viewController:(UIViewController *)viewController
                       success:(AFNSuccessResponse)success
                       failure:(AFNFailureResponse)failure
{
    [self requestWithPath:url method:XCHttpRequestGet parameters:nil token:isLoadToken viewController:viewController success:success failure:failure];
}



#pragma mark - private method
#pragma mark 弹出网络错误提示框
- (void)showExceptionDialog:(NSString *)message
{
    NSLog(@"%@", message);
}

#pragma mark 弹出网络错误提示框2----暂时不用，替换成了MBProgressHUD
- (void)alertErrorMessage:(NSError *)error
{
    NSDictionary *userInfoDic = error.userInfo;
    UIAlertView *alertV = [[UIAlertView alloc]initWithTitle:@"" message:userInfoDic[xc_message] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertV show];
    
}

- (void)refreshToken:(NSString *)url method:(NSInteger)method parameters:(id)parameters token:(BOOL)isLoadToken viewController:(UIViewController *)viewController success:(AFNSuccessResponse)success
             failure:(AFNFailureResponse)failure{
    
    NSDictionary *postDic = @{@"UserName":[UserDefaults() objectForKey:@"phoneNumber"],@"PassWord":[UserDefaults() objectForKey:@"password"],@"OrgLink":@""};
    
    
    GGT_Singleton *singleton = [GGT_Singleton sharedSingleton];
    
    //使用af原生请求，防止弹出MBProgressHUD动画。
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSString *urlStr = [BASE_REQUEST_URL stringByAppendingPathComponent:URL_Login];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    [self.manager POST:urlStr parameters:postDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"result"] isEqual:@1]) {

            dispatch_async(dispatch_get_main_queue(), ^{
            
                singleton.userTokenStr = responseObject[@"data"][@"dicRes"][@"userToken"];
                singleton.studentNameStr = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"dicRes"][@"studentName"]];
                
                [UserDefaults() setObject:responseObject[@"data"][@"dicRes"][@"userToken"] forKey:K_userToken];
                [UserDefaults() setObject:[NSString stringWithFormat:@"%@",responseObject[@"data"][@"dicRes"][@"studentName"]] forKey:K_studentName];
                [UserDefaults() synchronize];
  
            //重新请求
            [self requestWithPath:url method:method parameters:parameters token:isLoadToken viewController:viewController success:success failure:failure];
                
   });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark token过期，重新登录
- (void)turnToHomeClick :(UIViewController *)viewController {
    [MBProgressHUD showMessage:@"登录过期，请重新登录" toView:viewController.view];
    
    [self performSelector:@selector(turnToLoginClick:) withObject:viewController afterDelay:1.0f];
    
}

- (void)turnToLoginClick :(UIViewController *)viewController{
    GGT_LoginViewController *loginVc = [[GGT_LoginViewController alloc]init];
    BaseNavigationController *mainVc = [[BaseNavigationController alloc]initWithRootViewController:loginVc];
    viewController.view.window.rootViewController = mainVc;
}


@end
