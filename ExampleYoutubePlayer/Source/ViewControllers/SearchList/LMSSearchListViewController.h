//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>

@class LMSSearchListViewModel;


@interface LMSSearchListViewController : UIViewController <UITableViewDelegate>

@property (nonatomic, strong) LMSSearchListViewModel *viewModel;

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *loadIndicatorView;

@end