//
//  LoginViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) UITextField *ipText;
@property (strong, nonatomic) UITextField *portText;
@property (strong, nonatomic) UIButton *loginButton;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UILabel *ipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/6, 150, 35)];
    ipLabel.text = @"Enter IP Address:";
    
    self.ipText = [[UITextField alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height/6 + 45, 240, 40)];
    self.ipText.placeholder = @"Eg:127.0.0.1";
    self.ipText.layer.borderWidth = 1.5f;
    self.ipText.layer.borderColor = [UIColor blackColor].CGColor;
    self.ipText.layer.cornerRadius = 5.0f;
    self.ipText.layer.masksToBounds = YES;
    self.ipText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    UILabel *portLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.ipText.frame.origin.y + 55, 150, 35)];
    portLabel.text = @"Enter Port Number:";
    
    self.portText = [[UITextField alloc] initWithFrame:CGRectMake(20, portLabel.frame.origin.y + 45, 240, 40)];
    self.portText.placeholder = @"Eg:8888";
    self.portText.layer.borderWidth = 1.5f;
    self.portText.layer.borderColor = [UIColor blackColor].CGColor;
    self.portText.layer.cornerRadius = 5.0f;
    self.portText.layer.masksToBounds = YES;
    self.portText.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.portText.frame.origin.y + 100, 60, 30)];
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
    [self.view addSubview:self.ipText];
    [self.view addSubview:portLabel];
    [self.view addSubview:self.portText];
    [self.view addSubview:self.loginButton];
}

- (void)loginDataBase
{
    NSLog(@"clicked");
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
