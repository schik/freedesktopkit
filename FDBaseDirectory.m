/*
 *    FDBaseDirectory.m
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
#import "FDBaseDirectory.h"

@implementation FDBaseDirectory : NSObject

+ (NSString *) dataHome
{
    NSString *dataHome = [[[NSProcessInfo processInfo] environment] objectForKey: @"XDG_DATA_HOME"];
    if ((nil == dataHome) || ([dataHome length] == 0)) {
	dataHome = @"$HOME/.local/share";
    }
    return [dataHome stringByReplacingOccurrencesOfString: @"$HOME" withString: NSHomeDirectory()];
}

+ (NSString *) configHome
{
    NSString *configHome = [[[NSProcessInfo processInfo] environment] objectForKey: @"XDG_CONFIG_HOME"];
    if ((nil == configHome) || ([configHome length] == 0)) {
	configHome = @"$HOME/.config";
    }
    return [configHome stringByReplacingOccurrencesOfString: @"$HOME" withString: NSHomeDirectory()];
}

+ (NSString *) cacheHome
{
    NSString *cacheHome = [[[NSProcessInfo processInfo] environment] objectForKey: @"XDG_CACHE_HOME"];
    if ((nil == cacheHome) || ([cacheHome length] == 0)) {
	cacheHome = @"$HOME/.cache";
    }
    return [cacheHome stringByReplacingOccurrencesOfString: @"$HOME" withString: NSHomeDirectory()];
}
+ (NSArray *) dataDirs
{
    NSString *dataDirs = [[[NSProcessInfo processInfo] environment] objectForKey: @"XDG_DATA_DIRS"];
    if ((nil == dataDirs) || ([dataDirs length] == 0)) {
	dataDirs = @"/usr/local/share/:/usr/share/";
    }
    return [dataDirs componentsSeparatedByString: @":"];
}

+ (NSArray *) configDirs
{
    NSString *configDirs = [[[NSProcessInfo processInfo] environment] objectForKey: @"XDG_CONFIG_DIRS"];
    if ((nil == configDirs) || ([configDirs length] == 0)) {
	configDirs = @"/etc/xdg/";
    }
    return [configDirs componentsSeparatedByString: @":"];
}

@end

