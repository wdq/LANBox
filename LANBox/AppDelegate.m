//
//  AppDelegate.m
//  LANBox
//
//  Created by LPS Lincoln Public Schools on 5/6/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

#import "AppDelegate.h"
#import "ALSdk.h"

@implementation AppDelegate

@synthesize window = _window;


// This method is called when the app starts up. it will customize the appearance of some of the default UI elements.

- (void)customizeAppearance
{
    
// Nav bar.
    
    UIImage *gradientImage44 = [[UIImage imageNamed:@"gradient_44"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *gradientImage32 = [[UIImage imageNamed:@"gradient_32"]
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [[UINavigationBar appearance] setBackgroundImage:gradientImage44
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:gradientImage32
                                       forBarMetrics:UIBarMetricsLandscapePhone];
        [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
      UITextAttributeTextShadowOffset,
      [UIFont fontWithName:@"Arial-Bold" size:0.0],
      UITextAttributeFont,
      nil]];
    
// Bar button items.
    
    UIImage *button30 = [[UIImage imageNamed:@"button_30"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"button_24"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsLandscapePhone];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIFont fontWithName:@"Arial-Bold" size:0.0],
      UITextAttributeFont,
      nil]
                                                forState:UIControlStateNormal];

// Segmented controls.
    
    UIImage *segmentSelected =
    [[UIImage imageNamed:@"segcontrol_sel.png"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentUnselected =
    [[UIImage imageNamed:@"segcontrol_uns.png"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 15)];
    UIImage *segmentSelectedUnselected =
    [UIImage imageNamed:@"segcontrol_sel-uns.png"];
    UIImage *segUnselectedSelected =
    [UIImage imageNamed:@"segcontrol_uns-sel.png"];
    UIImage *segmentUnselectedUnselected =
    [UIImage imageNamed:@"segcontrol_uns-uns.png"];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected
                                               forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected
                                               forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected
                                 forLeftSegmentState:UIControlStateNormal
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected
                                 forLeftSegmentState:UIControlStateSelected
                                   rightSegmentState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance]
     setDividerImage:segUnselectedSelected
     forLeftSegmentState:UIControlStateNormal
     rightSegmentState:UIControlStateSelected
     barMetrics:UIBarMetricsDefault];

}

// The rest of the app delegate is all default.

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeAppearance];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [ALSdk initializeSdk];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{

}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

@end
