//
//  DebtSetViewController.h
//  Beerculator
//
//  Created by Administrator on 09/02/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DebtSetViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *beersLabel;
@property (nonatomic, weak) IBOutlet UIStepper *stepper;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@property NSString *destinationUsername;

- (IBAction)stepperValueChanged:(UIStepper *)sender;
- (IBAction)saveDebt:(UIButton *)sender;


@end
