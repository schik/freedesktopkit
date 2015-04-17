/*
 *    DesktopFile.m
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
#import "FDDesktopFile.h"

@implementation FDDesktopFile : FDConfigFile

- (NSString *) getExecEntryOfDesktopFile
{
    return [self getValueForKey: @"Exec"
	            fromSection: @"Desktop Entry"];
}

- (NSImage *) getIconEntryOfDesktopFile: (int)size
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSImage *icon = nil;
    NSString *iconPath = [self getValueForKey: @"Icon"
				  fromSection: @"Desktop Entry"];

    if (![iconPath isAbsolutePath]) {
	NSString *ext = [iconPath pathExtension];
	if ([ext length] != 0) {
	    iconPath = [iconPath stringByDeletingPathExtension];
	}
    }
    if ([fm fileExistsAtPath: iconPath]) {
	icon = [[[NSImage alloc] initWithContentsOfFile: iconPath] autorelease];
	[icon setScalesWhenResized: YES];
	[icon setSize: NSMakeSize(size, size)];
    }
    return icon;
}


@end
