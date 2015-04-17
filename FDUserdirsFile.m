/*
 *    FDUserdirsFile.m
 *
 *    Copyright (c) 2015
 *
 *    Author: Andreas Schik <andreas@schik.de>
 *
 *    This program is free software; you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation; either version 2 of the License, or
 *    (at your option) any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#import <Foundation/Foundation.h>
#import "FDUserdirsFile.h"
#import "FDBaseDirectory.h"

@implementation FDUserdirsFile : FDConfigFile

+ (FDUserdirsFile *) defaultUserdirsFile
{
    NSString *configHome = [FDBaseDirectory configHome];
    NSString *udFileName = [configHome stringByAppendingPathComponent: @"user-dirs.dirs"];
    FDUserdirsFile *udFile = [[FDUserdirsFile alloc] initWithContentsOfFile: udFileName];
    return [udFile autorelease];
}

- (NSString *) getUserdir: (NSString *)dir
{
    NSString *_dir = [dir uppercaseString];
    NSString *key = [NSString stringWithFormat: @"XDG_%@_DIR", _dir];
    NSString *userDir = [self getValueForKey: key fromSection: @"_Default"]; 
    if ((nil == userDir) || ([userDir length] == 0)) {
	if ([_dir isEqualToString: @"DESKTOP"]) {
	    userDir = @"$HOME/Desktop";
	} else {
	    userDir = @"$HOME";
	}
    }
    return [userDir stringByReplacingOccurrencesOfString: @"$HOME" withString: NSHomeDirectory()];
}

@end

