//
// Created by Łukasz Śliwa on 22/11/15.
// Copyright (c) 2015 Łukasz Śliwa. All rights reserved.
//

#import <Typhoon/TyphoonDefinition+Infrastructure.h>
#import "LMSApplicationAssembly.h"
#import "LMSViewControllerAssembly.h"


@implementation LMSApplicationAssembly {

}

/**
 * This method give Assemblies access to additional information from Configuration.json file (via TyphoonConfig())
 */
- (id)configurer {
    return [TyphoonDefinition configDefinitionWithName:@"Configuration.json"];
}

@end