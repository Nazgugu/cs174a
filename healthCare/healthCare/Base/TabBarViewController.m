//
//  TabBarViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        //        UITabBarItem * patient = [[UITabBarItem alloc] initWithTitle:@"patient" image:nil tag:0];
//        UITabBarItem * doctor = [[UITabBarItem alloc] initWithTitle:@"doctor" image:nil tag:1];
//        UITabBarItem * admin = [[UITabBarItem alloc] initWithTitle:@"admin" image:nil tag:2];
        
        //self.tabBar.items = @[patient,doctor,admin];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
