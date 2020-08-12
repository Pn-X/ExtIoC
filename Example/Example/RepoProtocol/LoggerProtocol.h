//
//  LoggerProtocol.h
//  Example
//
//  Created by hang_pan on 2020/5/9.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#ifndef LoggerProtocol_h
#define LoggerProtocol_h

#import <Foundation/Foundation.h>

@protocol LoggerProtocol <NSObject>

+ (void)logError:(NSString *)string;

+ (void)sayBye;

@end

#endif /* LoggerProtocol_h */
