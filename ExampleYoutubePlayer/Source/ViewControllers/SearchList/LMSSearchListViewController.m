//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import "LMSSearchListViewController.h"
#import "LMSSearchListViewModel.h"
#import "RACSignal.h"
#import "UISearchBar+RACAdditions.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "NSObject+RACPropertySubscribing.h"
#import "RACSignal+Operations.h"
#import "RACEXTScope.h"
#import "NSObject+RACDeallocating.h"


@implementation LMSSearchListViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self bindViewWithModel];
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self.viewModel;
    // Disable faked cells when table is empty
    self.tableView.tableFooterView = [UIView new];
}

- (void)bindViewWithModel {
    @weakify(self);
    RACSignal *searchPhraseSignal = [self.searchBar rac_textSignal];
    // Change only if value is distinct, wait some time to prevent request when user is typing
    RAC(self, viewModel.searchPhrase) = [[searchPhraseSignal distinctUntilChanged] throttle:0.5];
    // Refresh table when needed
    [[RACObserve(self, viewModel.tableListNeedReload) switchToLatest] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    [self bindLoadIndicatorWithModel];
}

- (void)bindLoadIndicatorWithModel {
    @weakify(self);
    RACSignal *isLoadingSignal = [[RACObserve(self, viewModel.isLoading) distinctUntilChanged] deliverOnMainThread];
    [[isLoadingSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *isLoadingNumber) {
        @strongify(self);
        [UIView animateWithDuration:0.3 animations:^{
            self.loadIndicatorView.alpha = isLoadingNumber.floatValue;
        }];
    }];
}


@end