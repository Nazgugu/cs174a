//
//  PatientViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "PatientViewController.h"
#import "InsetTextField.h"
#import "patient.h"
#import "connectionManager.h"

@interface PatientViewController () <UITabBarControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIBarButtonItem *loginButton;

@property (strong, nonatomic) UIBarButtonItem *logoutButton;


//patient
@property (weak, nonatomic) IBOutlet UILabel *patientIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *creationDateLabel;
@property (weak, nonatomic) IBOutlet InsetTextField *patientGivenNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientFamilyNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientSuffixField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientGenderField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientBirthDayField;
@property (weak, nonatomic) IBOutlet InsetTextField *patientProviderIdField;

//Guardian
@property (weak, nonatomic) IBOutlet UILabel *guardianNoLabel;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianFirstNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianLastNameField;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianPhoneField;
@property (weak, nonatomic) IBOutlet InsetTextField *relationshipField;
@property (weak, nonatomic) IBOutlet UITextView *guardianAddressField;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianCityField;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianStateField;
@property (weak, nonatomic) IBOutlet InsetTextField *guardianZipField;

@property (weak, nonatomic) IBOutlet UIButton *modifyButton;

@property (strong, nonatomic) patient *currentPatient;

@property (strong, nonatomic) NSString *patientId;

@end

@implementation PatientViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"Patient";
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"patientLogout" style:UIBarButtonItemStylePlain target:self action:@selector(patientLogout)];
    self.navigationItem.leftBarButtonItem= self.logoutButton;
    self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"patientLogin" style:UIBarButtonItemStylePlain target:self action:@selector(patientLogin)];
    self.navigationItem.rightBarButtonItem = self.loginButton;
    self.tabBarController.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    //initialization
    self.patientIdLabel.text = @"patient ID: ";
    self.guardianNoLabel.text = @"guardian No: ";
    self.creationDateLabel.text = @"creat at: ";
    self.guardianAddressField.layer.borderWidth = 1.0f;
    self.guardianAddressField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.guardianAddressField.layer.masksToBounds = YES;
    
    [self.modifyButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    self.modifyButton.layer.borderWidth = 1.0f;
    self.modifyButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.modifyButton.layer.cornerRadius = 5.0f;
    self.modifyButton.layer.masksToBounds = YES;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [self configureModifyButtonWithPatientDict:nil];
}

- (void)closeKeyBoard
{
    [self.view endEditing:YES];
}

- (void)configureModifyButtonWithPatientDict:(NSDictionary *)dict
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"currentPatient"])
    {
        if (dict)
        {
            self.currentPatient = [[patient alloc] initWithDictionary:dict];
        }
        else
        {
            [self logInWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"patientId"]];
        }
        self.modifyButton.enabled = YES;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = self.logoutButton;
    }
    else
    {
        self.modifyButton.enabled = NO;
        self.currentPatient = nil;
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = self.loginButton;
    }
        
}

- (void)setCurrentPatient:(patient *)currentPatient
{
    if (currentPatient)
    {
        for (UIView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[InsetTextField class]])
            {
                InsetTextField *field = (InsetTextField *)view;
                field.enabled = YES;
            }
            if ([view isKindOfClass:[UITextView class]])
            {
                UITextView *textView = (UITextView *)view;
                textView.editable = YES;
            }
        }
        
        self.patientIdLabel.text = [NSString stringWithFormat:@"patient ID: %@",currentPatient.patientId];
        self.guardianNoLabel.text = [NSString stringWithFormat:@"guardian No: %@",currentPatient.GuardianNo];
        self.creationDateLabel.text = [NSString stringWithFormat:@"%@",currentPatient.xmlHealthCreationTime];
        self.patientFamilyNameField.text = currentPatient.FamilyName;
        self.patientGivenNameField.text = currentPatient.GivenName;
        self.patientSuffixField.text = currentPatient.Suffix;
        self.patientGenderField.text = currentPatient.Gender;
        self.patientBirthDayField.text = currentPatient.BirthTime;
        self.patientProviderIdField.text = currentPatient.providerId;
        //guardian info
        //self.guardianNoLabel.text = currentPatient.GuardianNo;
        self.guardianFirstNameField.text = currentPatient.FirstName;
        self.guardianLastNameField.text = currentPatient.LastName;
        self.guardianPhoneField.text = currentPatient.phone;
        self.relationshipField.text = currentPatient.Relationship;
        self.guardianAddressField.text = currentPatient.address;
        self.guardianCityField.text = currentPatient.city;
        self.guardianStateField.text = currentPatient.state;
        self.guardianZipField.text = currentPatient.zip;
        
    }
    else
    {
        NSLog(@"nothing");
        self.patientIdLabel.text = @"patient ID: ";
        self.guardianNoLabel.text = @"guardian No: ";
        for (UIView *view in self.view.subviews)
        {
            if ([view isKindOfClass:[InsetTextField class]])
            {
                InsetTextField *field = (InsetTextField *)view;
                field.text = @"";
                field.enabled = NO;
            }
            if ([view isKindOfClass:[UITextView class]])
            {
                UITextView *textView = (UITextView *)view;
                textView.text = @"";
                textView.editable = NO;
            }
        }
    }
}


//modify button method
- (IBAction)modifyPatientData:(id)sender {
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



- (void)patientLogout
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"currentPatient"];
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"patientId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self configureModifyButtonWithPatientDict:nil];

}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (![alertView textFieldAtIndex:0].text || [[alertView textFieldAtIndex:0].text isEqualToString:@""])
        {
            [self patientLogin];
        }
        else
        {
            self.patientId = [alertView textFieldAtIndex:0].text;
            [self logInWithId:self.patientId];
        }
    }
}

- (void)logInWithId:(NSString *)patientId
{
    [[connectionManager sharedManager] fetchInBackgroundWithPatientId:patientId andBlock:^(id Object, NSString *error) {
        if (Object)
        {
            if ([Object isKindOfClass:[NSDictionary class]])
            {
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"currentPatient"];
                [[NSUserDefaults standardUserDefaults] setObject:self.patientId forKey:@"patientId"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self configureModifyButtonWithPatientDict:Object];
            }
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"currentPatient"];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"patientId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self showErrorAlert:error];
            [self configureModifyButtonWithPatientDict:nil];
        }
    }];

}

- (void)showErrorAlert:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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
