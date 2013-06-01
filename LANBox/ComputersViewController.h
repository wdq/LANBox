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

@interface ComputersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate>
{
    NSUInteger selectedIndex;
    NSString *computerArrayString;
    AVAudioPlayer *clickSound;
}

// Arrays, strings, and other data types.

@property (strong,nonatomic) NSMutableArray *computerArray;
@property (strong,nonatomic) NSMutableArray *passwordArray;
@property (strong,nonatomic) NSMutableArray *typeArray;
@property (strong, nonatomic) NSString *computerTypeString;

// UI elements and objects.

@property (weak, nonatomic) IBOutlet UITextField *computerNameInput;
@property (weak, nonatomic) IBOutlet UITableView *computersTableView;
@property (weak, nonatomic) IBOutlet UITabBar *computersTabBar;
@property (weak, nonatomic) IBOutlet UITabBarItem *computersTabBarIcon;
@property (weak, nonatomic) IBOutlet UIView *addComputerView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navWithAddButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navWithoutAddButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *computerType;
@property (strong, nonatomic) IBOutlet UITextField *computerPassword;
@property (weak, nonatomic) IBOutlet UIView *addComputerLandscape;

// Actions and methods.

- (IBAction)addComputerButtonPressed:(id)sender;
- (IBAction)saveNameButton:(id)sender;
- (void)startClick;

@end
