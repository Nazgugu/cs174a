//
//  allergy.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "allergy.h"

NSString * const allergyIdKey = @"Id";
NSString * const allergySubstanceKey = @"Substance";
NSString * const allergyReactionKey = @"Reaction";
NSString * const allergyStatusKey = @"status";
NSString * const allergyAffectPeopleKey = @"NumberOfPatients";

@implementation allergy

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.Id = [dict objectForKey:allergyIdKey];
        self.Substance = [dict objectForKey:allergySubstanceKey];
        self.Reaction = [dict objectForKey:allergyReactionKey];
        self.status = [dict objectForKey:allergyStatusKey];
    }
    return self;
}

- (instancetype)initWithShortDict:(NSDictionary *)sDict
{
    self = [super init];
    if (self)
    {
        self.Id = [sDict objectForKey:allergyIdKey];
        self.Substance = [sDict objectForKey:allergySubstanceKey];
        self.numberOfPeopleInfected = [sDict objectForKey:allergyAffectPeopleKey];
    }
    return self;
}

@end
