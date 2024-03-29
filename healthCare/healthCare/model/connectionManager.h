//
//  connectionManager.h
//  healthCare
//
//  Created by Liu Zhe on 3/10/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "patient.h"
#import "scheduledPlan.h"
#import "allergy.h"

typedef void (^boolBlock)(BOOL succeed, NSString *error);
typedef void (^objectBlock)(id Object, NSString *error);
typedef void (^arrayBlock)(NSArray *objects, NSString *error);

@interface connectionManager : NSObject

+ (instancetype)sharedManager;

- (void)connectWithIpAddress:(NSString *)ip andUserName:(NSString *)userName andPassword:(NSString *)password inBackgroundWithBlock:(boolBlock)block;

//fetch single patient
- (void)fetchInBackgroundWithPatientId:(NSString *)patientId andBlock:(objectBlock)block;

//update patient info
- (void)updatePatientInfoWithPatient:(patient *)patient inBackgroundWithBlock:(boolBlock)block;

//login as doctor
- (void)loginInBackgroundWithDoctorId:(NSString *)doctorId andBlock:(boolBlock)block;

//fetch all patients
- (void)fetchAllPatientsInBackground:(arrayBlock)block;

//fetch the plans and allergies
- (void)fetchAllergyAndPlansWithPatientId:(NSString *)patientId andPatientIndex:(NSInteger)index andBlock:(boolBlock)block;

//update the plan
- (void)updatePlanInBackgroudWithPlan:(scheduledPlan *)plan andCompletionBlock:(boolBlock)block;

//update the allergy
- (void)updateAllergyInBackgroundWithAllergy:(allergy *)allergy andCompletionBlock:(boolBlock)block;

//fetch number of patient for each type of allergy(substance)
- (void)fetchAllergyAndPatientCount:(arrayBlock)block;

//fetch patient with more than one allergy
- (void)fetchPatientWithMoreAllergy:(arrayBlock)block;

//fetch patient have surgery today
- (void)fetchPatientHaveSurgeryToday:(arrayBlock)block;

//fetch author with more than one patient
- (void)fetchAuthorMorePatients:(arrayBlock)block;

@end
