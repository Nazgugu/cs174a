//
//  connectionManager.h
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^boolBlock)(BOOL succeed, NSString *error);

@interface connectionManager : NSObject

+ (instancetype)sharedManager;

- (void)connectWithIpAddress:(NSString *)ip andUserName:(NSString *)userName andPassword:(NSString *)password inBackgroundWithBlock:(boolBlock)block;

@end
