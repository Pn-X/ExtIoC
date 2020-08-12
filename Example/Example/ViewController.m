//
//  ViewController.m
//  Example
//
//  Created by hang_pan on 2020/8/12.
//  Copyright © 2020 hang_pan. All rights reserved.
//

#import "ViewController.h"
#import <ExtIoC/ExtIoC.h>
#import "LoggerProtocol.h"
#import "ShareProtocol.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ExtIoC shared] registWithConfigurations:@{
        @"LoggerProtocol":[ExtIoCConfiguration instanceWithClassName:@"Logger"],
        @"ShareProtocol":[ExtIoCSingletonConfiguration instanceWithClassName:@"ShareSDK" selecotor:@"defaultSDK"],
    }];
    
    [ExtIoCMatch(LoggerProtocol) sayBye];
    [ExtIoCMatch(ShareProtocol) shareWithUId:@"1001" params:@"this is param"];
}


@end
