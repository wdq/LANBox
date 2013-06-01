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
