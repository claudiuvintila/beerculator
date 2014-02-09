//
//  FriendsViewController.h
//  Beerculator
//
//  Created by StartupHub on 09.02.2014.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (atomic, retain) NSArray * numberOfFriends;
@property (nonatomic, retain) IBOutlet UITableView * debtTable;
@end
