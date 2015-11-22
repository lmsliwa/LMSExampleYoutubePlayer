//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSDataClient.h"

@interface LMSDataClient ()

@property (nonatomic, strong) NSArray *backends;

@end

@implementation LMSDataClient {

}

- (instancetype)initWithBackends:(NSArray *)backends {
    self == [super init];
    if (self) {
        self.backends = backends;
    }
    return self;
}

#pragma mark - Call forwarding

/**
 * We check if any backend support call than forward call to it (order of backends is important!)
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (NSObject *backend in self.backends) {
        if ([backend respondsToSelector:aSelector]) {
            return backend;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end