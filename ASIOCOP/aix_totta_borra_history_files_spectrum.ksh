#!/bin/ksh
#
find /usr/local/logs/.History -name "*spectrum-spectrum*.hlog"  -print| xargs rm
