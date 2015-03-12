//
//  PepleListTableViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/11/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "PeopleListTableViewController.h"
#import "allergy.h"
#import "patient.h"
#import "doctor.h"
#import "connectionManager.h"

@interface PeopleListTableViewController ()

@property (strong, nonatomic) NSArray *dataArray;

@end

@implementation PeopleListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSDate *myDate = [NSDate date];
    NSLocale *locale = [NSLocale currentLocale];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MM/d/yyyy" options:0 locale:locale];
    [formatter setDateFormat:dateFormat];
    [formatter setLocale:locale];
    NSLog(@"Formatted date: %@", [formatter stringFromDate:myDate]);
    if (!_dataArray)
    {
        _dataArray = [[NSArray alloc] init];
    }
    
    switch (self.type) {
        case ListTypeAllergy:
            self.title = @"Allergy Types";
            break;
        case ListTypePatientMoreAllergy:
            self.title = @"Patient With More Than One Allergy";
            break;
        case ListTypePatientPlanToday:
            self.title = [formatter stringFromDate:myDate];
            break;
        case ListTypeAuthorMorePatient:
            self.title = @"Author With More Than One Patient";
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self fetchContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showErrorAlert:(NSString *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)fetchContent
{
    switch (self.type) {
        case ListTypeAllergy:
        {
            [[connectionManager sharedManager] fetchAllergyAndPatientCount:^(NSArray *objects, NSString *error) {
               if (objects)
               {
                   self.dataArray = objects;
                   [self.tableView reloadData];
               }
                else
                {
                    [self showErrorAlert:error];
                }
            }];
        }
            break;
        case ListTypePatientMoreAllergy:
        {
            [[connectionManager sharedManager] fetchPatientWithMoreAllergy:^(NSArray *objects, NSString *error) {
                if (objects)
                {
                    self.dataArray = objects;
                    [self.tableView reloadData];
                }
                else
                {
                    [self showErrorAlert:error];
                }
            }];
        }
            break;
        case ListTypePatientPlanToday:
        {
            [[connectionManager sharedManager] fetchPatientHaveSurgeryToday:^(NSArray *objects, NSString *error) {
                if (objects)
                {
                    self.dataArray = objects;
                    [self.tableView reloadData];
                }
                else
                {
                    [self showErrorAlert:error];
                }
            }];
        }
            break;
        case ListTypeAuthorMorePatient:
        {
            [[connectionManager sharedManager] fetchAuthorMorePatients:^(NSArray *objects, NSString *error) {
                if (objects)
                {
                    self.dataArray = objects;
                    [self.tableView reloadData];
                }
                else
                {
                    [self showErrorAlert:error];
                }
            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataArray.count == 0)
    {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reusing"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reusing"];
    }
    if (self.dataArray.count > 0)
    {
        // Configure the cell...
        switch (self.type) {
            case ListTypeAllergy:
            {
                allergy *theAllergy = [self.dataArray objectAtIndex:indexPath.row];
                if (!theAllergy.Substance || [theAllergy.Substance isEqualToString:@""])
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"Substance: NO SUBSTANCE"];
                }
                else
                {
                    cell.textLabel.text = [NSString stringWithFormat:@"Substance: %@",theAllergy.Substance];
                }
                cell.detailTextLabel.text = [NSString stringWithFormat:@"number of people affected: %@",theAllergy.numberOfPeopleInfected];
            }
                break;
            case ListTypePatientMoreAllergy:
            {
                patient *thePatient = [self.dataArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"PatientId: %@, Name: %@ %@",thePatient.patientId,thePatient.GivenName,thePatient.FamilyName];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Allergies: %@",thePatient.numberOfAllergies];
            }
                break;
            case ListTypePatientPlanToday:
            {
                patient *thePatient = [self.dataArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"PatientId: %@, Name: %@ %@",thePatient.patientId,thePatient.GivenName,thePatient.FamilyName];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"Scheduled Date: %@",thePatient.planDate];
            }
                break;
            case ListTypeAuthorMorePatient:
            {
                doctor *theDoctor = [self.dataArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [NSString stringWithFormat:@"AuthorId: %@, Name: %@ %@ %@",theDoctor.AuthorId,theDoctor.AuthorTitle,theDoctor.AuthorFirstName,theDoctor.AuthorLastName];
                cell.detailTextLabel.text = [NSString stringWithFormat:@"Number of Patients: %@",theDoctor.numberOfPatients];
            }
                break;
            default:
                break;
        }
    }
    else
    {
        cell.textLabel.text = @"No Match";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
