//
//  FriendsViewController.m
//  Beerculator
//
//  Created by StartupHub on 09.02.2014.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import "FriendsViewController.h"
#import "DebtsViewController.h"
@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self retrieveUsers];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)retrieveUsers
{

PFQuery *query = [PFUser query];
[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error) {
        // The find succeeded.
        NSLog(@"Successfully retrieved %d users.", objects.count);
        // Do something with the found objects
        
        for (PFObject *object in objects) {
            NSLog(@"%@", object[@"username"]);
        }
    } else {
        // Log details of the failure
        NSLog(@"Error: %@ %@", error, [error userInfo]);
    }
    
}];
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (self.beersToGive != NULL) {
//        return [self.beersToGive count];
//    }
//    
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"debt_cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"debt_cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//    cell.textLabel.text = ((PFObject *)[self.beersToGive objectAtIndex:indexPath.row])[@"beers"];
//    cell.detailTextLabel.text = @"okokoko";
//    
//    return cell;
//    
//    return  NULL;
//}
 @end
