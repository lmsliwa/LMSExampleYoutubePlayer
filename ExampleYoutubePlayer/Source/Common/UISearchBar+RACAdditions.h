//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@class RACSignal;

@interface UISearchBar (RACAdditions)
- (RACSignal *)rac_textSignal;
@end