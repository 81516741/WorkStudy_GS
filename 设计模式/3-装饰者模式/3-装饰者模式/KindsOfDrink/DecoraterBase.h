//
//  DecoraterBase.h
//  3-装饰者模式
//
//  Created by ld on 16/11/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "OriginComponent.h"

@interface DecoraterBase : OriginComponent
+(DecoraterBase *)decorate:(OriginComponent *)originObject;
+(DecoraterBase *)moveDecorate:(OriginComponent *)originObject;


@end
