//
//  ShareSDK.m
//  Example
//
//  Created by hang_pan on 2020/8/12.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#import "ShareSDK.h"
#import <ExtIoC/ExtIoC.h>
#import "LoggerProtocol.h"

@implementation ShareSDK

+ (instancetype)defaultSDK {
    static ShareSDK *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [ShareSDK new];
    });
    return obj;
}

- (void)shareWithUId:(NSString *)UID params:(id)params {
    NSLog(@"[ShareSdk] sharing");
    [ExtIoCMatch(LoggerProtocol) logError:[NSString stringWithFormat:@"uid:%@, params:%@", UID, params]];
}

@end
