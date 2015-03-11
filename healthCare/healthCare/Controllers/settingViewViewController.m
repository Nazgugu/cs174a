//
//  settingViewViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "settingViewViewController.h"
#import "LoginViewController.h"

@interface settingViewViewController ()

@end

@implementation settingViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"setting";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *logoutButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 25, 100, 25)];
    [logoutButton setTitle:@"logout" forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logoutButton.layer.borderWidth = 1.0f;
    logoutButton.layer.borderColor = [UIColor grayColor].CGColor;
    logoutButton.layer.cornerRadius = 5.0f;
    logoutButton.layer.masksToBounds = YES;
    [self.view addSubview:logoutButton];
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
