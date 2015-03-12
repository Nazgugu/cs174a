//
//  scheduledPlan.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "scheduledPlan.h"

NSString * const schedulePlanKey = @"PlanId";
NSString * const scheduleActivityKey = @"Activity";
NSString * const scheduleDateKey = @"ScheduledDate";

@implementation scheduledPlan

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.PlanId = [dict objectForKey:schedulePlanKey];
        self.Activity = [dict objectForKey:scheduleActivityKey];
        self.scheduledDate = [dict objectForKey:scheduleDateKey];
    }
    return self;
}

@end
