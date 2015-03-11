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

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
