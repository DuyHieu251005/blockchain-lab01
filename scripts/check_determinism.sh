#!/usr/bin/env bash
# T8: run the same scenario twice and verify byte-identical logs + final state hash.
set -euo pipefail
CONFIG="${1:-config/default.json}"
OUT=logs/determinism
rm -rf "$OUT" && mkdir -p "$OUT/run1" "$OUT/run2"

# TODO: replace with the real simulator entry point once implemented
python -m l1sim.run --config "$CONFIG" --out "$OUT/run1"
python -m l1sim.run --config "$CONFIG" --out "$OUT/run2"

if diff -r "$OUT/run1" "$OUT/run2" >/dev/null; then
  echo "OK: runs are byte-identical"
else
  echo "FAIL: runs differ"; diff -r "$OUT/run1" "$OUT/run2" | head -50; exit 1
fi
