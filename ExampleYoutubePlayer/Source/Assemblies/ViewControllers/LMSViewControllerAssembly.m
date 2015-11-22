//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSViewControllerAssembly.h"
#import "TyphoonDefinition.h"
#import "LMSRootViewController.h"
#import "LMSViewModelAssembly.h"
#import "LMSSearchListViewController.h"
#import "TyphoonStoryboard.h"
#import "LMSVideoPreviewViewController.h"


@implementation LMSViewControllerAssembly {

}

- (TyphoonDefinition *)rootViewController {
    return [TyphoonDefinition withClass:[LMSRootViewController class] configuration:^(TyphoonDefinition *definition) {
    }];
}

- (TyphoonDefinition *)searchListViewController {
    return [TyphoonDefinition withClass:[LMSSearchListViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(viewModel) with:self.viewModelAssembly.searchListViewModel];
    }];
}

- (TyphoonDefinition *)videoPreviewViewController {
    return [TyphoonDefinition withClass:[LMSVideoPreviewViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(viewModel) with:self.viewModelAssembly.videoPreviewViewModel];
    }];
}

@end