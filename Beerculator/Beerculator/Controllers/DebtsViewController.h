//
//  DebtsViewController.h
//  Beerculator
//
//  Created by Administrator on 09/02/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DebtsViewController : UIViewController <PFLogInViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (atomic, retain) NSArray * beersToGive;
@property (atomic, retain) NSArray * beersToRecieve;

@property (nonatomic, retain) IBOutlet UITableView * debtTable;

- (void)setBeersToGiveAndReload:(NSArray *)beersToGiveArray;
- (void)setBeersToRecieveAndReload:(NSArray *)beersToRecieveArray;

@end
