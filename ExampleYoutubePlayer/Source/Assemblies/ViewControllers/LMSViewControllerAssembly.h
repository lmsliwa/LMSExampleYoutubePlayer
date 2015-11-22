//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@class TyphoonDefinition;
@class LMSViewModelAssembly;


@interface LMSViewControllerAssembly : TyphoonAssembly

@property (nonatomic, strong) LMSViewModelAssembly *viewModelAssembly;

- (TyphoonDefinition *)rootViewController;
- (TyphoonDefinition *)searchListViewController;

@end