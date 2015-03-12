//
//  doctor.h
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "patient.h"

@interface doctor : NSObject

@property (strong, nonatomic) NSArray *patientsArray;

@property (strong, nonatomic) NSString *AuthorId;
@property (strong, nonatomic) NSString *AuthorTitle;
@property (strong, nonatomic) NSString *AuthorFirstName;
@property (strong, nonatomic) NSString *AuthorLastName;
@property (strong, nonatomic) NSString *numberOfPatients;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
