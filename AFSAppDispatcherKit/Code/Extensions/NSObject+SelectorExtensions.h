//
//  NSObject+SelectorExtensions.h
//  
//
//  Created by Arkadi Yoskovitz on 8/24/18.
//  Copyright © 2018 Arkadi Yoskovitz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SelectorExtensions)
- (BOOL)overridesSelector:(SEL)aSelector;
@end

NS_ASSUME_NONNULL_END
