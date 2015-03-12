//
//  PepleListTableViewController.h
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleListTableViewController;
typedef NS_OPTIONS(NSInteger, ListType)
{
    ListTypeAllergy = 0,
    ListTypePatientMoreAllergy = 1,
    ListTypePatientPlanToday = 2,
    ListTypeAuthorMorePatient = 3
};

@interface PeopleListTableViewController : UITableViewController

@property (nonatomic) ListType type;

@end
