//
//  ViewController.m
//  RMHelpfulLabelDemo
//
//  Created by Robin Macharg on 13/11/2013.
//  Copyright (c) 2013 Techula Ltd. All rights reserved.
//

#import "ViewController.h"
#import "RMHelpfulLabel/RMHelpfulLabel.h"

@interface ViewController ()

@end

@implementation ViewController {
    
    IBOutlet UISwitch *toggleHelpSwitch;
    IBOutlet UIView *labelContainer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [toggleHelpSwitch setOn:NO];
    
    [RMHelpfulLabel setInfoFontColor:[UIColor redColor]];
    [RMHelpfulLabel setInfoString:@"info"];
    
    RMHelpfulLabel *label = [[RMHelpfulLabel alloc] initWithFrame:CGRectMake(0,0,320,100)];
    label.text = @"Manually created Helpful Label";
    label.helpText = @"Manually created help";
    label.helpTitle = @"Manually created title";
    label.infoFontColor = [UIColor blueColor];
    label.infoString = @"Tell me";
    [label sizeToFit];
    [labelContainer addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleHelp:(id)sender {
    [RMHelpfulLabel setHelpEnabled:[toggleHelpSwitch isOn]];
}

@end
