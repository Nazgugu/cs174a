//
//  PlanViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "PlanViewController.h"
#import "InsetTextField.h"


@interface PlanViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet InsetTextField *planActivityLabel;
@property (weak, nonatomic) IBOutlet InsetTextField *planDateLabel;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text = [NSString stringWithFormat:@"Plan Id: %@",self.theplan.PlanId];
}

- (void)setUpView
{
    if (!self.theplan.Activity || [self.theplan.Activity isEqualToString:@""])
    {
        self.planActivityLabel.placeholder = @"no value";
    }
    else
    {
        self.planActivityLabel.text = self.theplan.Activity;
    }
    if (!self.theplan.scheduledDate || [self.theplan.scheduledDate isEqualToString:@""])
    {
        self.planDateLabel.placeholder = @"no value";
    }
    else
    {
        self.planDateLabel.text = self.theplan.scheduledDate;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)updatePlan:(id)sender {
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.theplan.Activity = self.planActivityLabel.text;
    self.theplan.scheduledDate = self.planDateLabel.text;
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