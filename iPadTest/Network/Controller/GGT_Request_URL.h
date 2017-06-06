//
//  GGT_Request_URL.h
//  GoGoTalkHD
//
//  Created by 辰 on 2017/5/10.
//  Copyright © 2017年 Chn. All rights reserved.
//

#ifndef GGT_Request_URL_h
#define GGT_Request_URL_h

static NSString * const BASE_REQUEST_URL = @"http://learnapi.gogo-talk.com:9332";
//static NSString * const BASE_REQUEST_URL = @"http://yiyuanyan.f3322.org:8000/index.php/Index/index/get_categorys";

/*登录注册*/
//注册
static NSString * const URL_Resigt = @"/api/APP/AppRegist";
//登录
static NSString * const URL_Login = @"/api/APP/AppLogin";
//app 发送短信验证码
static NSString * const URL_GetChangePasswordSMS = @"/api/APP/AppSendChangePwdSMS";
//修改密码（根据手机号修改密码）
static NSString * const URL_ChangePwdByCode = @"/api/APP/AppChangePwdByCode";


/*我的*/
//修改密码（根据旧密码修改新密码）
static NSString * const URL_ChangePwdByOldPwd = @"/api/APP/AppChangePwdByOldPwd";
//获取学生信息列表
static NSString * const URL_GetStudentInfo = @"/api/APP/AppGetStudentInfo";
//修改学生信息列表
static NSString * const URL_UpdateStudentInfo = @"/api/APP/AppUpdateStudentInfo";
//获取课程统计信息
static NSString * const URL_GetLessonStatistics = @"/api/APP/GetLessonStatistics";
//获取我的课时
static NSString * const URL_GetMyClassHour = @"/api/APP/GetMyClassHour";
//意见反馈接口
static NSString * const URL_OpinionFeedback = @"/api/APP/OpinionFeedback";







// 日历Calendar
static NSString * const URL_LessonList = @"api/APP/AppStuLessonList";

// 日历下面数据Course
static NSString * const URL_GetMyLesson = @"api/APP/AppGetMyLesson";

// 学生对教师的评价
static NSString * const URL_AppStudentEvaluateTeacher = @"api/APP/AppStudentEvaluateTeacher";

// 取消约课
static NSString * const URL_DelLesson = @"api/APP/DelLesson";

// 预约试听课
static NSString * const URL_AddDemoMsg = @"api/APP/AddDemoMsg";


#endif /* GGT_Request_URL_h */
