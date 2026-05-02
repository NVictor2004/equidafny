#!/bin/bash

PROFILER_DIR="$HOME/Downloads/async-profiler-4.4-linux-x64/bin"
PROJECT_DIR="$HOME/Documents/proving-program-equivalence"

scala compile "$PROJECT_DIR"
clear

rm -rf "$PROJECT_DIR/src/test/output"
mkdir "$PROJECT_DIR/src/test/output"

scala run "$PROJECT_DIR" &

sleep 2
CHILD_PID=$(pgrep -P $!)

"$PROFILER_DIR/asprof" -d 20 -f "$PROJECT_DIR/profiling/profile.html" $CHILD_PID

