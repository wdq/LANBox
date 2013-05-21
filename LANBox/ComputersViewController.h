//
//  ComputersViewController.h
//  Network Files
//
//  Created by William Quade on 5/4/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

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
