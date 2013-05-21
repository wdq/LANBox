//
//  ComputersViewController.m
//  Network Files
//
//  Created by William Quade on 5/4/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
@synthesize rightNavBar;
@synthesize aboutView;
@synthesize formWebView;
@synthesize settingsTabBar;
@synthesize settingsTabBarItem;
@synthesize tutorialImages;
@synthesize tutorialButton;
@synthesize tutorialView;


// This method is called when the app runs out of memory. 

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// This method is called when the view loads. It will set the highlighted tab bar item as settings. 

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settingsTabBar.selectedItem = self.settingsTabBarItem;
    self.settingsTabBar.selectedImageTintColor = [UIColor grayColor];
    [self startClick];
    [clickSound play];
}

// This method is called when the view unloads.

- (void)viewDidUnload
{
    [self setSettingsTabBar:nil];
    [self setSettingsTabBarItem:nil];
    [self setRightNavBar:nil];
    [self setAboutView:nil];
    [self setFormWebView:nil];
    [self setTutorialButton:nil];
    [super viewDidUnload];
}

// This method is called when the view begins appearing.

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// This method is called when the view finishes appearing.

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

// This method is called when the view begins disappearing.

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

// This method is called once the view has disappeared.

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

// This method handles device rotation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// This method is called when the about cell is pressed. It will rearange the views so that the about view is visible. 

- (IBAction)aboutCellPressed:(id)sender 
{
    [clickSound play];
    self.aboutView.hidden = FALSE;
    self.formWebView.hidden = TRUE;
    
    self.rightNavBar.topItem.title = @"About";
}

// This method is called when the report an issue cell is pressed. It will rearange the views so that the web view is visible and will go to the correct URL. 

- (IBAction)reportCellPressed:(id)sender 
{
    [clickSound play];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: TRUE]; 

    self.aboutView.hidden = TRUE;
    self.formWebView.hidden = FALSE;
    
    self.rightNavBar.topItem.title = @"Report an issue";

    NSURL *reportURL = [[NSURL alloc] initWithString:@"https://docs.google.com/a/quade.co/forms/d/1v4YlX97nDMUBVsOC1FOr2lrTlG8TJdj9dwEtpyaJGfc/viewform"];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:reportURL];
    [formWebView loadRequest:requestObj];
}

// This method is called when the give feedback cell is pressed. It will rearange the views so that the web view is visible and will go to the correct URL.

- (IBAction)feedbackCellPressed:(id)sender 
{
    [clickSound play];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: TRUE]; 

    self.aboutView.hidden = TRUE;
    self.formWebView.hidden = FALSE;
    
    self.rightNavBar.topItem.title = @"Give feedback";
    
    NSURL *feedbackURL = [[NSURL alloc] initWithString:@"https://docs.google.com/a/quade.co/forms/d/1HA1T5wMKh-ZCpH2pqkDgpqBy72ybpu4oaFmMpBC9Jck/viewform"];

    NSURLRequest *requestObj = [NSURLRequest requestWithURL:feedbackURL];
    [formWebView loadRequest:requestObj];
}

// This method is called when the help cell is pressed. It rearanges the view to show the help view which is a series of tutorial images. The app will figure out which device is being used and what orientation that device is in and use the correct images based on that.

- (IBAction)helpCellPressed:(id)sender 
{
    [clickSound play];
    self.tutorialView.hidden = FALSE;
    self.tutorialButton.hidden = FALSE;
    
    if([[UIDevice currentDevice].model hasPrefix:@"iPad"])
    {
        
        if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPadPortrait.png"],
                              [UIImage imageNamed:@"FileViewiPadPortrait.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPadPortrait.png"],
                              [UIImage imageNamed:@"SettingsiPadPortrait.png"],
                              nil];
        }
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPadLandscape.png"],
                              [UIImage imageNamed:@"FileViewiPadLandscape.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPadLandscape.png"],
                              [UIImage imageNamed:@"SettingsiPadLandscape.png"],
                              nil];
        }
    }
    
    if([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
    {
        if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPhonePortrait.png"],
                              [UIImage imageNamed:@"FileViewiPhonePortrait.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPhonePortrait.png"],
                              [UIImage imageNamed:@"SettingsiPhonePortrait.png"],
                              nil];
        }
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPhoneLandscape.png"],
                              [UIImage imageNamed:@"FileViewiPhoneLandscape.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPhoneLandscape.png"],
                              [UIImage imageNamed:@"SettingsiPhoneLandscape.png"],
                              nil];
        }
        
    }
    tutorialItem = 0;
    self.tutorialView.image = [tutorialImages objectAtIndex:tutorialItem];
}


// This method uses the same statements as the previous one, but handles switching to the next tutorial item, and hiding the view when the tutorial is over.

- (IBAction)nextTutorialItem:(id)sender
{
    [clickSound play];
    if([[UIDevice currentDevice].model hasPrefix:@"iPad"])
    {
        
        if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPadPortrait.png"],
                              [UIImage imageNamed:@"FileViewiPadPortrait.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPadPortrait.png"],
                              [UIImage imageNamed:@"SettingsiPadPortrait.png"],
                              nil];
        }
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPadLandscape.png"],
                              [UIImage imageNamed:@"FileViewiPadLandscape.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPadLandscape.png"],
                              [UIImage imageNamed:@"SettingsiPadLandscape.png"],
                              nil];
        }
    }
    
    if([[UIDevice currentDevice].model hasPrefix:@"iPhone"])
    {
        if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPhonePortrait.png"],
                              [UIImage imageNamed:@"FileViewiPhonePortrait.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPhonePortrait.png"],
                              [UIImage imageNamed:@"SettingsiPhonePortrait.png"],
                              nil];
        }
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            tutorialImages = [NSArray arrayWithObjects:
                              [UIImage imageNamed:@"SaveComputeriPhoneLandscape.png"],
                              [UIImage imageNamed:@"FileViewiPhoneLandscape.png"],
                              [UIImage imageNamed:@"FileOtherAppsiPhoneLandscape.png"],
                              [UIImage imageNamed:@"SettingsiPhoneLandscape.png"],
                              nil];
        }
        
    }
    
    if((self.tutorialView.hidden) == FALSE)
    {
        NSLog(@"Next tutorial item");
        tutorialItem = tutorialItem + 1;
        if (tutorialItem < 4)
        {
            self.tutorialView.image = [tutorialImages objectAtIndex:tutorialItem];
            
        } else {
            self.tutorialView.hidden = TRUE;
            self.tutorialButton.hidden = TRUE;
        }
    }
}


// This method gets rid of the activity indicator once the web view has finished loading.

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: FALSE]; 
}

// On the iPhone this method will hide the views that are not associated with the list of settings.

- (IBAction)doneButton:(id)sender 
{
    [clickSound play];    self.aboutView.hidden = TRUE;
    self.formWebView.hidden = TRUE;
    self.rightNavBar.topItem.title = @"Settings";
}


// This method handles the click sounds.

- (void)startClick
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
    clickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [clickSound prepareToPlay];
}

@end
