//
//  ViewController.m
//  Network Files
//
//  Created by LPS Lincoln Public Schools on 4/15/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

#import "FilesViewController.h"
#import "Directory.h"
#import "ComputersViewController.h"

@implementation FilesViewController
@synthesize navWithDoneButton;
@synthesize openButton;
@synthesize navWithoutDoneButton;
@synthesize filesTabBar;
@synthesize doneButton;
@synthesize filesTabBarItem;
@synthesize imagePreview;
@synthesize txtPreview;
@synthesize webPreview;
@synthesize videoView;
@synthesize filesTableView;
@synthesize leftNavigation;
@synthesize directoryArray;
@synthesize data;
@synthesize webDataFinal;
@synthesize fileThatWasOpened;
@synthesize computerArray;
@synthesize documentInteractionController;
@synthesize selectedURL;
@synthesize webPath;
@synthesize currentName;
@synthesize currentType;
@synthesize tutorialImages;
@synthesize tutorialButton;
@synthesize tutorialView;


// This method is called whenever the app starts to use up all of the device's memory. This app doesn't really have any memory problems so I don't have to do anything here.

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// This method will change the style of the tab bars in order to have the files tab highlighted. 

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad files");
    [super viewDidLoad]; 
    self.filesTabBar.selectedItem = self.filesTabBarItem;
    self.filesTabBar.selectedImageTintColor = [UIColor grayColor];
    
    [self startClick];
    [clickSound play];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
    clickSound = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [clickSound prepareToPlay];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.filesTableView addSubview:refreshControl];
    
    // Detect if the app has ever been used before. If it has then just continue starting up.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
    }
    
    // If it hasn't then go through an introduction slideshow to teach the user how to use the app.
    
    else
    {
        
        // Set the HasLaunchedOnce default so that the user won't have to go through the tutorial the next time the app launches.
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"First launch");
        
        // Make the tutorial view visible. Then load up the array, and set the tutorial view's image to the very first item in the array. The array is different for each device/device orientation so that the images look the way they should.
        
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
}

// This method handles switching to the next tutorial item with the same statements that set up the arrays from above. It also will hide the tutorial view once all of the images in the array have been viewed.

- (IBAction)nextTutorialItem:(id)sender {
    
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

// This method gets rid of everything when the view unloads.

- (void)viewDidUnload
{
    [self setImagePreview:nil];
    [self setTxtPreview:nil];
    [self setWebPreview:nil];
    [self setVideoView:nil];
    [self setFilesTableView:nil];
    [self setLeftNavigation:nil];
    [self setLeftNavigation:nil];
    [self setOpenButton:nil];
    [self setFilesTabBar:nil];
    [self setFilesTabBarItem:nil];
    [self setDoneButton:nil];
    [self setNavWithDoneButton:nil];
    [self setNavWithoutDoneButton:nil];
    [self setTutorialView:nil];
    [self setTutorialButton:nil];
    [super viewDidUnload];
}

// This method is called when the view appears, it isn't used in this app.

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

// This is called once the view has appeared. I put a lot of stuff here because I needed the data to be sent over and updated from the computers view controller. The view will load, and begin to appear before the computers view finishes doing what it needs to do, so I delayed it until view did appear. 

// This method basically will get the last saved computer name, type, and password from NSUserDefaults, and then get the correct currentComputer's URL based on the computer type. A web server will be simply http:// while a Mac computer would have a .local at the end. 

// The method then goes over to applicationDidUpdateDirectory, and reloads the table view. 

- (void)viewDidAppear:(BOOL)animated
{
    webPath = @"/";
    
    NSLog(@"viewDidAppear files");
    [super viewDidAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    currentComputer = [defaults objectForKey:@"currentComputer"];
    currentType = [defaults objectForKey:@"currentType"];
    currentPassword = [defaults objectForKey:@"currentPassword"];

    if ([currentType isEqualToString:@"Web Server"]) {
        
        currentComputer = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"http://", @"admin:", currentPassword, @"@", currentComputer, webPath];
    }
    
    if ([currentType isEqualToString:@"Mac OS X"]) {
        
        currentComputer = [NSString stringWithFormat:@"%@%@%@%@%@%@%@", @"http://", @"admin:", currentPassword, @"@", currentComputer, @".local", webPath];
    }
    
    if ([currentType isEqualToString:@"Windows"]) {
        
        currentComputer = [NSString stringWithFormat:@"%@%@%@%@%@%@", @"http://", @"admin:", currentPassword, @"@", currentComputer, webPath];
    }
    
    [self applicationDidUpdateDirectory];
    
    NSLog(@"currentComputer files = %@", currentComputer);
    [filesTableView reloadData];
}

// This method is called right before the view disappears. I didn't need to use this method. 

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

// This method is called once the view has disappeared. I didn't need to use this method. 

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

// This app supports all orientations on both the iPhone and the iPad.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

// This method is called once the device has rotated. It is used to load the correct view inside of the iPhone version of the app so that everything is aligned correctly. There is a view for landscape and portrait so that everything fits nicely. It will also update the video player based on the view so that it continues to take up all of the space available. 

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [videoView addSubview:moviePlayer.view];
    [moviePlayer.view setFrame: videoView.bounds]; 
    [videoView addSubview: moviePlayer.view];
    [videoView bringSubviewToFront:moviePlayer.view];
    [moviePlayer setFullscreen:NO animated:YES];
}

// This method is called every time the application needs to update the list of files in the directory. It gets the HTML contents of the web page, and then puts it into the string. All of the unneeded HTML is then removed from the string so there are just file names. At the end of this method setupDirectoryArray is called.


-(void)applicationDidUpdateDirectory
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: TRUE]; 
    
    NSLog(@"applicationDidUpdateDirectory files");
    
    NSError *error;

    NSURL *url = [NSURL URLWithString:currentComputer]; 
    
    NSString *webData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  
    fileThatWasOpened = [NSString stringWithFormat:@"%@", url];    
        
    NSString *webData2 = [webData stringByReplacingOccurrencesOfString:@"<!DOCTYPE HTML PUBLIC" withString:@""];
    NSString *webData3 = [webData2 stringByReplacingOccurrencesOfString:@"-//W3C//DTD HTML 3.2 Final//EN" withString:@""];
    NSString *webData4 = [webData3 stringByReplacingOccurrencesOfString:@"\"\">" withString:@""];
    NSString *webData5 = [webData4 stringByReplacingOccurrencesOfString:@"<html>" withString:@""];
    NSString *webData6 = [webData5 stringByReplacingOccurrencesOfString:@"<head>" withString:@""];
    NSString *webData7 = [webData6 stringByReplacingOccurrencesOfString:@"<title>" withString:@""];
    NSString *webData8 = [webData7 stringByReplacingOccurrencesOfString:@"Index of /" withString:@""];
    NSString *webData9 = [webData8 stringByReplacingOccurrencesOfString:@"</title>" withString:@""];
    NSString *webData10 = [webData9 stringByReplacingOccurrencesOfString:@"</head>" withString:@""];
    NSString *webData11 = [webData10 stringByReplacingOccurrencesOfString:@"<body>" withString:@""];
    NSString *webData12 = [webData11 stringByReplacingOccurrencesOfString:@"<h1>" withString:@""]; 
    NSString *webData13 = [webData12 stringByReplacingOccurrencesOfString:@"Index of /" withString:@""]; 
    NSString *webData14 = [webData13 stringByReplacingOccurrencesOfString:@"</h1>" withString:@""]; 
        
    NSString *webData15 = [webData14 stringByReplacingOccurrencesOfString:@"<ul>" withString:@""]; 
    NSString *webData16 = [webData15 stringByReplacingOccurrencesOfString:@"<li>" withString:@""]; 
    NSString *webData17 = [webData16 stringByReplacingOccurrencesOfString:@"<a href=\"" withString:@""]; 
    NSString *webData18 = [webData17 stringByReplacingOccurrencesOfString:@"\">" withString:@""]; 
    NSString *webData19 = [webData18 stringByReplacingOccurrencesOfString:@"</a>" withString:@""]; 
    NSString *webData20 = [webData19 stringByReplacingOccurrencesOfString:@"</li>" withString:@""]; 
    NSString *webData21 = [webData20 stringByReplacingOccurrencesOfString:@"</ul>" withString:@""]; 
        
    NSString *webData22 = [webData21 stringByReplacingOccurrencesOfString:@"</body>" withString:@""]; 
    NSString *webData23 = [webData22 stringByReplacingOccurrencesOfString:@"</html>" withString:@""]; 

    webDataFinal = [webData23 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self setupDirectoryArray];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: FALSE]; 
}


// This method is called once the app has the information from the directory listing. It goes ahead and sets up an array based on line breaks in the string. It then gets the file name, and the file extension based on where the periods are. The method also handles URLs with spaces which involves %20. Once completed it will add all of the objects to the directoryArray which will then be put into the table view later on.

-(void)setupDirectoryArray 
{
    NSLog(@"setupDirectoryArray files");
    
    NSInteger webDataLength = [[webDataFinal componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] count];
    
    NSArray *webDataArray = [webDataFinal componentsSeparatedByString:@"\n"];
    
    for (id line in webDataArray)

    self.directoryArray = [[NSMutableArray alloc] initWithCapacity:webDataLength];
    
    for (int a = 0; a <= webDataLength - 1; a++) {    
        
        NSArray *filename = [[webDataArray objectAtIndex:a] componentsSeparatedByString: @"  "];
        NSString *filenamestring = [filename objectAtIndex:0];
                
        NSRange typerange = [[webDataArray objectAtIndex:a] rangeOfString:@"." options:NSBackwardsSearch];
                
        NSString *typeresult = [[webDataArray objectAtIndex:a] substringFromIndex:typerange.location+1];
        
        NSString *urlResult = [NSString stringWithFormat:@"%@%@",fileThatWasOpened,filenamestring];
        
        NSLog(@"urlResult: %@", urlResult);
                
        NSString *updatedfilenamestring = [filenamestring stringByReplacingOccurrencesOfString:@"%20" withString:@" "];
        NSString *updatedURLResult = [urlResult stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        [self.directoryArray addObject:[Directory fileName:updatedfilenamestring fileType:typeresult fileURL:updatedURLResult]];
        
        NSLog(@"filename: %@", updatedfilenamestring);
        NSLog(@"filetype: %@", typeresult);
        NSLog(@"fileurl: %@", updatedURLResult);

    }
    
    NSLog(@"array: %@", self.directoryArray);
    
    //NSUInteger indexObject = [self.directoryArray indexOfObject: @"index.php"];
    
    //[self.directoryArray removeObjectAtIndex:indexObject];
    
    [self.directoryArray removeObject:[Directory fileName:@"index.php" fileType:@"php" fileURL:@"http://dev.quade.co/index.php"]];

}



#pragma mark - Table view data source

// This method simply finds out how many cells will be in the table view.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection files");
    
    return [directoryArray count];
}

// This method puts the correct information into the table view cells from the data defined in the previous methods. 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath files");
    
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Directory *directory = nil;
    
    directory = [directoryArray objectAtIndex:[indexPath row]];
        
    [[cell textLabel] setText:[directory fileName]];
    [[cell detailTextLabel] setText:[directory fileType]];    
    cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    
    return cell;
    
}

#pragma mark - TableView Delegate

// This method is called when the user selects an item from the table view. It will basically go ahead and figure out what type of file was selected based on the file extension in one of the arrays. It will then do different things based off of that. For example an image is put into an image view, and a video is put into the video player. If the extension is blank it will recognize the file as a directory and browse deeper into that directory which involves reworking the URL and then going back and updating the array with all of the files, and then the table view.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [clickSound play];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: TRUE]; 
    
    NSLog(@"didSelectRowAtIndexPath files");
    
    [self clearCache];
    
    [moviePlayer pause];
    [networkSound stop];
    
    [self.filesTableView deselectRowAtIndexPath:[self.filesTableView indexPathForSelectedRow] animated:YES];
    
    self.navWithDoneButton.hidden = FALSE;
    self.navWithoutDoneButton.hidden = TRUE;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (selectedIndex !=NSNotFound)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    selectedIndex = indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    selectedURL = [NSURL URLWithString:(NSString *)[[directoryArray objectAtIndex:[indexPath row]] fileURL]];
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"png"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = FALSE;
        
        NSData *imagePreviewData = [NSData dataWithContentsOfURL:selectedURL];
        UIImage *imagePreviewImage = [UIImage imageWithData:imagePreviewData];
        imagePreview.image = imagePreviewImage;  
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"jpeg"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = FALSE;
        
        NSData *imagePreviewData = [NSData dataWithContentsOfURL:selectedURL];
        UIImage *imagePreviewImage = [UIImage imageWithData:imagePreviewData];
        imagePreview.image = imagePreviewImage; 
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
        
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"jpg"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = FALSE;
        
        NSData *imagePreviewData = [NSData dataWithContentsOfURL:selectedURL];
        UIImage *imagePreviewImage = [UIImage imageWithData:imagePreviewData];
        imagePreview.image = imagePreviewImage;  
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
        
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"txt"]) {
        
        self.txtPreview.hidden = FALSE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = TRUE;   
        
        NSError *error;
        NSString *fullTxtURL = [NSString stringWithContentsOfURL:selectedURL encoding:NSUTF8StringEncoding error:&error];
        self.txtPreview.text = fullTxtURL; 
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"mp4"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = FALSE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = TRUE;  
        
        moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:selectedURL];
        [[NSNotificationCenter defaultCenter] 
         addObserver:self
         selector:@selector(movieFinishedCallback:)                                                 
         name:MPMoviePlayerPlaybackDidFinishNotification
         object:moviePlayer];
        [moviePlayer play];    
        moviePlayer.controlStyle = MPMovieControlStyleDefault;
        moviePlayer.shouldAutoplay = YES;
        [videoView addSubview:moviePlayer.view];
        [moviePlayer.view setFrame: videoView.bounds]; 
        [videoView addSubview: moviePlayer.view];
        [videoView bringSubviewToFront:moviePlayer.view];
        [moviePlayer setFullscreen:NO animated:YES];
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"wav"] || [[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"mp3"]) {
        
        NSData *soundData = [NSData dataWithContentsOfURL:selectedURL];
        networkSound = [[AVAudioPlayer alloc] initWithData:soundData error:nil];
        [networkSound prepareToPlay];
        [networkSound play];  
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"html"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = FALSE;
        self.imagePreview.hidden = TRUE;  
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:selectedURL];
        [webPreview loadRequest:requestObj]; 
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }
    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@"php"]) {
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = FALSE;
        self.imagePreview.hidden = TRUE;
        
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:selectedURL];
        [webPreview loadRequest:requestObj];
        
        self.currentName = [[directoryArray objectAtIndex:[indexPath row]] fileName];
        
        self.currentType = [[directoryArray objectAtIndex:[indexPath row]] fileType];
    }

    
    if ([[[directoryArray objectAtIndex:[indexPath row]] fileType] isEqualToString:@""]) {
        
        NSLog(@"Directory selected");
        
        self.txtPreview.hidden = TRUE;
        self.videoView.hidden = TRUE;
        self.webPreview.hidden = TRUE;
        self.imagePreview.hidden = TRUE;         

        NSLog(@"selectedURL: %@", selectedURL);
        
        if ([currentType isEqualToString:@"Web Server"]) {
            
            currentComputer =  [NSString stringWithFormat:@"%@%@", selectedURL, @"/"];
        }
        
        if ([currentType isEqualToString:@"Mac OS X"]) {
            
            currentComputer = [NSString stringWithFormat:@"%@%@%@", selectedURL, @".local", @"/"];
        }
        
        if ([currentType isEqualToString:@"Windows"]) {
            
            currentComputer = [NSString stringWithFormat:@"%@%@", selectedURL, @"/"];
        }
        
        [self applicationDidUpdateDirectory];
        
        // Do any additional setup after loading the view, typically from a nib.
        NSLog(@"currentComputer files = %@", currentComputer);
        [filesTableView reloadData];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: FALSE]; 

    NSLog(@"selectedTo files = %@", selectedURL);
}


// This method handles the file previews.

- (UIViewController *)documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller 
{
    return self;
}

// This method is called when the open or preview button is pressed. It will go ahead and download the file into the temp directory, and then preview it in the preview view built into iOS. You can then open the file in other apps like iPhoto or Photoshop if it's an image, but that part only works on iOS 6. 

- (IBAction)openButtonPressed:(id)sender 
{
    NSLog(@"Open button pressed"); 
    
    [clickSound play];
    
    UIImage *result;
    
    NSString *selectedURLString = [selectedURL absoluteString];
    
    NSData *thedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:selectedURLString]];
    
    if (([currentType isEqualToString:@"jpg"]) || ([currentType isEqualToString:@"jpeg"])) {
    
    result = [UIImage imageWithData:thedata];
    
    [UIImagePNGRepresentation(result) writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", @"image", @"jpg"]] options:NSAtomicWrite error:nil]; 
    
    NSLog(@"File name %@", currentName);
    NSLog(@"File type %@", currentType);
        
    NSString *tempDirectory = NSTemporaryDirectory();
   // NSString *filePath = [NSString stringWithFormat:@"%@.%@/", currentName, currentType, tempDirectory];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/image.jpg", tempDirectory];
    
    imagePreview.image = [[UIImage alloc] initWithContentsOfFile:filePath];
        
     NSURL *theURL = [NSURL fileURLWithPath:filePath];
    
    if (theURL) {
        
        NSLog(@"theURL is true");
        
        documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:theURL];
        
        documentInteractionController.delegate = self;
        
        [documentInteractionController presentPreviewAnimated:YES];
    }  
    }
    
    
    if ([currentType isEqualToString:@"png"]) {
        
        result = [UIImage imageWithData:thedata];
        
        [UIImagePNGRepresentation(result) writeToFile:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", @"image", @"png"]] options:NSAtomicWrite error:nil]; 
        
        NSLog(@"File name %@", currentName);
        NSLog(@"File type %@", currentType);
        
        NSString *tempDirectory = NSTemporaryDirectory();
        // NSString *filePath = [NSString stringWithFormat:@"%@.%@/", currentName, currentType, tempDirectory];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/image.png", tempDirectory];
        
        imagePreview.image = [[UIImage alloc] initWithContentsOfFile:filePath];
        
        NSURL *theURL = [NSURL fileURLWithPath:filePath];
        
        if (theURL) {
            
            NSLog(@"theURL is true");
            
            documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:theURL];
            
            documentInteractionController.delegate = self;
            
            [documentInteractionController presentPreviewAnimated:YES];
        }  
    } 
    
    
     if ([currentType isEqualToString:@"txt"]) {
        
       NSString *result = [[NSString alloc] initWithData:thedata encoding:NSASCIIStringEncoding];

        
        NSString *fileName = @"file.txt";
        NSString *fileAtPath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
        
        [[result dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
        
        
        NSLog(@"File name %@", currentName);
        NSLog(@"File type %@", currentType);
        
        NSString *tempDirectory = NSTemporaryDirectory();
        // NSString *filePath = [NSString stringWithFormat:@"%@.%@/", currentName, currentType, tempDirectory];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/file.txt", tempDirectory];
        
        imagePreview.image = [[UIImage alloc] initWithContentsOfFile:filePath];
        
        NSURL *theURL = [NSURL fileURLWithPath:filePath];
        
        if (theURL) {
            
            NSLog(@"theURL is true");
            
            documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:theURL];
            
            documentInteractionController.delegate = self;
            
            [documentInteractionController presentPreviewAnimated:YES];
        }  
    } 
    
}

// This method is only called on the iPhone version of the app. That is because the iPhone version has a pop up preview view while the iPad version just has the preview off to the side. The done button will close the preview view.  

- (IBAction)doneButtonPressed:(id)sender 
{
    [clickSound play];
    self.txtPreview.hidden = TRUE;
    self.videoView.hidden = TRUE;
    self.webPreview.hidden = TRUE;
    self.imagePreview.hidden = TRUE; 
    self.navWithDoneButton.hidden = TRUE;
    self.navWithoutDoneButton.hidden = FALSE;    
}


// These next two methods will put activity indicators in the status bar letting the user know when a web page is loading in the UIWebView. 

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: TRUE]; 

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible: FALSE]; 
}

// This method clears the temp directory.

-(void)clearCache
{
    for(int i=0; i< 100;i++)
    {
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error;
    NSArray * cacheFiles = [fileManager contentsOfDirectoryAtPath:NSTemporaryDirectory() error:&error];
    
    for(NSString * file in cacheFiles)
    {
        error=nil;
        NSString * filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:file ];
        
        BOOL removed =[fileManager removeItemAtPath:filePath error:&error];
        if(removed ==NO)
        {
        }
        if(error)
        {
            NSLog(@"%@", [error description]);
        }
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

// This method handles the pull to refresh in the table view. It is all defined in the viewDidLoad. 

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self applicationDidUpdateDirectory];
    [filesTableView reloadData];
    [refreshControl endRefreshing];
}

@end
