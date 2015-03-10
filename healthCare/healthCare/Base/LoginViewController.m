//
//  LoginViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "LoginViewController.h"
#import "InsetTextField.h"
#import "connectionManager.h"
#import "TabBarViewController.h"
#import "PatientViewController.h"
#import "DoctorViewController.h"
#import "AdminViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (strong, nonatomic) InsetTextField *nameText;
@property (strong, nonatomic) InsetTextField *passwordText;
@property (strong, nonatomic) UIButton *loginButton;
@property (strong, nonatomic) InsetTextField *serverAddress;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UILabel *ipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/8, 150, 35)];
    ipLabel.text = @"Enter Username:";
    
    self.nameText = [[InsetTextField alloc] initWithFrame:CGRectMake(20, ipLabel.frame.origin.y + 45, 240, 40)];
    self.nameText.placeholder = @"Eg:root";
    self.nameText.layer.borderWidth = 1.5f;
    self.nameText.layer.borderColor = [UIColor blackColor].CGColor;
    self.nameText.layer.cornerRadius = 5.0f;
    self.nameText.layer.masksToBounds = YES;
    self.nameText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.nameText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.nameText.frame.origin.y + 55, 150, 35)];
    portLabel.text = @"Enter Password:";
    
    self.passwordText = [[InsetTextField alloc] initWithFrame:CGRectMake(20, portLabel.frame.origin.y + 45, 240, 40)];
    self.passwordText.placeholder = @"enter password";
    self.passwordText.secureTextEntry = YES;
    self.passwordText.layer.borderWidth = 1.5f;
    self.passwordText.layer.borderColor = [UIColor blackColor].CGColor;
    self.passwordText.layer.cornerRadius = 5.0f;
    self.passwordText.layer.masksToBounds = YES;
    self.passwordText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    UILabel *ipAddLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.passwordText.frame.origin.y + 55, 150, 35)];
    ipAddLabel.text = @"Enter Server IP:";
    
    self.serverAddress = [[InsetTextField alloc] initWithFrame:CGRectMake(20, ipAddLabel.frame.origin.y + 50, 240, 40)];
    self.serverAddress.placeholder = @"enter server ip";
    self.serverAddress.layer.borderWidth = 1.5;
    self.serverAddress.layer.borderColor = [UIColor blackColor].CGColor;
    self.serverAddress.layer.cornerRadius = 5.0f;
    self.serverAddress.layer.masksToBounds = YES;
    self.serverAddress.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.serverAddress.autocapitalizationType = UITextAutocapitalizationTypeNone;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"serverKey"])
    {
        self.serverAddress.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverKey"];
    }
    [self.serverAddress setReturnKeyType:UIReturnKeyGo];
    self.serverAddress.delegate = self;
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, self.serverAddress.frame.origin.y + 100, 80, 30)];
    self.loginButton.layer.borderWidth = 1.5f;
    self.loginButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.loginButton.layer.masksToBounds = YES;
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginDataBase) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:ipLabel];
    [self.view addSubview:self.nameText];
    [self.view addSubview:portLabel];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:ipAddLabel];
    [self.view addSubview:self.serverAddress];
    [self.view addSubview:self.loginButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self loginDataBase];
    return YES;
}

- (void)loginDataBase
{
    NSLog(@"clicked");
    if (!self.serverAddress.text || !self.nameText.text || !self.passwordText.text)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Input" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if ([self.serverAddress.text isEqualToString:@""] || [self.nameText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:@""])
    {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Input" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert2 show];
        return;
    }
    [[connectionManager sharedManager] connectWithIpAddress:self.serverAddress.text andUserName:self.nameText.text andPassword:self.passwordText.text inBackgroundWithBlock:^(BOOL succeed, NSString *error) {
        if (succeed)
        {
            [[NSUserDefaults standardUserDefaults] setObject:self.serverAddress.text forKey:@"serverKey"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self goToMainView];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"serverKey"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginSuccess"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert3 show];
            return;
        }
    }];
}

- (void)goToMainView
{
    TabBarViewController *mainView = [[TabBarViewController alloc] init];
    PatientViewController *patientController  = [[PatientViewController alloc] init];
    UINavigationController  *nav1 = [[UINavigationController alloc] initWithRootViewController:patientController];
    nav1.title = @"Patient";
    DoctorViewController *doctorController = [[DoctorViewController alloc] init];
    UINavigationController  *nav2 = [[UINavigationController alloc] initWithRootViewController:doctorController];
    nav2.title = @"Doctor";
    AdminViewController *adminController = [[AdminViewController alloc] init];
    UINavigationController  *nav3 = [[UINavigationController alloc] initWithRootViewController:adminController];
    nav1.title = @"Administrator";    mainView.viewControllers = @[nav1,nav2,nav3];
    mainView.selectedIndex = 0;

    [self presentViewController:mainView animated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginSuccess"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

- (void)closeKeyBoard
{
    [self.view endEditing:YES];
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
