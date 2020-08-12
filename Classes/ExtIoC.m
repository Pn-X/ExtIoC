//
//  ExtIoC.m
//  Pods-Example
//
//  Created by hang_pan on 2020/5/9.
//

#import "ExtIoC.h"

@implementation ExtIoCConfiguration

+ (instancetype)instanceWithClassName:(NSString *)className {
    ExtIoCConfiguration *obj = [[self alloc] init];
    obj.className = className;
    return obj;
}

@end
 
@implementation ExtIoCObjectConfiguration
+ (instancetype)instanceWithClassName:(NSString *)className selecotor:(nullable NSString *)selector {
    return [self instanceWithClassName:className selecotor:selector block:nil];
}

+ (instancetype)instanceWithClassName:(NSString *)className block:(nullable id(^)(id params))block {
    return [self instanceWithClassName:className selecotor:nil block:block];
}

+ (instancetype)instanceWithClassName:(NSString *)className selecotor:(nullable NSString *)selector block:(nullable id(^)(id params))block {
    ExtIoCObjectConfiguration *obj = [[self alloc] init];
    obj.className = className;
    obj.selector = selector;
    obj.block = block;
    return obj;
}

@end

@implementation ExtIoCSingletonConfiguration

@end

@interface ExtIoC ()

@property (nonatomic, strong) NSMutableDictionary *configurationMap;
@property (nonatomic, strong) NSArray *selectors;

@end

@implementation ExtIoC

+ (instancetype)shared {
    static ExtIoC *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [ExtIoC new];
    });
    return obj;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.configurationMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setupSingletonSelectors:(NSArray *)selectors {
    if (selectors.count == 0) {
        self.selectors = @[@"singleton", @"shared"];
        return;
    }
    self.selectors = selectors;
}

- (void)registWithConfigurations:(NSDictionary <NSString *, ExtIoCConfiguration *>*)configurations {
    [self.configurationMap addEntriesFromDictionary:configurations];
}

- (void)unregistConfigurationsForProtocol:(NSString *)protocol {
    [self.configurationMap removeObjectForKey:protocol];
}

- (ExtIoCConfiguration *)configurationForProtocol:(NSString *)protocol {
    return self.configurationMap[protocol];
}

- (__nullable id)matchWithProtocol:(Protocol *)protocol params:(id)params {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSString *name = NSStringFromProtocol(protocol);
    ExtIoCSingletonConfiguration *configuration = self.configurationMap[name];
    if (!configuration) {
        return nil;
    }
    id object = nil;
    Class cls = NSClassFromString(configuration.className);
    if (!cls) {
        return nil;
    }
    if ([configuration isKindOfClass:[ExtIoCSingletonConfiguration class]]) {
        SEL selector = NSSelectorFromString(configuration.selector);
        if (configuration.block) {
            return configuration.block(params);
        }
        if (selector) {
            if (__builtin_expect((strchr(sel_getName(selector), ':') == NULL), 1)) {
                object = [cls performSelector:selector];
            } else {
                object = [cls performSelector:selector withObject:params];
            }
        } else {
            for (NSString *s in self.selectors) {
                if ([cls respondsToSelector:NSSelectorFromString(s)]) {
                    object = [cls performSelector:NSSelectorFromString(s)];
                    break;
                }
            }
        }
        return object;
    }
    if ([configuration isKindOfClass:[ExtIoCObjectConfiguration class]]) {
        SEL selector = NSSelectorFromString(configuration.selector);
        if (configuration.block) {
            return configuration.block(params);
        }
        if (selector) {
            if (__builtin_expect((strchr(sel_getName(selector), ':') != NULL), 1)) {
                object = [[cls alloc] performSelector:selector withObject:params];
            } else {
                object = [[cls alloc] performSelector:selector];
            }
        } else {
            object = [[cls alloc] init];
        }
        return object;
    }
    if ([configuration isKindOfClass:[ExtIoCConfiguration class]]) {
        return cls;
    }
#pragma clang diagnostic pop
    return nil;
}
@end
