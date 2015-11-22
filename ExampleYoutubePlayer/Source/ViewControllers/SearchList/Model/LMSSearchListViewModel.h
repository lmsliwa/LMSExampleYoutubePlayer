//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@class LMSDataClient;
@class RACSignal;


@interface LMSSearchListViewModel : NSObject <UITableViewDataSource>

@property (nonatomic, strong) LMSDataClient *dataClient;

@property (nonatomic, strong) NSString *searchPhrase;
@property (nonatomic, strong) RACSignal *tableListNeedReload;
@property (nonatomic, assign) BOOL isLoading;

/**
 * Return associated entity for table indexpath (in this case - LMSVideoSearchEntity)
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath;

@end