//
//  LocationManager.h
//  CoreLocation基本使用
//
//  Created by Mac on 2017/4/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject

/**
 请求位置信息授权
 */
+ (void)requestLocationAuthority:(void(^)(CLLocationManager * locationManager,CLAuthorizationStatus status)) authorityResultBlock;

/**
 开始更新位置

 @param locationResultBlock 返回位置信息的block
 */
+ (void)startUpdatingLocation:(void(^)(CLLocationManager * locationManager,CLLocation * currentLocation,CLLocation * preLocation,NSError * error)) locationResultBlock;

@end
