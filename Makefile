.PHONY: install lint format test unit e2e determinism

install:
	pip install -e ".[dev]"

lint:
	ruff check .
	ruff format --check .

format:
	ruff format .
	ruff check --fix .

test:
	pytest

unit:
	pytest tests/unit

e2e:
	pytest tests/e2e -m e2e

determinism:
	bash scripts/check_determinism.sh config/default.json
