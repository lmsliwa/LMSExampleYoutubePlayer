//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSSearchListViewModel.h"
#import "LMSDataClient.h"
#import "LMSVideoSearchEntity.h"
#import "RACSubject.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal+Operations.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "RACSignal.h"
#import "RACEXTScope.h"
#import "UIImageView+HighlightedWebCache.h"
#import "UIImageView+WebCache.h"

@interface LMSSearchListViewModel ()

@property (nonatomic, strong) NSArray *videoList;

@end

@implementation LMSSearchListViewModel {

}

/**
 * Do some more customisation after all dependencies are injected
 */
- (void)injectionsCompleted {
    [self setupSearchFlow];
}

- (void)setupSearchFlow {
    @weakify(self);
    RACSignal *searchPhraseSignal = [RACObserve(self, searchPhrase) skip:1];
    //Enable loading
    searchPhraseSignal = [searchPhraseSignal doNext:^(id x) {
        @strongify(self);
        self.isLoading = YES;
    }];
    searchPhraseSignal = [searchPhraseSignal flattenMap:^RACStream *(NSString *searchPhrase) {
        @strongify(self);
        // If searchPhrase is empty omit searching
        if (!searchPhrase || [searchPhrase isEqualToString:@""]) {
            return [RACSignal return:nil];
        }
        return [[[self.dataClient searchVideoForQuery:searchPhrase] replayLazily] takeUntil:searchPhraseSignal];
    }];
    // Disable loading
    searchPhraseSignal = [[searchPhraseSignal doNext:^(id x) {
        @strongify(self);
        self.isLoading = NO;
    }] doError:^(NSError *error) {
        @strongify(self);
        self.isLoading = NO;
    }];
    // Assign search result to videoList - catch any error to nil;
    RAC(self, videoList) = [searchPhraseSignal catchTo:[RACSignal return:nil]];

    //Signal list refresh
    self.tableListNeedReload = RACObserve(self, videoList);
}

#pragma mark - Public method

- (id)itemForIndexPath:(NSIndexPath *)indexPath {
    return self.videoList[indexPath.row];
}

#pragma mark - Table view datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"searchVideoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    LMSVideoSearchEntity *entity =  [self itemForIndexPath:indexPath];
    return [self configureCell:cell withItem:entity];
}

- (UITableViewCell *)configureCell:(UITableViewCell *)cell withItem:(LMSVideoSearchEntity *)entity {
    cell.textLabel.text = entity.title;
    cell.detailTextLabel.text = entity.description;
    if (entity.thumbnail) {
        NSURL *thumbURL = [NSURL URLWithString:entity.thumbnail];
        [cell.imageView sd_setImageWithURL:thumbURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
        }];
    }
    return cell;
}


@end