//
//  Utils.m
//  Beerculator
//
//  Created by Claudiu Vintila on 2/9/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import "Utils.h"
#import "DebtsViewController.h"

@implementation Utils

+ (void)storeDebt:(NSNumber *)debt forUsername:(NSString *)username
{
    __block PFObject * currentUser, * dstUser;
    
    currentUser = [PFUser currentUser];

    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //        __block PFObject * dstUser = nil;
        
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
            
            dstUser = objects[0];
            
            PFObject * debtObj = [PFObject objectWithClassName:@"Debt"];
            debtObj[@"source_user"] = dstUser;
            debtObj[@"destination_user"] = currentUser;
            debtObj[@"beers"] = debt;
            [debtObj saveInBackground];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (void)allDebtsForUser:(PFObject *)currentUser forDelegate:(DebtsViewController *)delegate
{
    PFQuery *query = [PFQuery queryWithClassName:@"Debt"];
    [query whereKey:@"source_user" equalTo:currentUser];
    [query includeKey:@"destination_user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d debts.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
            
            [delegate setBeersToGiveAndReload:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

+ (void)allDebtsFromOthers:(PFObject *)currentUser forDelegate:(DebtsViewController *)delegate
{
    PFQuery *query = [PFQuery queryWithClassName:@"Debt"];
    [query whereKey:@"destination_user" equalTo:currentUser];
    [query includeKey:@"source_user"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d debts.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSLog(@"%@", object.objectId);
            }
            
            [delegate setBeersToRecieveAndReload:objects];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

@end
