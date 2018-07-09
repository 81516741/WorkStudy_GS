//
//  LDMacro.h
//  MainArch
//
//  Created by 令达 on 2018/3/27.
//  Copyright © 2018年 81516741@qq.com. All rights reserved.
//

#ifndef LDMacro_h
#define LDMacro_h


/**********CoCoaLumberJack框架****************/
//#define LOG_LEVEL_DEF ddLogLevel
//#import "CocoaLumberjack.h"
//
//#ifdef DEBUG
//static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
//#else
//static const DDLogLevel ddLogLevel = DDLogLevelError;
//#endif
//
//#ifdef DEBUG
//#define LDLOG(format, ...) DDLogError((@"日志:[文件名:%@]""[方法:%s]""[行号:%d] -- " format), [[NSString stringWithUTF8String:__FILE__] lastPathComponent],__PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
//#else
//#define LDLOG(...)
//#endif

/**********颜色****************/
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBS(rgb) RGB(rgb,rgb,rgb)
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define HEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**********通知****************/
#define NOTIFICATIONOBSERVER(sel,notiName) [[NSNotificationCenter defaultCenter] addObserver:self selector:sel name:notiName object:nil];
#define NOTIFICATIONPOST(notiName) [[NSNotificationCenter defaultCenter]postNotificationName:notiName object:nil];
#define NOTIFICATIONPOSTOBJ(notiName,object1) [[NSNotificationCenter defaultCenter]postNotificationName:notiName object:object1];

/**********UI****************/
#define SCREENWIDTH            SCREENBOUNDS.size.width
#define SCREENHEIGHT           SCREENBOUNDS.size.height
#define SCREENBOUNDS           [UIScreen mainScreen].bounds
#define PIXEL                  (1/[UIScreen mainScreen].scale)
#define SCALESIZE(size)        ((SCREENWIDTH/320) * size)
#define WINDOW                 [UIApplication  sharedApplication].delegate.window


/**********字符串****************/
#define STRINGISEMPTY(string) ([string stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 || [string isEqualToString:@"(null)"] || [string isEqualToString:@"NSNull"])


#endif /* LDMacro_h */
