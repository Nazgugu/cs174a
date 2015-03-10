//
//  DoctorViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "DoctorViewController.h"
#import "LoginViewController.h"

@interface DoctorViewController () <UITabBarControllerDelegate>

@end

@implementation DoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Doctor";
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = logout;
    self.tabBarController.delegate = self;
}

- (void)logout
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:^{
        
    }];
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
