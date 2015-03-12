//
//  doctor.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "doctor.h"

@implementation doctor

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.AuthorId = [dict objectForKey:@"AuthorId"];
        self.AuthorTitle = [dict objectForKey:@"AuthorTitle"];
        self.AuthorFirstName = [dict objectForKey:@"AuthorFirstName"];
        self.AuthorLastName = [dict objectForKey:@"AuthorLastName"];
        self.numberOfPatients = [dict objectForKey:@"NumberOfPatients"];
    }
    return self;
}

@end
