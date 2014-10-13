//
//  RWCommon.h
//  RailsWeibo
//
//  Created by Rails Chen on 14-10-13.
//  Copyright (c) 2014年 Railsgem. All rights reserved.
//
// 0.账号相关
#define IWAppKey @"3072959680"
#define IWAppSecret @"8fb802d3984f4601cb3683bf232bda83"
#define IWRedirectURI @"https://api.weibo.com/oauth2/default.html"
#define IWLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", IWAppKey, IWRedirectURI]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


// 2.获得RGB颜色
#define RWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define RWLog(...) NSLog(__VA_ARGS__)
#else
#define RWLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上的数据
/** 昵称的字体 */
#define RWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define RWRetweetStatusNameFont RWStatusNameFont

/** 时间的字体 */
#define RWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define RWStatusSourceFont RWStatusTimeFont

/** 正文的字体 */
#define RWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define RWRetweetStatusContentFont RWStatusContentFont

/** 表格的边框宽度 */
#define RWStatusTableBorder 5

/** cell的边框宽度 */
#define RWStatusCellBorder 10


// 6.微博cell相册

#define RWPhotoW 70
#define RWPhotoH 70
#define RWPhotoMargin 10

