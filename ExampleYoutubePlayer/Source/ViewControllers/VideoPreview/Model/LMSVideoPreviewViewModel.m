//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSVideoPreviewViewModel.h"
#import "LMSDataClient.h"
#import "LMSVideoSearchEntity.h"
#import "HCYoutubeParser.h"
#import "RACEXTScope.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACStream.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "RACScheduler.h"
#import "RACSubscriptingAssignmentTrampoline.h"


@implementation LMSVideoPreviewViewModel {

}

/**
 * Do some more customisation after all dependencies are injected
 */
- (void)injectionsCompleted {
    [self setupVideoURLFlow];
}

- (void)setupVideoURLFlow {
    @weakify(self);
    RACSignal *videoIdSignal = RACObserve(self, videoSearchEntity.videoId);
    RACSignal *youtubeDetailsSignal = [[videoIdSignal deliverOn:[RACScheduler scheduler]] map:^id(NSString *videoId) {
        return [self.youtubeParserClass h264videosWithYoutubeID:videoId];
    }];
    RAC(self, videoURL) = [[youtubeDetailsSignal map:^id(NSDictionary *detailedVideoInfo) {
        return [NSURL URLWithString:detailedVideoInfo[@"medium"]];
    }] deliverOnMainThread];
}

@end