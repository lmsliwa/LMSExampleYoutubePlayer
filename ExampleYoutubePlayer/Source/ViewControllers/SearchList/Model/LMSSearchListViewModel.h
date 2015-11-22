//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMSDataClient;


@interface LMSSearchListViewModel : NSObject

@property (nonatomic, strong) LMSDataClient *dataClient;

@property (nonatomic, strong) NSString *searchPhrase;

@end