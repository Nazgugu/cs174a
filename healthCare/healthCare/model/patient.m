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
//Patient
@property (strong, nonatomic) NSString *patientId;
@property (strong, nonatomic) NSString *GivenName;
@property (strong, nonatomic) NSString *FamilyName;
@property (strong, nonatomic) NSString *Suffix;
@property (strong, nonatomic) NSString *Gender;
@property (strong, nonatomic) NSString *BirthTime;
@property (strong, nonatomic) NSString *providerId;
@property (strong, nonatomic) NSString *xmlHealthCreationTime;

//GuardianInfo
@property (strong, nonatomic) NSString *GuardianNo;
@property (strong, nonatomic) NSString *Relationship;
@property (strong, nonatomic) NSString *FirstName;
@property (strong, nonatomic) NSString *LastName;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *zip;

@end

@implementation patient

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        //Patient
        self.patientId = [dict objectForKey:patientIdKey];
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
