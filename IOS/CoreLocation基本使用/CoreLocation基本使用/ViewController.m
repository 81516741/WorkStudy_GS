//
//  ViewController.m
//  CoreLocation基本使用
//
//  Created by Mac on 2017/4/7.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LocationManager startUpdatingLocation:^(CLLocationManager *locationManager, CLLocation * currentLocation,CLLocation * preLocation, NSError *error) {
        
        if (currentLocation.horizontalAccuracy < 180 && currentLocation.horizontalAccuracy != -1) {//保留精度小于180米的有效数据
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"位置信息" message:[NSString stringWithFormat:@"经度:%f\n纬度:%f\n海拔:%f\n速度 %f\n角度:%f\n水平精度:%f\n垂直精度:%f\n行走距离:%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude,currentLocation.altitude,currentLocation.speed,currentLocation.course,currentLocation.horizontalAccuracy,currentLocation.verticalAccuracy,[currentLocation distanceFromLocation:preLocation]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
        
    }];
    
    
}


@end
