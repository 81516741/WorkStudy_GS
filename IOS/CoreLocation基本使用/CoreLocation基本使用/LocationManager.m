//
//  LocationManager.m
//  CoreLocation基本使用
//
//  Created by Mac on 2017/4/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager * clLocationManager;
@property(nonatomic,strong)CLLocation * preLocation;
@property(nonatomic,copy) void(^locationResultBlock)(CLLocationManager * locationManager,CLLocation * currentLocation,CLLocation * preLocation,NSError * error);
@property(nonatomic,copy)void (^authorityResultBlock)(CLLocationManager * locationManager, CLAuthorizationStatus status);


@end

@implementation LocationManager

+ (instancetype)instance
{
    static LocationManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LocationManager new];
        // 创建位置管理者对象
        instance.clLocationManager = [[CLLocationManager alloc] init];
        instance.clLocationManager.delegate = instance; // 设置代理
        // 设置定位距离过滤参数 (当本次定位和上次定位之间的距离大于或等于这个值时，调用代理方法)
        instance.clLocationManager.distanceFilter = 10;
        instance.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest; // 设置定位精度(精度越高越耗电)
    });
    return instance;
}

+ (void)requestLocationAuthority:(void (^)(CLLocationManager *, CLAuthorizationStatus))authorityResultBlock
{
    [LocationManager instance].authorityResultBlock = authorityResultBlock;
    if ([[LocationManager instance].clLocationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [[LocationManager instance].clLocationManager requestAlwaysAuthorization];
    }
    // iOS9.0+ 要想继续获取位置，需要使用以下属性进行设置（注意勾选后台模式：location）但会出现蓝条
    if ([[LocationManager instance].clLocationManager respondsToSelector:@selector(allowsBackgroundLocationUpdates)]) {
        [LocationManager instance].clLocationManager.allowsBackgroundLocationUpdates = YES;
    }
}

/** 定位服务状态改变时调用*/
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (self.authorityResultBlock) {
        self.authorityResultBlock(manager, status);
    }
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定授权");
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
        case kCLAuthorizationStatusDenied:
        {
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

+ (void)startUpdatingLocation:(void (^)(CLLocationManager *, CLLocation *,CLLocation *,NSError *))locationInfoBlock
{
    //判断是否打开了位置服务
    if ([CLLocationManager locationServicesEnabled]) {
        [LocationManager instance].locationResultBlock = locationInfoBlock;
        [[LocationManager instance].clLocationManager startUpdatingLocation]; // 开始更新位置
    }
}

/** 获取到新的位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (self.locationResultBlock) {
        self.locationResultBlock(manager, locations.lastObject,self.preLocation, nil);
    }
    self.preLocation = locations.lastObject;
    NSLog(@"定位到了");
}

/** 不能获取位置信息时调用*/
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (self.locationResultBlock) {
        self.locationResultBlock(manager,nil,nil,error);
    }
    NSLog(@"获取定位失败");
}

@end
