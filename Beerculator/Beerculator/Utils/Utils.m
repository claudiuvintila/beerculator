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
    
    __block NSNumber * newDebt = debt;

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
            
            PFQuery *query = [PFQuery queryWithClassName:@"Debt"];
            [query whereKey:@"source_user" equalTo:currentUser];
            [query whereKey:@"destination_user" equalTo:objects[0]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    __block NSNumber * currentDebt = [objects[0] valueForKey:@"beers"];
                    
                    __block PFObject * debtObj = objects[0];
                    
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
                            
//                            PFObject * debtObj = [PFObject objectWithClassName:@"Debt"];
                            debtObj[@"source_user"] = dstUser;
                            debtObj[@"destination_user"] = currentUser;
                            debtObj[@"beers"] = [NSNumber numberWithInt: [currentDebt intValue]+ [newDebt intValue]];
                            [debtObj saveInBackground];
                        } else {
                            // Log details of the failure
                            NSLog(@"Error: %@ %@", error, [error userInfo]);
                        }
                    }];
                } else {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
                
            }];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    

    
}

+ (int)getDebtForUsername:(NSString *)username {
    
    __block PFObject *currentUser;
    
    __block NSNumber * currentDebt;
    
    currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Debt"];
    [query whereKey:@"source_user" equalTo:currentUser];
    [query whereKey:@"destination_user" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            currentDebt = [objects[0] valueForKey:@"beers"];

            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
            
    }];
    
    
    
    return currentDebt;
    
    
    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if(!error) {
//            
//            dstUser = objects[0];
//            
//            PFObject *debtObj = [PFObject objectWithClassName:@"Debt"];
//            debtObj[@"source_user"] = dstUser;
//            debtObj[@"destination_user"] = debt;
//            
//        }
//    }];
//    
    
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
