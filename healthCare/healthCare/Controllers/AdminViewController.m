//
//  AdminViewController.m
//  healthCare
//
//  Created by Liu Zhe on 3/8/15.
//  Copyright (c) 2015 Liu Zhe. All rights reserved.
//

#import "AdminViewController.h"
#import "PeopleListTableViewController.h"

@interface AdminViewController () <UITabBarControllerDelegate,UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Administrator";
    self.tabBarController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"usable"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"usable"];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Patient number for each type of allergy";
            break;
        case 1:
            cell.textLabel.text = @"Patients who have more than one allergy";
            break;
        case 2:
            cell.textLabel.text = @"Patients who have plan for surgery today";
            break;
        case 3:
            cell.textLabel.text = @"Authors with more than one patiens";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeopleListTableViewController *list = [[PeopleListTableViewController alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            list.type = ListTypeAllergy;
        }break;
        case 1:
        {
            list.type = ListTypePatientMoreAllergy;
        }
            break;
        case 2:
        {
            list.type = ListTypePatientPlanToday;
        }
            break;
        case 3:
        {
            list.type= ListTypeAuthorMorePatient;
        }
            break;
        default:
            break;
    }
    list.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:list animated:YES];
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
