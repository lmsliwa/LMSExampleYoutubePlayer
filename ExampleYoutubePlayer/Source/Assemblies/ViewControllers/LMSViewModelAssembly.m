//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <HCYoutubeParser/HCYoutubeParser.h>
#import "LMSViewModelAssembly.h"
#import "LMSSearchListViewModel.h"
#import "LMSDataClientAssembly.h"
#import "LMSVideoPreviewViewModel.h"


@implementation LMSViewModelAssembly {

}

- (TyphoonDefinition *)searchListViewModel {
    return [TyphoonDefinition withClass:[LMSSearchListViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataClient) with:self.dataClientAssembly.dataClient];
        [definition performAfterInjections:@selector(injectionsCompleted)];
    }];
}

- (TyphoonDefinition *)videoPreviewViewModel {
    return [TyphoonDefinition withClass:[LMSVideoPreviewViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(youtubeParserClass) with:[HCYoutubeParser class]];
        [definition performAfterInjections:@selector(injectionsCompleted)];
    }];
}

@end