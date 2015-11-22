//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@class LMSDataClientAssembly;


@interface LMSViewModelAssembly : TyphoonAssembly

@property (nonatomic, strong) LMSDataClientAssembly *dataClientAssembly;

- (TyphoonDefinition *)searchListViewModel;

@end