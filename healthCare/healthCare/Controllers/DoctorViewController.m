//
//  DoctorViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "DoctorViewController.h"
#import "connectionManager.h"

@interface DoctorViewController () <UITabBarControllerDelegate, UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSString *doctorId;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem *loginButton;

@property (strong, nonatomic) UIBarButtonItem *logoutButton;

@end

@implementation DoctorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Doctor";
    self.logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"doctorLogout" style:UIBarButtonItemStylePlain target:self action:@selector(doctorLogout)];
    self.navigationItem.leftBarButtonItem= self.logoutButton;
    self.loginButton = [[UIBarButtonItem alloc] initWithTitle:@"doctorLogin" style:UIBarButtonItemStylePlain target:self action:@selector(doctorLogin)];
    self.navigationItem.rightBarButtonItem = self.loginButton;

    self.tabBarController.delegate = self;
}

- (void)doctorLogin
{
    UIAlertView *loginAlert = [[UIAlertView alloc] init];
    loginAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    loginAlert.cancelButtonIndex = 1;
    loginAlert.title = @"Login As Doctor";
    loginAlert.message = @"Please enter doctorId";
    [loginAlert addButtonWithTitle:@"Confirm"];
    [loginAlert addButtonWithTitle:@"Cancel"];
    loginAlert.delegate = self;
    [loginAlert show];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self configureView];
}

- (void)configureView
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"currentDoctor"])
    {
        self.tableView.hidden = NO;
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = self.logoutButton;
    }
    else
    {
        self.tableView.hidden = YES;
        self.navigationItem.rightBarButtonItem = self.loginButton;
        self.navigationItem.leftBarButtonItem = nil;
    }
}

- (void)doctorLogout
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"currentDoctor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self configureView];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (![alertView textFieldAtIndex:0].text || [[alertView textFieldAtIndex:0].text isEqualToString:@""])
        {
            [self doctorLogin];
        }
        else
        {
            self.doctorId = [alertView textFieldAtIndex:0].text;
            [self loginWithId:self.doctorId];
        }
    }
}

- (void)loginWithId:(NSString *)doctorId
{
    [[connectionManager sharedManager] loginInBackgroundWithDoctorId:doctorId andBlock:^(BOOL succeed, NSString *error) {
       if (succeed)
       {
           [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"currentDoctor"];
           [[NSUserDefaults standardUserDefaults] synchronize];
           [self configureView];
       }
        else
        {
            [self showErrorAlert:error];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"currentDoctor"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self configureView];
        }
    }];
}

- (void)showErrorAlert:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"view Patients";
            break;
        case 1:
            cell.textLabel.text = @"view and edit plans";
            break;
        case 2:
            cell.textLabel.text = @"view and edit allergy";
        default:
            break;
    }
    return cell;
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
