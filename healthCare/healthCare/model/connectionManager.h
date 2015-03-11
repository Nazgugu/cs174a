//
//  connectionManager.h
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "patient.h"

typedef void (^boolBlock)(BOOL succeed, NSString *error);
typedef void (^objectBlock)(id Object, NSString *error);

@interface connectionManager : NSObject

+ (instancetype)sharedManager;

- (void)connectWithIpAddress:(NSString *)ip andUserName:(NSString *)userName andPassword:(NSString *)password inBackgroundWithBlock:(boolBlock)block;

//fetch single patient
- (void)fetchInBackgroundWithPatientId:(NSString *)patientId andBlock:(objectBlock)block;

- (void)updatePatientInfoWithPatient:(patient *)patient inBackgroundWithBlock:(boolBlock)block;
@end
