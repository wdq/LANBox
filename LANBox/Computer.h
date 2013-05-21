//
//  Directory.h
//  Network Files
//
//  Created by LPS Lincoln Public Schools on 4/18/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

// This file sets up the array and other information used for the list of computers in the table view in the ComputerViewController files.

#import <Foundation/Foundation.h>

@interface Computer : NSObject
{
    NSString *computerName;
    NSString *computerType;
    NSString *computerURL;
}

@property (nonatomic, copy) NSString *computerName;
@property (nonatomic, copy) NSString *computerType;
@property (nonatomic, copy) NSString *computerURL;

+ (id)computerName:(NSString*)computerName computerType:(NSString*)computerType computerURL:(NSString*)computerURL;

@end
