#!/bin/bash

PROFILER_DIR="$HOME/Downloads/async-profiler-4.4-linux-x64/lib/libasyncProfiler.so"
PROJECT_DIR="$HOME/Documents/proving-program-equivalence"

clear

rm -rf "$PROJECT_DIR/src/test/output"
mkdir "$PROJECT_DIR/src/test/output"

scala run "$PROJECT_DIR" --java-opt="-agentpath:$PROFILER_DIR=start,file=$PROJECT_DIR/profiling/profile.html"