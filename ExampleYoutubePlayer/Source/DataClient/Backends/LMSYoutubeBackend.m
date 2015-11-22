//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Realm/RLMRealm.h>
#import "LMSYoutubeBackend.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPSessionManager+RACSupport.h"
#import "RLMObject+JSON.h"
#import "LMSVideoSearchEntity.h"


@implementation LMSYoutubeBackend {

}

/**
 * Do some more customisation after all dependencies are injected
 */
- (void)injectionsCompleted {

}

#pragma mark - API Protocol

- (RACSignal *)searchVideoForQuery:(NSString *)query {
    AFHTTPSessionManager *sessionManager = self.sessionManager;
    NSDictionary *paramDict = @{
            @"part" : @"snippet",
            @"key" : self.apiKey,
            @"q" : query
    };

    RACSignal *requestSignal = [sessionManager rac_GET:@"search/" parameters:paramDict];
    requestSignal = [[requestSignal map:^id(RACTuple *tuple) {
        RACTupleUnpack(NSDictionary *JSONResponse) = tuple;
        NSArray *items = JSONResponse[@"items"];
        __block NSArray *entities = nil;
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            entities = [LMSVideoSearchEntity createOrUpdateInRealm:[RLMRealm defaultRealm] withJSONArray:items];
        }];
        return entities;
    }] catch:^RACSignal *(NSError *error) {
        return [RACSignal error:error];
    }];

    return requestSignal;
}


@end