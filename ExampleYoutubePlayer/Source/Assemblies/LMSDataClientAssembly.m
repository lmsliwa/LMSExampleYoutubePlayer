//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSDataClientAssembly.h"
#import "LMSNetworkBackend.h"
#import "AFHTTPSessionManager.h"
#import "TyphoonConfigPostProcessor.h"
#import "LMSDataClient.h"


@implementation LMSDataClientAssembly {

}

- (TyphoonDefinition *)dataClient {
    return [TyphoonDefinition withClass:[LMSDataClient class] configuration:^(TyphoonDefinition *definition) {
       [definition useInitializer:@selector(initWithBackends:) parameters:^(TyphoonMethod *initializer) {
           [initializer injectParameterWith:@[self.externalNetworkBackend]];
       }];
        definition.scope = TyphoonScopeSingleton;
    }];
}

- (TyphoonDefinition *)externalNetworkBackend {
    return [TyphoonDefinition withClass:[LMSNetworkBackend class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(sessionManager) with:[self sessionManager]];
        [definition performAfterInjections:@selector(injectionsCompleted)];
    }];
}

- (TyphoonDefinition *)sessionManager {
    return [TyphoonDefinition withClass:[AFHTTPSessionManager class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(baseURL) with:TyphoonConfig(@"network.baseURL")];
    }];
}

@end