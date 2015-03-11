//
//  patient.m
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "patient.h"

//Patient Keys
NSString * const patientIdKey = @"patientId";
NSString * const patientGivenNameKey = @"GivenName";
NSString * const patientFamilyNameKey = @"FamilyName";
NSString * const patientSuffixKey = @"Suffix";
NSString * const patientGenderKey = @"Gender";
NSString * const patientBirthKey = @"BirthTime";
NSString * const patientProviderIdKey = @"providerId";
NSString * const patientFileCreationDateKey = @"xmlHealthCreationTime";

//Guardian Keys
NSString * const GuardianNoKey = @"GuardianNo";
NSString * const RelationshipKey = @"Relationship";
NSString * const GuardianFirstNameKey = @"FirstName";
NSString * const GuardianLastNameKey = @"LastName";
NSString * const GuardianPhoneKey = @"phone";
NSString * const GuardianAddressKey = @"address";
NSString * const GuardianCityKey = @"city";
NSString * const GuardianStateKey = @"state";
NSString * const GuardianZipKey = @"zip";


@interface patient()

@end

@implementation patient

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        //Patient
        self.patientId = [dict objectForKey:patientIdKey];
        NSLog(@"patient id = %@",[dict objectForKey:patientIdKey]);
        self.GivenName = [dict objectForKey:patientGivenNameKey];
        self.FamilyName = [dict objectForKey:patientFamilyNameKey];
        self.Suffix = [dict objectForKey:patientSuffixKey];
        self.Gender = [dict objectForKey:patientGenderKey];
        self.BirthTime = [dict objectForKey:patientBirthKey];
        self.providerId = [dict objectForKey:patientProviderIdKey];
        self.xmlHealthCreationTime = [dict objectForKey:patientFileCreationDateKey];
        //guardian
        self.GuardianNo = [dict objectForKey:GuardianNoKey];
        self.Relationship = [dict objectForKey:RelationshipKey];
        self.FirstName = [dict objectForKey:GuardianFirstNameKey];
        self.LastName = [dict objectForKey:GuardianLastNameKey];
        self.phone = [dict objectForKey:GuardianPhoneKey];
        self.address = [dict objectForKey:GuardianAddressKey];
        self.city = [dict objectForKey:GuardianCityKey];
        self.state = [dict objectForKey:GuardianStateKey];
        self.zip = [dict objectForKey:GuardianZipKey];
    }
    return self;
}

@end
