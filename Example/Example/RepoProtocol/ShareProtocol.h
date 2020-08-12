//
//  ShareProtocol.h
//  Example
//
//  Created by hang_pan on 2020/8/12.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#ifndef ShareProtocol_h
#define ShareProtocol_h
#import <Foundation/Foundation.h>

@protocol ShareProtocol <NSObject>

- (void)shareWithUId:(NSString *)UID params:(id)params;

@end

#endif /* ShareProtocol_h */
