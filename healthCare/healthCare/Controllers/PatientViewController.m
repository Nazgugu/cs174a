//
//  PatientViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "PatientViewController.h"
#import "LoginViewController.h"
#import "InsetTextField.h"

@interface PatientViewController () <UITabBarControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *patientIdLabel;
@property (weak, nonatomic) IBOutlet InsetTextField *patientGivenNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientFamilyNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientSuffixField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientGenderField;

@end

@implementation PatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Patient";
    UIBarButtonItem *logout = [[UIBarButtonItem alloc] initWithTitle:@"logout" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.rightBarButtonItem = logout;
    UIBarButtonItem *patientLogin = [[UIBarButtonItem alloc] initWithTitle:@"patientLogin" style:UIBarButtonItemStylePlain target:self action:@selector(patientLogin)];
    self.navigationItem.leftBarButtonItem = patientLogin;
    self.tabBarController.delegate = self;
}

- (void)patientLogin
{
    UIAlertView *loginAlert = [[UIAlertView alloc] init];
    loginAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    loginAlert.cancelButtonIndex = 1;
    loginAlert.title = @"Login As Patient";
    loginAlert.message = @"Please enter patientId";
    [loginAlert addButtonWithTitle:@"Confirm"];
    [loginAlert addButtonWithTitle:@"Cancel"];
    loginAlert.delegate = self;
    [loginAlert show];
}

- (void)logout
{
    LoginViewController *login = [[LoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:^{
        
    }];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"I am gonna login as Patient");
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
