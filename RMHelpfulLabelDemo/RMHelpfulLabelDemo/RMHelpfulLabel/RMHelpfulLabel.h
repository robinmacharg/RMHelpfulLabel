//
//  RMHelpfulLabel.h
//
//  Created by Robin Macharg on 13/11/2013.
//

#define RMHELPFULLABELHELPSTATECHANGED @"RMHELPFULLABELHELPSTATECHANGED"

#import <UIKit/UIKit.h>

@interface RMHelpfulLabel : UILabel

@property (nonatomic, strong) NSString *helpTitle;
@property (nonatomic, strong) NSString *helpText;
@property (nonatomic, strong) NSString *helpOKText;
@property (nonatomic, strong) NSString *infoString;
@property (nonatomic, strong) UIFont *infoFont;
@property (nonatomic, strong) UIColor *infoFontColor;

+(void)setHelpEnabled:(BOOL)enabled;
+(BOOL)helpEnabled;
+(void)setInfoFont:(UIFont *)infoFont;
+(UIFont *)infoFont;
+(void)setInfoFontColor:(UIColor *)infoFontColor;
+(UIColor *)infoFontColor;
+(void)setInfoString:(NSString *)infoString;
+(NSString *)infoString;


-(void)enableHelp:(BOOL)enable;

@end
