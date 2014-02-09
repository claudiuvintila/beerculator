//
//  Utils.h
//  Beerculator
//
//  Created by Claudiu Vintila on 2/9/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Utils : NSObject

+ (void)storeDebt:(NSNumber *)debt forUsername:(NSString *)username;
+ (void)allDebts:(PFObject *)currentUser;
@end
