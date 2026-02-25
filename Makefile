# Makefile for SvelteKit (works with npm / pnpm / yarn / bun)
# Usage:
#   make dev
#   make build
#   make preview
#   make check
#   make format
#   make lint
#   make clean

SHELL := /bin/zsh

# Detect package manager (lockfile priority)
PM := npm
ifeq ($(wildcard pnpm-lock.yaml),pnpm-lock.yaml)
  PM := pnpm
else ifeq ($(wildcard yarn.lock),yarn.lock)
  PM := yarn
else ifeq ($(wildcard bun.lockb),bun.lockb)
  PM := bun
else ifeq ($(wildcard package-lock.json),package-lock.json)
  PM := npm
endif

# Commands per package manager
ifeq ($(PM),pnpm)
  RUN := pnpm
  DLX := pnpm dlx
else ifeq ($(PM),yarn)
  RUN := yarn
  DLX := yarn dlx
else ifeq ($(PM),bun)
  RUN := bun
  DLX := bunx
else
  RUN := npm run
  DLX := npx
endif

.PHONY: help pm install dev build preview check lint format test clean deps doctor

help:
	@printf "\nSvelteKit Make targets\n"
	@printf "  make pm        - show detected package manager\n"
	@printf "  make install   - install dependencies\n"
	@printf "  make dev       - start dev server\n"
	@printf "  make build     - build for production\n"
	@printf "  make preview   - preview production build\n"
	@printf "  make check     - typecheck/svelte-check (if configured)\n"
	@printf "  make lint      - lint (if configured)\n"
	@printf "  make format    - format (if configured)\n"
	@printf "  make test      - test (if configured)\n"
	@printf "  make clean     - remove build artifacts\n\n"

pm:
	@echo "Package manager: $(PM)"

install:
ifeq ($(PM),npm)
	@npm install
else
	@$(RUN) install
endif

dev:
ifeq ($(PM),npm)
	@npm run dev -- --open
else
	@$(RUN) dev --open
endif

build:
	@$(RUN) build

preview:
ifeq ($(PM),npm)
	@npm run preview -- --open
else
	@$(RUN) preview --open
endif

check:
	@$(RUN) check

lint:
	@$(RUN) lint

format:
	@$(RUN) format

test:
	@$(RUN) test

# Remove typical SvelteKit/Vite outputs
clean:
	@rm -rf .svelte-kit build dist .vite node_modules/.cache

# Show dependency tree / basic health
deps:
ifeq ($(PM),npm)
	@npm ls --depth=0 || true
else ifeq ($(PM),pnpm)
	@pnpm list --depth=0 || true
else ifeq ($(PM),yarn)
	@yarn list --depth=0 || true
else
	@bun pm ls || true
endif

doctor:
	@echo "Node: $$(node -v 2>/dev/null || echo 'not found')"
	@echo "PM: $(PM)"
	@echo "Project: $$(node -p "require('./package.json').name" 2>/dev/null || echo '?')"
