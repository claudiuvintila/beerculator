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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"Debts";
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
    FriendsViewController * cont = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController" bundle:nil];
    [self presentViewController:cont animated:YES completion:Nil];
//    [Utils storeDebt:[NSNumber numberWithInt:3] forUsername:@"silviuvert"];
//    [Utils allDebts:currentUser];

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

@end
