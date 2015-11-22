//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol LMSYoutubeAPIProtocol <NSObject>

- (RACSignal *)searchVideoForQuery:(NSString *)query;

@end