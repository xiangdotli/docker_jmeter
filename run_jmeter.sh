#!/bin/bash

set -e
export JVM_ARGS="-Xms1024m -Xmx1024m"
echo "START Running jmeter on `date`"
jmeter $@
echo "END Running jmeter on `date`"
