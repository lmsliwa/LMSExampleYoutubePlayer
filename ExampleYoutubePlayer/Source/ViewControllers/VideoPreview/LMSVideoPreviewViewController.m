//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

@import AVKit;
@import AVFoundation;
#import "LMSVideoPreviewViewController.h"
#import "RACEXTScope.h"
#import "RACSignal.h"
#import "NSObject+RACPropertySubscribing.h"
#import "LMSVideoPreviewViewModel.h"
#import "RACSignal+Operations.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "LMSVideoSearchEntity.h"


@implementation LMSVideoPreviewViewController {

}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewWithModel];
}

- (void)bindViewWithModel {
    @weakify(self);
    // Forward video entity to model
    RAC(self, viewModel.videoSearchEntity) = RACObserve(self, videoSearchEntity);
    RACSignal *videoURLSignal = RACObserve(self, viewModel.videoURL);
    [[[videoURLSignal ignore:nil] deliverOnMainThread] subscribeNext:^(NSURL *videoURL) {
        @strongify(self);
        self.player = [[AVPlayer alloc] initWithURL:videoURL];
        [self.player play];
    }];
}

@end