#!/bin/bash
P4MERGE="/Applications/p4merge.app/Contents/Resources/launchp4merge"

# Subversion will pass 5 arguments: base theirs mine merged wcfile

# svn will invoke this with a bunch of arguments.  These are:
# $1 - path to the file that is the original
# $2 - path to the file that's the incoming merge version
# $3 - path to the file that's the latest from trunk (current working copy)
# $4 - path to where svn expects the merged output to be written
${P4MERGE} $1 $3 $2 $4