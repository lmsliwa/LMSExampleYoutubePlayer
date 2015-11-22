//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSDataClientAssembly.h"
#import "LMSYoutubeBackend.h"
#import "AFHTTPSessionManager.h"
#import "TyphoonConfigPostProcessor.h"
#import "LMSDataClient.h"


@implementation LMSDataClientAssembly {

}

- (TyphoonDefinition *)dataClient {
    return [TyphoonDefinition withClass:[LMSDataClient class] configuration:^(TyphoonDefinition *definition) {
       [definition useInitializer:@selector(initWithBackends:) parameters:^(TyphoonMethod *initializer) {
           [initializer injectParameterWith:@[self.youtubeBackend]];
       }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (TyphoonDefinition *)youtubeBackend {
    return [TyphoonDefinition withClass:[LMSYoutubeBackend class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(apiKey) with:TyphoonConfig(@"youtube.apiKey")];
        [definition injectProperty:@selector(sessionManager) with:[self sessionManagerWithURL:TyphoonConfig(@"youtube.baseURL")]];
        [definition performAfterInjections:@selector(injectionsCompleted)];
    }];
}

- (TyphoonDefinition *)sessionManagerWithURL:(id)url {
    return [TyphoonDefinition withClass:[AFHTTPSessionManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(baseURL) with:url];
    }];
}

@end