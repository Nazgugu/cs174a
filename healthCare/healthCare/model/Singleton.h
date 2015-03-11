//
//  Singleton.h
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "patient.h"

@interface Singleton : NSObject

@property (strong, nonatomic) patient *currentPatient;

+ (instancetype)sharedData;

@end
