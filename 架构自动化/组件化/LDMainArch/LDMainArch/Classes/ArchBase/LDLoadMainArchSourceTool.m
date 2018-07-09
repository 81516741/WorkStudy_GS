//
//  LDLoadSourceTool.m
//  CocoaLumberjack
//
//  Created by 令达 on 2018/4/4.
//

#import "LDLoadMainArchSourceTool.h"

@implementation LDLoadMainArchSourceTool
+ (UIImage *)getImage:(NSString *)imageName
{
    UIImage * image = [UIImage imageWithContentsOfFile:[self path:imageName]];
    return image;
}

+ (NSString *)path:(NSString *)fileName
{
    NSString * bundlePath = [[NSBundle bundleForClass:self] bundlePath];
    NSString * path = [NSString stringWithFormat:@"%@/LDMainArch.bundle/%@",bundlePath,fileName];
    return path;
}
@end
