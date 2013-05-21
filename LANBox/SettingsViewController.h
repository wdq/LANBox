//
//  ComputersViewController.h
//  Network Files
//
//  Created by William Quade on 5/4/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SettingsViewController : UIViewController <UIWebViewDelegate>
{
    NSUInteger tutorialItem;
    AVAudioPlayer *clickSound;
}

// Arrays, strings, and other data types.

@property (nonatomic, strong) NSArray *tutorialImages;

// Outlets and other UI items.

@property (strong, nonatomic) IBOutlet UIButton *tutorialButton;
@property (strong, nonatomic) IBOutlet UIImageView *tutorialView;
@property (weak, nonatomic) IBOutlet UITabBar *settingsTabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *settingsTabBarItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *rightNavBar;
@property (weak, nonatomic) IBOutlet UIView *aboutView;
@property (weak, nonatomic) IBOutlet UIWebView *formWebView;

// Methods and actions.

- (IBAction)aboutCellPressed:(id)sender;
- (IBAction)reportCellPressed:(id)sender;
- (IBAction)feedbackCellPressed:(id)sender;
- (IBAction)helpCellPressed:(id)sender;
- (IBAction)doneButton:(id)sender;
- (IBAction)nextTutorialItem:(id)sender;
- (void)startClick;

@end
