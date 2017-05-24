//
//  GGT_Request_URL.h
//  iPadTest
//
//  Created by 何建新 on 2017/5/24.
//  Copyright © 2017年 何建新. All rights reserved.
//

#ifndef GGT_Request_URL_h
#define GGT_Request_URL_h
static NSString * const BASE_REQUEST_URL = @"http://learnapi.gogo-talk.com:9332";

//注册
static NSString * const URL_Resigt = @"/api/APP/AppRegist";
//登录
static NSString * const URL_Login = @"/api/APP/AppLogin";
//发送短信验证码
static NSString * const URL_GetChangePasswordSMS = @"/api/APP/AppSendChangePwdSMS";
//修改密码
static NSString * const URL_ChangePwdByCode = @"/api/APP/AppChangePwdByCode";
/*
 我的页面API
 */
//修改密码-根据旧密码修改新密码
static NSString * const URL_ChangePwdByOldPwd = @"/api/APP/AppChangePwdByOldPwd";
//获取学生信息列表
static NSString * const URL_GetStudentInfo = @"/api/APP/AppGetStudentInfo";
//修改学生信息列表
static NSString * const URL_UpdateStudentInfo = @"/api/APP/AppUpdateStudentInfo";

#endif /* GGT_Request_URL_h */
