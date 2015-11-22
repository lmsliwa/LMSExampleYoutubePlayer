//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSDataClientSupportedProtocols.h"


@interface LMSDataClient : NSObject <LMSDataClientSupportedProtocols>

- (instancetype)initWithBackends:(NSArray *)backends;

@end