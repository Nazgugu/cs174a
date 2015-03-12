//
//  scheduledPlan.h
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface scheduledPlan : NSObject

@property (strong, nonatomic) NSString *PlanId;
@property (strong, nonatomic) NSString *Activity;
@property (strong, nonatomic) NSString *scheduledDate;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
