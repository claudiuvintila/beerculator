//
//  Utils.h
//  Beerculator
//
//  Created by Claudiu Vintila on 2/9/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "DebtsViewController.h"

@interface Utils : NSObject

+ (void)storeDebt:(NSNumber *)debt forUsername:(NSString *)username;
+ (void)allDebtsForUser:(PFObject *)currentUser forDelegate:(DebtsViewController *)delegate;
+ (void)allDebtsFromOthers:(PFObject *)currentUser forDelegate:(DebtsViewController *)delegate;
@end
