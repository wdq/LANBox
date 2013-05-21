//
//  Directory.h
//  Network Files
//
//  Created by LPS Lincoln Public Schools on 4/18/13.
//  Copyright (c) 2013 Lincoln Public Schools. All rights reserved.
//

// This file sets up the array and other information used for the list of files in the table view in the FilesViewController files.

#import <Foundation/Foundation.h>

@interface Directory : NSObject
{
    NSString *fileName;
    NSString *fileType;
    NSString *fileURL;
}

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileType;
@property (nonatomic, copy) NSString *fileURL;

+ (id)fileName:(NSString*)fileName fileType:(NSString*)fileType fileURL:(NSString*)fileURL;

@end
