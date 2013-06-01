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
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "ComputersViewController.h"

@interface FilesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UIDocumentInteractionControllerDelegate, UIWebViewDelegate>
{
    AVAudioPlayer *networkSound;
    NSUInteger selectedIndex;
    NSUInteger tutorialItem;
    MPMoviePlayerController *moviePlayer;
    AVAudioPlayer *clickSound;
}

// Arrays, strings, and other data types.

@property (strong,nonatomic) NSMutableArray *directoryArray;
@property (strong,nonatomic) NSMutableArray *computerArray;
@property (strong, nonatomic) NSString *webPath;
@property (strong,nonatomic) NSString *webDataFinal;
@property (strong,nonatomic) NSString *fileThatWasOpened;
@property (strong,nonatomic) NSData *data;
@property (nonatomic, strong) NSURL *selectedURL;
@property (nonatomic, strong) NSString *currentName;
@property (nonatomic, strong) NSString *currentType;
@property (nonatomic, strong) NSArray *tutorialImages;

// UI elements/outlets. 

@property (strong, nonatomic) IBOutlet UIButton *tutorialButton;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;
@property (weak, nonatomic) IBOutlet UILabel *txtPreview;
@property (weak, nonatomic) IBOutlet UIWebView *webPreview;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UITableView *filesTableView;
@property (weak, nonatomic) IBOutlet UINavigationItem *leftNavigation;
@property (weak, nonatomic) IBOutlet UINavigationBar *navWithDoneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navWithoutDoneButton;
@property (weak, nonatomic) IBOutlet UITabBar *filesTabBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITabBarItem *filesTabBarItem;
@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property (strong, nonatomic) IBOutlet UIImageView *tutorialView;

// Actions and methods. 

- (void)applicationDidUpdateDirectory;
- (void)setupDirectoryArray;
- (IBAction)openButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;
- (void)clearCache;
- (IBAction)nextTutorialItem:(id)sender;
- (void)startClick;

@end
