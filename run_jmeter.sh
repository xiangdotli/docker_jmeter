#!/bin/bash

set -e
export JVM_ARGS="-Xms2048m -Xmx2048m -Xss256k"
echo "START Running jmeter on `date`"
jmeter.sh $@
echo "END Running jmeter on `date`"
