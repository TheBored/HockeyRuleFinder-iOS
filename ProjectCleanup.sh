#! /bin/bash
# This script contains the normal Synx command to run. This should be run before each commit.
#
# For more information about Synx, see: https://github.com/venmo/synx
#
# While Synx may be run manually with different parameters, this command should be kept up to date with the standard excludes in order to maintain a clean project directory.
#
# Current excludes:
# Externals: Folder containing third party code. Some files are moved around in the Xcode project and cleanup would disrupt the build process.
#
synx -e "/Externals" Hockey\ Rule\ Finder.xcodeproj/