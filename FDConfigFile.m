/*
 *    ConfigFile.m
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

#import <Foundation/NSString.h>
#import <Foundation/Foundation.h>
#import "FDConfigFile.h"

@implementation FDConfigFile : NSObject

- (id) initWithContentsOfFile: (NSString *)file
{
    self = [super init];
    if (self) {
        sections = [NSMutableDictionary new];
        NSStringEncoding enc;
        NSString *cont = [NSString stringWithContentsOfFile: file
                usedEncoding: &enc error: NULL];
        NSArray *lines = [cont componentsSeparatedByString: @"\n"];
        NSMutableDictionary *entries = nil;

        int count = [lines count];
        int i;
        for (i = 0; i < count; i++) {
            NSString *line = [[lines objectAtIndex: i] stringByTrimmingCharactersInSet:
		[NSCharacterSet whitespaceCharacterSet]];
            if ([line hasPrefix: @"["] && [line hasSuffix: @"]"]) {
                NSString *section = [line substringWithRange: NSMakeRange(1, [line length] - 2)];
		if ([sections objectForKey: section] == nil) {
		    entries = [NSMutableDictionary new];
		    [sections setObject: entries forKey: section];
		    [entries release];
		}
            } else {
                NSArray *parts = [line componentsSeparatedByString: @"="];
                if ([parts count] == 2) {
		    NSString *key = [[parts objectAtIndex: 0] stringByTrimmingCharactersInSet:
			[NSCharacterSet whitespaceCharacterSet]];
		    NSString *value = [[parts objectAtIndex: 1] stringByTrimmingCharactersInSet:
			[NSCharacterSet whitespaceCharacterSet]];
		    value = [value stringByTrimmingCharactersInSet:
			[NSCharacterSet characterSetWithCharactersInString: @"\"'"]];

		    if (nil == entries) {
			entries = [NSMutableDictionary new];
			[sections setObject: entries forKey: @"_Default"];
			[entries release];
		    }
                    [entries setObject: value forKey: key];
                }
            }
        }
    }
    return self;
}

- (void) dealloc
{
    [sections release];
    [super dealloc];
}

- (NSString *) getValueForKey: (NSString *)key fromSection: (NSString *)section
{
    NSString *value = nil;
    NSDictionary *entries = [sections objectForKey: section];
    value = [entries objectForKey: key];
    return value;
}

- (BOOL) getBooleanForKey: (NSString *)key fromSection: (NSString *)section
{
    NSString *value = [self getValueForKey:key fromSection: section];
    return [value boolValue];
}

@end
