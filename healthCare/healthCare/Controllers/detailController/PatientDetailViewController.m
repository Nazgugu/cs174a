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
#import "connectionManager.h"
#import "allergyViewController.h"
#import "PlanViewController.h"

@interface PatientDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *patientIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientProviderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientGivenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientFamilyNameLebl;
@property (weak, nonatomic) IBOutlet UILabel *patientSuffixLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientGenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientFileCreationDateLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) patient *thisPatient;

@end

@implementation PatientDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.title = @"Patient Detail";
    _thisPatient = [[Singleton sharedData].patientArray objectAtIndex:self.pateintIndex];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tableView.hidden = YES;
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
    [[connectionManager sharedManager] fetchAllergyAndPlansWithPatientId:_thisPatient.patientId andPatientIndex:self.pateintIndex andBlock:^(BOOL succeed, NSString *error) {
        if (succeed)
        {
            self.thisPatient = [[Singleton sharedData].patientArray objectAtIndex:self.pateintIndex];
            //NSLog(@"allergy count = %ld",self.thisPatient.allergies.count);
            //NSLog(@"plan count = %lu",(unsigned long)self.thisPatient.scheduledPlan.count);
            [self.tableView reloadData];
            self.tableView.hidden = NO;
        }
        else
        {
            self.tableView.hidden = YES;
            [self showErrorAlert:error];
        }
    }];
}

- (void)showErrorAlert:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
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

#pragma mark - tableView data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //in this section we store the patient's allergy
    if (section == 0)
    {
       return self.thisPatient.allergies.count;
    }
    //in this section we store the patient's plan
    else
    {
        return self.thisPatient.scheduledPlan.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel sizeToFit];
    headerLabel.font = [UIFont systemFontOfSize:12.0f];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.backgroundColor = [UIColor lightGrayColor];
    if (section == 0)
    {
        headerLabel.text = @"Allergies";
    }
    else
    {
        headerLabel.text = @"Plans";
    }
    return headerLabel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
    }
    //allergies
    if (indexPath.section == 0)
    {
        allergy *theAllergy = [self.thisPatient.allergies objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"id: %@, substance: %@",theAllergy.Id,theAllergy.Substance];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Reaction: %@, Status: %@",theAllergy.Reaction, theAllergy.status];
    }
    //plans
    else
    {
        scheduledPlan *thePlan = [self.thisPatient.scheduledPlan objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"PlanId: %@, Activity: %@",thePlan.PlanId,thePlan.Activity];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Plan date: %@",thePlan.scheduledDate];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self popAlertViewForAllergyAtIndex:indexPath.row];
    }
    else
    {
        [self popAlertViewForPlanAtIndex:indexPath.row];
    }
}

- (void)popAlertViewForAllergyAtIndex:(NSInteger)index
{
    allergyViewController *allergyView = [[allergyViewController alloc] init];
    allergyView.theAllergy = [self.thisPatient.allergies objectAtIndex:index];
    [self presentViewController:allergyView animated:YES completion:^{
        
    }];
}

- (void)popAlertViewForPlanAtIndex:(NSInteger)index
{
    PlanViewController *planView = [[PlanViewController alloc] init];
    planView.theplan = [self.thisPatient.scheduledPlan objectAtIndex:index];
    [self presentViewController:planView animated:YES completion:^{
        
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
