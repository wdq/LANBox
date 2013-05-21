//
//  Directory.m
//  Network Files
//
//  Created by LPS Lincoln Public Schools on 4/18/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

// This file sets up the array and other information used for the list of computers in the table view in the ComputerViewController files.

#import "Computer.h"

@implementation Computer

@synthesize computerName;
@synthesize computerType;
@synthesize computerURL;

+ (id)computerName:(NSString*)computerName computerType:(NSString*)computerType computerURL:(NSString*)computerURL;
{
    Computer *newComputer = [[self alloc] init];
    
    [newComputer setComputerName:computerName];
    [newComputer setComputerType:computerType];
    [newComputer setComputerURL:computerURL];
    
    return newComputer;
}

@end
