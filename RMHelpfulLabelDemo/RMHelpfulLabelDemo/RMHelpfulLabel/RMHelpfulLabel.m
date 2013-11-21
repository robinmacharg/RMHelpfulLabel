//
//  RMHelpfulLabel.m
//
//  Created by Robin Macharg on 13/11/2013.
//
// Use:
// Create a UILabel and set its custom class to UIHelpLabel.
// In Interface Builder set the helpTitle (optional) and helpText user defined runtime attributes to appropriate strings

#import "RMHelpfulLabel.h"

static BOOL helpEnabled = NO;
static UIFont *_infoFont;
static UIColor *_infoFontColor;
static NSString *_infoString;
static id _delegate;
static NSString *_OKText;

@interface RMHelpfulLabel ()
@end

@implementation RMHelpfulLabel {
    UILabel *infoLabel;
    UITapGestureRecognizer *gestureRecogniser;
}

#pragma mark - Class property accessors

+(void)setHelpEnabled:(BOOL)enabled
{
    helpEnabled = enabled;
    [[NSNotificationCenter defaultCenter] postNotificationName:RMHELPFULLABELHELPSTATECHANGED object:nil];
}

+(BOOL)helpEnabled
{
    return helpEnabled;
}

+(void)setInfoFont:(UIFont *)infoFont
{
    _infoFont = infoFont;
}

+(UIFont *)infoFont
{
    if (!_infoFont) {
        _infoFont = [UIFont fontWithName:@"Menlo" size:11];
    }
    return _infoFont;
}

+(void)setInfoFontColor:(UIColor *)infoFontColor
{
    _infoFontColor = infoFontColor;
}

+(UIColor *)infoFontColor
{
    if (!_infoFontColor) {
        _infoFontColor = [UIColor blueColor];
    }
    return _infoFontColor;
}

+(void)setInfoString:(NSString *)infoString
{
    _infoString = infoString;
}

+(NSString *)infoString
{
    if (!_infoString) {
        _infoString = @"i";
    }
    return _infoString;
}

+(void)setDelegate:(id)delegate
{
    _delegate = delegate;
}

+(id)delegate
{
    return _delegate;
}

+(void)setOKText:(NSString *)OKText
{
    _OKText = OKText;
}

+(NSString *)OKText
{
    if (!_OKText) {
        _OKText = @"Got it";
    }
    return _OKText;
}

#pragma mark - View lifecycle

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeLabel];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initializeLabel];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:RMHELPFULLABELHELPSTATECHANGED
                                                  object:nil];
}

#pragma mark - Helper methods

-(void)initializeLabel
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(helpStateChanged:)
                                                 name:RMHELPFULLABELHELPSTATECHANGED object:nil];
    [self enableHelp:[RMHelpfulLabel helpEnabled]];
}

-(void)enableHelp:(BOOL)enable
{
    if (enable) {
        if ([self.helpText length]) {
            gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showHelp:)];
            gestureRecogniser.numberOfTapsRequired = 1;
            [self addGestureRecognizer:gestureRecogniser];
            self.userInteractionEnabled = YES;
            self.clipsToBounds = NO;
            [self sizeToFit];
            
            // The delegate can provide an info label
            if ([[self class] delegate] != nil && [[[self class] delegate] respondsToSelector:@selector(infoLabelForHelpfulLabel:)]) {
                infoLabel = [[[self class] delegate] infoLabelForHelpfulLabel:self];
            }
            else {
                infoLabel = [[UILabel alloc] init];
                infoLabel.text = self.infoString ? self.infoString : [[self class] infoString];
                infoLabel.font = self.infoFont ? self.infoFont : [[self class] infoFont];
                infoLabel.textColor = self.infoFontColor ? self.infoFontColor : [[self class] infoFontColor];
                [infoLabel sizeToFit];
            }
            
            [self addSubview:infoLabel];
            
            CGRect labelFrame = self.frame;
            CGRect iLabelFrame = infoLabel.frame;
            iLabelFrame.origin.x = labelFrame.size.width;
            iLabelFrame.origin.y = 0;
            [infoLabel setFrame:iLabelFrame];

        }
        else {
            NSLog(@"WARNING: Help text is not defined for HelpLabel with text \"%@\" %@", self.text, self);
        }
    }
    else {
        [self removeGestureRecognizer:gestureRecogniser];
        [infoLabel removeFromSuperview];
    }
    
}

#pragma mark - Notifications

-(void)helpStateChanged:(NSNotification *)notification
{
    [self enableHelp:helpEnabled];
}

#pragma mark - Actions

-(void)showHelp:(id)sender
{
    // The delegate can handle the help action
    if ([[self class] delegate] != nil && [[[self class] delegate] respondsToSelector:@selector(labelActionForHelpfulLabel:withSender:)]) {
        [[[self class] delegate] labelActionForHelpfulLabel:self withSender:sender];
    }
    else {
        [self doDefaultHelpAction];
    }
}

-(void)doDefaultHelpAction
{
    NSString *text = self.helpText;
    NSString *title = self.helpTitle;
    
    [[[UIAlertView alloc] initWithTitle:[title length] ? title : @"Help"
                                message:text
                               delegate:self
                      cancelButtonTitle:Nil
                      otherButtonTitles:[self.helpOKText length] ? self.helpOKText : [[self class] OKText], nil] show];
}

@end
