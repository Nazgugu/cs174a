//
//  patient.h
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>

//Patient Keys
extern NSString * const patientIdKey;
extern NSString * const patientGivenNameKey;
extern NSString * const patientFamilyNameKey;
extern NSString * const patientSuffixKey;
extern NSString * const patientGenderKey;
extern NSString * const patientBirthKey;
extern NSString * const patientProviderIdKey;
extern NSString * const patientFileCreationDateKey;

//Guardian Keys
extern NSString * const GuardianNoKey;
extern NSString * const RelationshipKey;
extern NSString * const GuardianFirstNameKey;
extern NSString * const GuardianLastNameKey;
extern NSString * const GuardianPhoneKey;
extern NSString * const GuardianAddressKey;
extern NSString * const GuardianCityKey;
extern NSString * const GuardianStateKey;
extern NSString * const GuardianZipKey;


@interface patient : NSObject

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

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
