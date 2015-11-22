//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/RLMObject.h>

@interface LMSVideoSearchEntity : RLMObject

@property (nonatomic, strong) NSString *videoId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *thumbnail;

@end