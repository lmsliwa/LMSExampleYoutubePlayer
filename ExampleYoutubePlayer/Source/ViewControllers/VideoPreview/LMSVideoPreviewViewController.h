//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

@import UIKit;
@import AVKit;
#import <Foundation/Foundation.h>

@class LMSVideoPreviewViewModel;
@class LMSVideoSearchEntity;


@interface LMSVideoPreviewViewController : AVPlayerViewController

@property (nonatomic, strong) LMSVideoPreviewViewModel *viewModel;
@property (nonatomic, strong) LMSVideoSearchEntity *videoSearchEntity;

@end