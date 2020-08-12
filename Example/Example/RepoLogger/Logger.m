//
//  Logger.m
//  Example
//
//  Created by hang_pan on 2020/5/9.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (void)logError:(NSString *)string {
    NSLog(@"[Logger] error:%@", string);
}

+ (void)sayBye {
    NSLog(@"[Logger] byebye");
}

@end
