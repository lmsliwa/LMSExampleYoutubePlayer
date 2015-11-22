//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "RLMObject+Copying.h"
#import "LMSVideoSearchEntity.h"


@implementation LMSVideoSearchEntity {

}

+ (id)primaryKey {
    return @"videoId";
}

+ (NSDictionary *)JSONInboundMappingDictionary {
    return @{
            @"id.videoId" : @"videoId",
            @"snippet.title" : @"title",
            @"snippet.description" : @"description",
            @"snippet.thumbnails.default.url" : @"thumbnail"
    };
}

@end