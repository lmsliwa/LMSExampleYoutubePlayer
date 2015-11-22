//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSViewModelAssembly.h"
#import "LMSSearchListViewModel.h"
#import "LMSDataClientAssembly.h"


@implementation LMSViewModelAssembly {

}

- (TyphoonDefinition *)searchListViewModel {
    return [TyphoonDefinition withClass:[LMSSearchListViewModel class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataClient) with:self.dataClientAssembly.dataClient];
    }];
}

@end