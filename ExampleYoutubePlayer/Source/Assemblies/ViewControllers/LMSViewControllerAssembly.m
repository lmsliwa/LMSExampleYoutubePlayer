//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSViewControllerAssembly.h"
#import "TyphoonDefinition.h"
#import "LMSRootViewController.h"
#import "LMSViewModelAssembly.h"


@implementation LMSViewControllerAssembly {

}

- (TyphoonDefinition *)rootViewController {
    return [TyphoonDefinition withClass:[LMSRootViewController class] configuration:^(TyphoonDefinition *definition) {

    }];
}

@end