//
//  DebtsViewController.m
//  Beerculator
//
//  Created by Administrator on 09/02/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import "DebtsViewController.h"
#import "Utils.h"
#import "FriendsViewController.h"
@interface DebtsViewController ()
@end

@implementation DebtsViewController

@synthesize beersToGive;
@synthesize beersToRecieve;
@synthesize debtTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Debts";
        
        self.beersToRecieve = NULL;
        self.beersToGive    = NULL;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        NSLog(@"%@", currentUser);
    } else {
        // show the signup or login screen
        PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
        logInController.delegate = self;
        [self presentViewController:logInController animated:YES completion:NULL];
    }

    [Utils allDebtsForUser:currentUser forDelegate:self];
    [Utils allDebtsFromOthers:currentUser forDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [logInController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setBeersToGiveAndReload:(NSArray *)beersToGiveArray
{
    self.beersToGive = beersToGiveArray;

    [self.debtTable reloadData];
}

- (void)setBeersToRecieveAndReload:(NSArray *)beersToRecieveArray
{
    self.beersToRecieve = beersToRecieveArray;
    
    [self.debtTable reloadData];
}

# pragma mark -
# pragma mark Table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (self.beersToGive != NULL) {
            return [self.beersToGive count];
        }
    }

    if (section == 1) {
        if (self.beersToRecieve != NULL) {
            return [self.beersToRecieve count];
        }
    }

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.beersToGive != NULL) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"debt_cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"debt_cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            PFObject * debt = [self.beersToGive objectAtIndex:indexPath.row];
            NSString * beers = [[debt valueForKey:@"beers"] stringValue];
            NSString * username = ((PFUser *)[debt valueForKey:@"destination_user"])[@"username"];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Beers to give: %@", beers];
            cell.textLabel.text = username;
            
            return cell;
        }
    }
    
    if (indexPath.section == 1) {
        if (self.beersToRecieve != NULL) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"debt_cell"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"debt_cell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            PFObject * debt = [self.beersToRecieve objectAtIndex:indexPath.row];
            NSString * beers = [[debt valueForKey:@"beers"] stringValue];
            NSString * username = ((PFUser *)[debt valueForKey:@"source_user"])[@"username"];
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Beers to recieve: %@", beers];
            cell.textLabel.text = username;
            
            return cell;
        }
    }
    
    return  NULL;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Outgoing beers:";
    }
    
    if (section == 1) {
        return  @"Incomming beers:";
    }
    
    return @"";
}

@end
