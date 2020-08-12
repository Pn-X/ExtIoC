//
//  ExtIoC.h
//  Pods-Example
//
//  Created by hang_pan on 2020/5/9.
//

#import <Foundation/Foundation.h>

#define ExtIoCMatch(ProtocolName,...)   ({\
                                            id<ProtocolName>object = nil;\
                                            NSArray *array = [NSArray arrayWithObjects:@"",##__VA_ARGS__,nil];\
                                            if (array.count >= 2) {\
                                                object = (id<ProtocolName>)[[ExtIoC shared] matchWithProtocol:@protocol(ProtocolName) params:array[1]];\
                                            } else {\
                                                object = (id<ProtocolName>)[[ExtIoC shared] matchWithProtocol:@protocol(ProtocolName) params:@{}];\
                                            }\
                                            object;\
                                        })
NS_ASSUME_NONNULL_BEGIN

@interface ExtIoCConfiguration : NSObject

@property (nonatomic, strong) NSString *className;

+ (instancetype)instanceWithClassName:(NSString *)clsName;

@end

@interface ExtIoCObjectConfiguration : ExtIoCConfiguration

//support method 0 or 1 argument eg: instance / initWithData:
@property (nonatomic, strong, nullable) NSString *selector;

@property (nonatomic, strong, nullable) id(^block)(id params);

+ (instancetype)instanceWithClassName:(NSString *)className selecotor:(nullable NSString *)selector;

+ (instancetype)instanceWithClassName:(NSString *)className block:(nullable id(^)(id params))block;

+ (instancetype)instanceWithClassName:(NSString *)className selecotor:(nullable NSString *)selector block:(nullable id(^)(id params))block;

@end

@interface ExtIoCSingletonConfiguration : ExtIoCObjectConfiguration

@end

@interface ExtIoC : NSObject

+ (instancetype)shared;

- (void)setupSingletonSelectors:(NSArray <NSString *>*)selectors;

- (void)registWithConfigurations:(NSDictionary <NSString *, ExtIoCConfiguration *>*)configurations;

- (void)unregistConfigurationsForProtocol:(NSString *)protocol;

- (ExtIoCConfiguration *)configurationForProtocol:(NSString *)protocol;

- (__nullable id)matchWithProtocol:(Protocol *)protocol params:(id)params;

@end

NS_ASSUME_NONNULL_END
