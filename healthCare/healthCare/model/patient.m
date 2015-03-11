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
        //NSLog(@"patient id = %@",[dict objectForKey:patientIdKey]);
        if ([dict objectForKey:patientGivenNameKey] == [NSNull null])
        {
            self.GivenName = nil;
        }
        else
        {
            self.GivenName = [dict objectForKey:patientGivenNameKey];
        }
        if ([dict objectForKey:patientFamilyNameKey] ==[NSNull null])
        {
            self.FamilyName = nil;
        }
        else
        {
            self.FamilyName = [dict objectForKey:patientFamilyNameKey];
        }
        if ([dict objectForKey:patientSuffixKey] == [NSNull null])
        {
            self.Suffix = nil;
        }
        else
        {
            self.Suffix = [dict objectForKey:patientSuffixKey];
        }
        if ([dict objectForKey:patientGenderKey] == [NSNull null])
        {
            self.Gender = nil;
        }
        else
        {
            self.Gender = [dict objectForKey:patientGenderKey];
        }
        if ([dict objectForKey:patientBirthKey] == [NSNull null])
        {
            self.BirthTime = nil;
        }
        else
        {
            self.BirthTime = [dict objectForKey:patientBirthKey];
        }
        if ([dict objectForKey:patientProviderIdKey] == [NSNull null])
        {
            self.providerId = nil;
        }
        else
        {
            self.providerId = [dict objectForKey:patientProviderIdKey];
        }
        if ([dict objectForKey:patientFileCreationDateKey] == [NSNull null])
        {
            self.xmlHealthCreationTime = nil;
        }
        else
        {
            self.xmlHealthCreationTime = [dict objectForKey:patientFileCreationDateKey];
        }
        //guardian
        if ([dict objectForKey:GuardianNoKey] == [NSNull null])
        {
            self.GuardianNo = nil;
        }
        else
        {
            self.GuardianNo = [dict objectForKey:GuardianNoKey];
        }
        if ([dict objectForKey:RelationshipKey] == [NSNull null])
        {
            self.Relationship = nil;
        }
        else
        {
            self.Relationship = [dict objectForKey:RelationshipKey];
        }
        if ([dict objectForKey:GuardianFirstNameKey] == [NSNull null])
        {
            self.FirstName = nil;
        }
        else
        {
            self.FirstName = [dict objectForKey:GuardianFirstNameKey];
        }
        if ([dict objectForKey:GuardianLastNameKey] == [NSNull null])
        {
            self.LastName = nil;
        }
        else
        {
            self.LastName = [dict objectForKey:GuardianLastNameKey];
        }
        if ([dict objectForKey:GuardianPhoneKey] == [NSNull null])
        {
            self.phone = nil;
        }
        else
        {
            self.phone = [dict objectForKey:GuardianPhoneKey];
        }
        if ([dict objectForKey:GuardianAddressKey] == [NSNull null])
        {
            self.address = nil;
        }
        else
        {
            self.address = [dict objectForKey:GuardianAddressKey];
        }
        if ([dict objectForKey:GuardianCityKey] == [NSNull null])
        {
            self.city = nil;
        }
        else
        {
            self.city = [dict objectForKey:GuardianCityKey];
        }
        if ([dict objectForKey:GuardianStateKey] == [NSNull null])
        {
            self.state = nil;
        }
        else
        {
            self.state = [dict objectForKey:GuardianStateKey];
        }
        if ([dict objectForKey:GuardianZipKey] == [NSNull null])
        {
            self.zip = nil;
        }
        else
        {
            self.zip = [dict objectForKey:GuardianZipKey];
        }
    }
    return self;
}

@end
