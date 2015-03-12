//
//  PatientDetailViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "PatientDetailViewController.h"
#import "patient.h"
#import "Singleton.h"

@interface PatientDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *patientIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientProviderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientGivenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientFamilyNameLebl;
@property (weak, nonatomic) IBOutlet UILabel *patientSuffixLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientFileCreationDateLabel;

@property (strong, nonatomic) patient *thisPatient;

@end

@implementation PatientDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.edgesForExtendedLayout = UIRectEdgeBottom;
    _thisPatient = [[Singleton sharedData].patientArray objectAtIndex:self.pateintIndex];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setUpView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self fetchPlanAndSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchPlanAndSchedule
{
    
}

- (void)setUpView
{
    self.patientIdLabel.text = [NSString stringWithFormat:@"PatientId: %@",self.thisPatient.patientId];
    self.patientProviderIdLabel.text = [NSString stringWithFormat:@"ProviderId: %@",self.thisPatient.providerId];
    self.patientGivenNameLabel.text = [NSString stringWithFormat:@"GivenName: %@",self.thisPatient.GivenName];
    self.patientFamilyNameLebl.text = [NSString stringWithFormat:@"FamilyName: %@",self.thisPatient.FamilyName];
    self.patientSuffixLabel.text = [NSString stringWithFormat:@"Suffix: %@",self.thisPatient.Suffix];
    self.patientGenderLabel.text = [NSString stringWithFormat:@"Gender: %@",self.thisPatient.Gender];
    self.patientBirthdayLabel.text = [NSString stringWithFormat:@"Birthday: %@",self.thisPatient.BirthTime];
    self.patientFileCreationDateLabel.text = [NSString stringWithFormat:@"Creation: %@",self.thisPatient.xmlHealthCreationTime];
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
