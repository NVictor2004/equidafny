#!/bin/bash

PROFILER_DIR="$HOME/Downloads/async-profiler-4.4-linux-x64/lib/libasyncProfiler.so"
PROJECT_DIR="$HOME/Documents/proving-program-equivalence"

clear

scala run "$PROJECT_DIR" --java-opt="-agentpath:$PROFILER_DIR=start,event=cpu,file=$PROJECT_DIR/profiling/cpu.html"