/*
 LANBox Copyright (c) 2013  William Quade
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
