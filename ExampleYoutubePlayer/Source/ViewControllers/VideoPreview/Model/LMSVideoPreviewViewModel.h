//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LMSDataClient;
@class LMSVideoSearchEntity;
@class HCYoutubeParser;


@interface LMSVideoPreviewViewModel : NSObject

@property (nonatomic, strong) Class youtubeParserClass;

@property (nonatomic, strong) LMSVideoSearchEntity *videoSearchEntity;
@property (nonatomic, strong) NSURL *videoURL;

@end