//
//  allergyViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "allergyViewController.h"
#import "InsetTextField.h"
#import "connectionManager.h"
#import "ProgressHUD.h"

@interface allergyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *allergyIdLabel;
@property (weak, nonatomic) IBOutlet InsetTextField *substanceTextField;
@property (weak, nonatomic) IBOutlet InsetTextField *ReactionTextField;
@property (weak, nonatomic) IBOutlet InsetTextField *statusTextField;

@end

@implementation allergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
}

- (void)closeKeyBoard
{
    [self.view endEditing:YES];
}


- (void)setUpView
{
    self.allergyIdLabel.text = [NSString stringWithFormat:@"Allergy Id: %@",self.theAllergy.Id];
    if (!self.theAllergy.Substance || [self.theAllergy.Substance isEqualToString:@""])
    {
        self.substanceTextField.placeholder = @"no value";
    }
    else
    {
        self.substanceTextField.text = self.theAllergy.Substance;
    }
    if (!self.theAllergy.Reaction || [self.theAllergy.Reaction isEqualToString:@""])
    {
        self.ReactionTextField.placeholder = @"no value";
    }
    else
    {
        self.ReactionTextField.text = self.theAllergy.Reaction;
    }
    if (!self.theAllergy.status || [self.theAllergy.status isEqualToString:@""])
    {
        self.statusTextField.placeholder = @"no value";
    }
    else
    {
        self.statusTextField.text = self.theAllergy.status;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.theAllergy.Substance = self.substanceTextField.text;
    self.theAllergy.Reaction = self.ReactionTextField.text;
    self.theAllergy.status = self.statusTextField.text;
}

- (IBAction)updateAllergy:(id)sender {
    [[connectionManager sharedManager] updateAllergyInBackgroundWithAllergy:self.theAllergy andCompletionBlock:^(BOOL succeed, NSString *error) {
       if (succeed)
       {
           [ProgressHUD showSuccess:@"Succeed"];
           [self dismissViewControllerAnimated:YES completion:^{
               
           }];
       }
        else
        {
            [self showErrorAlert:error];
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


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
