//
//  allergy.h
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface allergy : NSObject

@property (strong, nonatomic) NSString *Id;
@property (strong, nonatomic) NSString *Substance;
@property (strong, nonatomic) NSString *Reaction;
@property (strong, nonatomic) NSString *status;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
