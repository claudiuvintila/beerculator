//
//  DebtSetViewController.m
//  Beerculator
//
//  Created by Administrator on 09/02/14.
//  Copyright (c) 2014 Claudiu Vintila. All rights reserved.
//

#import "DebtSetViewController.h"
#import "Utils.h"

@interface DebtSetViewController ()

@end

@implementation DebtSetViewController

@synthesize stepper;

- (IBAction)stepperValueChanged:(UIStepper *)sender {
    self.beersLabel.text = [NSString stringWithFormat:@"%d", (int)stepper.value];
}

- (IBAction)saveDebt:(UIButton *)sender {
    [Utils storeDebt:[NSNumber numberWithInt:self.stepper.value] forUsername:self.destinationUsername];
}

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
    // Do any additional setup after loading the view from its nib.
    
    
    //TODO: get name of destination user
    self.destinationUsername = @"claudiu.vintila";
    self.nameLabel.text = self.destinationUsername;
    
    //TODO: set current value of debt of destination user
    self.stepper.value = 1;
    
    self.beersLabel.text = @"1";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
