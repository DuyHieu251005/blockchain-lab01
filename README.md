# Lab01 – Minimal Layer-1 Blockchain

Blockchain course 2026 – Knowledge Engineering Department.

A minimal L1 blockchain that reaches **BFT finality** (Prevote/Precommit, `n = 3f + 1`)
over a **simulated unreliable network** (delay, duplication, reordering, drops).

## Team

| Student ID | Name | GitHub | Main area |
|---|---|---|---|
| ID1 | | | |
| ID2 | | | |
| ID3 | | | |
| ID4 | | | |
| ID5 | | | |

## Project structure

```
src/l1sim/      simulator source (crypto, network, consensus, execution)
tests/unit/     unit tests: signatures/domains, state rules, vote counting, block validation
tests/e2e/      end-to-end scenarios T1–T8
config/         scenario configs (seed, validators, network params)
logs/           run output (git-ignored)
scripts/        helper scripts (determinism check, packaging)
docs/           design notes, diagrams, report sources
```

## Setup

```bash
python3 -m venv .venv && source .venv/bin/activate
make install
```

## Run

```bash
python -m l1sim.run --config config/default.json --out logs/run   # (WIP)
```

## Tests

```bash
make test          # all tests (single entry point)
make unit          # unit tests only
make e2e           # T1–T8
make determinism   # T8: same seed twice -> byte-identical logs + state hash
```

| Test | Scenario | Required outcome |
|---|---|---|
| T1 | Normal run, no faults | All correct nodes finalize same chain & state hash |
| T2 | Duplicate/reordered messages | No double-counted votes, no conflicting finalization |
| T3 | Invalid signature / wrong domain | Message rejected, reason logged |
| T4 | Replayed/duplicate transaction | Applied at most once |
| T5 | Drop/delay before synchrony | Safety holds |
| T6 | Proposer silent/crashed | Round timeout, chain continues |
| T7 | Up to f Byzantine equivocate | No conflicting finalization |
| T8 | Same seed rerun twice | Byte-identical logs & final state hash |

## Workflow

See [CONTRIBUTING.md](CONTRIBUTING.md). `main` is protected: all changes go through a Pull Request
with 1 approval and green CI.
