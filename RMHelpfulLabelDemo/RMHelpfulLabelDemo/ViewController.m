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
    
    // Class-level configuration.  We can change colour, default info text displayed, etc.
    // For more control a delegate can be set that generates the labels and handles the help action.
    //[RMHelpfulLabel setInfoFontColor:[UIColor redColor]];
    //[RMHelpfulLabel setInfoString:@"info"];
    //[RMHelpfulLabel setDelegate:self];
    //[RMHelpfulLabel setOKText:@"OK"];
    
    // Create a label manually, overriding some of the defaults
    RMHelpfulLabel *label = [[RMHelpfulLabel alloc] initWithFrame:CGRectMake(20,0,300,100)];
    label.text = @"Manually created Helpful Label";
    label.helpText = @"Manually created help";
    label.helpTitle = @"Manually created title";
    label.infoFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
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

#pragma mark - <RMHelpfulLabelDelegate>

-(id)infoLabelForHelpfulLabel:(RMHelpfulLabel *)helpfulLabel
{
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"?";
    infoLabel.textColor = [UIColor yellowColor];
    [infoLabel sizeToFit];
    return infoLabel;
}

-(void)labelActionForHelpfulLabel:(RMHelpfulLabel *)helpfulLAbel withSender:(id)sender
{
    NSLog(@"Action taken for label: %@, sender: %@", helpfulLAbel, sender);
    [helpfulLAbel doDefaultHelpAction];
}

@end
