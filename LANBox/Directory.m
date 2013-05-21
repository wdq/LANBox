//
//  Directory.m
//  Network Files
//
//  Created by LPS Lincoln Public Schools on 4/18/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

// This file sets up the array and other information used for the list of files in the table view in the FilesViewController files.

#import "Directory.h"

@implementation Directory

@synthesize fileName;
@synthesize fileType;
@synthesize fileURL;

+ (id)fileName:(NSString*)fileName fileType:(NSString*)fileType fileURL:(NSString*)fileURL;
{
    Directory *newDirectory = [[self alloc] init];
    
    [newDirectory setFileName:fileName];
    [newDirectory setFileType:fileType];
    [newDirectory setFileURL:fileURL];
    
    return newDirectory;
}

@end
