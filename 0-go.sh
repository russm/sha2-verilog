#!/bin/bash

set -x

cd "$(dirname "$0")"
export IVERILOG_DUMPER=lxt2


iverilog -Wall testbed.v && ./a.out
