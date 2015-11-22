//
// Created by Eli Perkins on 3/18/14.
// Copyright (c) 2014 One Mighty Roar. All rights reserved.
//

#import <objc/runtime.h>
#import "UISearchBar+RACAdditions.h"
#import "NSObject+RACDescription.h"
#import "RACSignal.h"
#import "RACDelegateProxy.h"
#import "RACEXTScope.h"
#import "RACTuple.h"
#import "RACSignal.h"
#import "RACSignal+Operations.h"
#import "RACDisposable.h"
#import "RACCompoundDisposable.h"
#import "RACCommand.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACSelectorSignal.h"

static void *UISearchBarRACCommandKey = &UISearchBarRACCommandKey;
static void *UISearchBarDisposableKey = &UISearchBarDisposableKey;

@interface UISearchBar (RACAdditions)

@end

@implementation UISearchBar (RACAdditions)

static void RACUseDelegateProxy(UISearchBar *self) {
    if (self.delegate == self.rac_delegateProxy) return;

    self.rac_delegateProxy.rac_proxiedDelegate = self.delegate;
    self.delegate = (id)self.rac_delegateProxy;
}

- (RACDelegateProxy *)rac_delegateProxy {
    RACDelegateProxy *proxy = objc_getAssociatedObject(self, _cmd);
    if (proxy == nil) {
        proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(UISearchBarDelegate)];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return proxy;
}

- (RACSignal *)rac_textSignal {
    @weakify(self);
    RACUseDelegateProxy(self);
    RACSignal *signal = [[[self.rac_delegateProxy rac_signalForSelector:@selector(searchBar:textDidChange:)] map:^id(RACTuple *tuple) {
        RACTupleUnpack(UISearchBar *searchBar, NSString *text) = tuple;
        return text;
    }] takeUntil:[self rac_willDeallocSignal]];
    return signal;
}

- (RACCommand *)rac_searchCommand {
    return objc_getAssociatedObject(self, UISearchBarRACCommandKey);
}

- (void)setRac_searchCommand:(RACCommand *)command {
    objc_setAssociatedObject(self, UISearchBarRACCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    // Dispose of any active command associations.
    [objc_getAssociatedObject(self, UISearchBarDisposableKey) dispose];

    if (command == nil) return;

    RACDisposable *executionDisposable = [[[[self.rac_delegateProxy
            signalForSelector:@selector(searchBarSearchButtonClicked:)]
            reduceEach:^(UISearchBar *x) {
                return [[[command
                        execute:x]
                        catchTo:[RACSignal empty]]
                        then:^{
                            return [RACSignal return:x];
                        }];
            }]
            concat]
            subscribeNext:^(UISearchBar *x) {
                [x resignFirstResponder];
            }];

    RACDisposable *commandDisposable = [RACCompoundDisposable compoundDisposableWithDisposables:@[ executionDisposable ]];
    objc_setAssociatedObject(self, UISearchBarDisposableKey, commandDisposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end