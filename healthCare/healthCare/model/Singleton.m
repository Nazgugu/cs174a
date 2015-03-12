//
//  Singleton.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

+ (id)sharedData
{
    static Singleton *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        if (!_patientArray)
        {
            _patientArray = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

@end
