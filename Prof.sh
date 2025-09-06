#!/bin/sh
set -e

if ! test -d "prof"; then
    mkdir "prof"
fi

cabal run -v0 plebcodes-bench --enable-profiling -- +RTS -s -hy -p -po"prof/bench" -l -ol"prof/bench.eventlog"
eventlog2html prof/bench.eventlog

exit 0
