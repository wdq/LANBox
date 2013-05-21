//
//  ComputersViewController.m
//  Network Files
//
//  Created by William Quade on 5/4/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

#import "ComputersViewController.h"
#import "Computer.h"
#import "FilesViewController.h"


@implementation ComputersViewController
@synthesize navWithAddButton;
@synthesize navWithoutAddButton;

@synthesize computerArray;
@synthesize computerNameInput;
@synthesize computersTableView;
@synthesize computersTabBar;
@synthesize computersTabBarIcon;
@synthesize addComputerView;
@synthesize typeArray;
@synthesize passwordArray;
@synthesize computerTypeString;
@synthesize computerPassword;
@synthesize addComputerLandscape;
@synthesize computerType;

// These next two methods allow the user to delete items from the table view and the array by sliding, and then tapping delete if they would no longer want a computer to be in their app.

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [computerArray removeObjectAtIndex:indexPath.row];
        [typeArray removeObjectAtIndex:indexPath.row];
        [passwordArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [computersTableView reloadData];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:computerArray forKey:@"computerArray"];
        [defaults setObject:typeArray forKey:@"typeArray"];
        [defaults setObject:passwordArray forKey:@"passwordArray"];
        [defaults synchronize];
    }
}


// These next two methods handle rotation. Rotation is supported on all devices, and certain views are moved around based on rotation. For example there is a different add computer view on the iPhone for portrait and landscape because of the difference in screen height. 

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    if ((self.addComputerView.hidden = FALSE) || (self.addComputerLandscape.hidden = FALSE)) {
        
        if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))

        {
            self.addComputerView.hidden = FALSE;
            self.navWithoutAddButton.hidden = TRUE;
            self.navWithoutAddButton.hidden = FALSE;
        }
        if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
        {
            self.addComputerLandscape.hidden = FALSE;
            self.navWithoutAddButton.hidden = TRUE;
            self.navWithoutAddButton.hidden = FALSE;
        }
    }
    
}


// This method loads the nib.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

// This method is called when the view loads. It will set the tab bar to have the computers section highlighted. It will also get the arrays needed for the table view from NSUserDefaults.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.computersTabBar.selectedItem = self.computersTabBarIcon;
    self.computersTabBar.selectedImageTintColor = [UIColor grayColor];
    
    [self startClick];
    [clickSound play];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    computerArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"computerArray"]];
    typeArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"typeArray"]];
    passwordArray = [[NSMutableArray alloc] initWithArray:[defaults objectForKey:@"passwordArray"]];
}


// This method is called when the app runs out of memory. Nothing is done here since the app doesn't use much memory.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

// This method simply figures out how many cells will be in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection");
    
    return [computerArray count];
    
}

// This is the method that actually puts the items from the array into the table view. All of the data is recieved through NSUserDefaults in previous methods.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cellForRowAtIndexPath");
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
        
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Computer *computer = nil;
    computer = [computerArray objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[computerArray objectAtIndex:[indexPath row]]];
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    return cell;
    
}

#pragma mark - TableView Delegate

// This method is called when a user taps on an item in the table view. It will update the NSUserDefaults for the currently selected computer, and then move over to the files view controller so the user can see the files in that computer.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [clickSound play];
    
    NSString *selectedComputer = [computerArray objectAtIndex:[indexPath row]];
    NSString *selectedType = [typeArray objectAtIndex:[indexPath row]];
    NSString *selectedPassword = [passwordArray objectAtIndex:[indexPath row]];
    
    currentComputer = selectedComputer;
    currentType = selectedType;
    currentPassword = selectedPassword;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentComputer forKey:@"currentComputer"];
    [defaults setObject:currentType forKey:@"currentType"];
    [defaults setObject:currentPassword forKey:@"currentPassword"];
    [defaults synchronize];
    
    NSLog(@"currentComputer = %@", currentComputer);
    NSLog(@"currentType = %@", currentType);
    NSLog(@"currentPassword = %@", currentPassword); 
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (selectedIndex !=NSNotFound)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    selectedIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

// These next two methods will hide the keyboard when the user taps anywhere away from the computer to free up more space especially on the iPhone.

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    [computerPassword resignFirstResponder];
    [computerNameInput resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [computerPassword resignFirstResponder];
    [computerNameInput resignFirstResponder];
    
    return YES;
}

// This mehtod is called when the view unloads.

- (void)viewDidUnload {
    [self setComputerNameInput:nil];
    [self setComputersTableView:nil];
    [self setComputersTabBar:nil];
    [self setComputersTabBarIcon:nil];
    [self setAddComputerView:nil];
    [self setNavWithAddButton:nil];
    [self setNavWithoutAddButton:nil];
    [self setComputerType:nil];
    [self setComputerPassword:nil];
    [self setAddComputerLandscape:nil];
    [super viewDidUnload];
    NSLog(@"Computer view did unload");
}

// This method is called when the user clicks save on the add computer view. It will set up the correct data based on the computer type, hide the view if we are using the iPhone, reload the table view, and update NSUserDefaults.

- (IBAction)saveNameButton:(id)sender 
{
    [clickSound play];
    
    if(self.computerType.selectedSegmentIndex == 0){
        computerTypeString = @"Mac OS X";
	}
	if(self.computerType.selectedSegmentIndex == 1){
        computerTypeString = @"Windows";
	}
    if(self.computerType.selectedSegmentIndex == 2){
        computerTypeString = @"Web Server";
	}
    
    self.addComputerView.hidden = TRUE;
    self.navWithoutAddButton.hidden = FALSE;
    self.navWithoutAddButton.hidden = TRUE;
    
    [computerArray addObject:self.computerNameInput.text];
    [typeArray addObject:computerTypeString];
    [passwordArray addObject:self.computerPassword.text];
    [computersTableView reloadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:computerArray forKey:@"computerArray"];
    [defaults setObject:typeArray forKey:@"typeArray"];
    [defaults setObject:passwordArray forKey:@"passwordArray"];
    [defaults synchronize];

}

// This method is called when the add computer button is pressed on the iPhone. It loads up the correct view based on if the device is portrait or landscape. 

- (IBAction)addComputerButtonPressed:(id)sender 
{
    [clickSound play];
    
    if (UIDeviceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
    {
        self.addComputerView.hidden = FALSE;
        self.navWithoutAddButton.hidden = TRUE;
        self.navWithoutAddButton.hidden = FALSE;
    }
    if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))
    {
        self.addComputerLandscape.hidden = FALSE;
        self.navWithoutAddButton.hidden = TRUE;
        self.navWithoutAddButton.hidden = FALSE;
    }
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
