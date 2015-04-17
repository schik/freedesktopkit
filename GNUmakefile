#
# GNUmakefile
#
# Compile the FreeDesktopKit Framework.
#
# Copyright (C) 2015 Andreas Schik (andreas@schik.de)
#
# This Makefile is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# See the GNU General Public License for more details.
#

include $(GNUSTEP_MAKEFILES)/common.make

FRAMEWORK_NAME=FreeDesktopKit

FreeDesktopKit_HEADER_FILES = \
	FDBaseDirectory.h \
	FDConfigFile.h \
	FDUserdirsFile.h \
	FDDesktopFile.h

FreeDesktopKit_OBJC_FILES = \
	FDBaseDirectory.m \
	FDConfigFile.m \
	FDUserdirsFile.m \
	FDDesktopFile.m

FreeDesktopKit_RESOURCE_FILES =

ADDITIONAL_INCLUDE_DIRS = 
ADDITIONAL_OBJCFLAGS = -Wall
ADDITIONAL_LDFLAGS = 

-include GNUmakefile.preamble

include $(GNUSTEP_MAKEFILES)/framework.make
include $(GNUSTEP_MAKEFILES)/aggregate.make

-include GNUmakefile.postamble
