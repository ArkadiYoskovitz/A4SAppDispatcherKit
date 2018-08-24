//
//  NSObject+SelectorExtensions.m
//  
//
//  Created by Arkadi Yoskovitz on 8/24/18.
//  Copyright © 2018 Arkadi Yoskovitz. All rights reserved.
//

#import "NSObject+SelectorExtensions.h"

@implementation NSObject (SelectorExtensions)

- (BOOL)overridesSelector:(SEL)aSelector {

    Class aSuperType = [self superclass];
    BOOL  overridden = NO;
    
    while (aSuperType != nil) {
        overridden = ([aSuperType instancesRespondToSelector:aSelector]) && ([self methodForSelector: aSelector] != [aSuperType instanceMethodForSelector: aSelector]);
        if (overridden) {
            break;
        }
        aSuperType = [aSuperType superclass];
    }
    return overridden;
}
@end
