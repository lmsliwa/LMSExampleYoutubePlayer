//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMSYoutubeAPIProtocol.h"

@class AFHTTPSessionManager;


@interface LMSYoutubeBackend : NSObject <LMSYoutubeAPIProtocol>

@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end