//
//  AdminViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "AdminViewController.h"

@interface AdminViewController () <UITabBarControllerDelegate,UIAlertViewDelegate>

@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Administrator";
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"adminLogout" style:UIBarButtonItemStylePlain target:self action:@selector(adminLogout)];
    self.navigationItem.rightBarButtonItem = logout;
    self.navigationItem.rightBarButtonItem = logout;
    UIBarButtonItem *adminLogin = [[UIBarButtonItem alloc] initWithTitle:@"adminLogin" style:UIBarButtonItemStylePlain target:self action:@selector(adminLogin)];
    self.navigationItem.leftBarButtonItem = adminLogin;
    self.tabBarController.delegate = self;
}

- (void)adminLogout
{
}

- (void)adminLogin
{
    UIAlertView *loginAlert = [[UIAlertView alloc] init];
    loginAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    loginAlert.cancelButtonIndex = 1;
    loginAlert.title = @"Login As Admin";
    loginAlert.message = @"Please enter adminId";
    [loginAlert addButtonWithTitle:@"Confirm"];
    [loginAlert addButtonWithTitle:@"Cancel"];
    loginAlert.delegate = self;
    [loginAlert show];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"I am gonna login as Doctor");
    }
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
