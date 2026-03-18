# Carbonah

> The green measurement tool that plugs into your favourite development environment and stack.

Carbonah measures the **Software Carbon Intensity (SCI)** of your software — ISO/IEC 21031:2024 compliant.

## Install

```bash
# macOS / Linux — one-line install
curl -fsSL https://raw.githubusercontent.com/andrevanzuydam/carbonah-releases/main/install.sh | sh

# Homebrew (macOS / Linux)
brew tap andrevanzuydam/carbonah && brew install carbonah

# Windows (Chocolatey)
choco install carbonah

# From source (requires Rust)
cargo install carbonah
```

## Commands

```bash
carbonah lint .                           # Lint code for carbon-inefficient patterns
carbonah lint --fail-on E002 src/         # CI gate: fail on N+1 queries
carbonah analyse requirements.txt         # Flag oversized dependencies
carbonah measure "npm run build"          # Measure SCI of any command
carbonah session start                    # Track dev machine carbon
```

## What It Catches

| Rule | Pattern | Impact |
|------|---------|--------|
| E002 | N+1 query inside loop | 3.7-7.2x energy waste |
| E003 | SELECT without LIMIT | Unbounded memory/CPU |
| E005 | JSON.parse in loop | CPU waste per iteration |
| E007 | Heavy imports at top level | Slow cold starts |
| D001 | Oversized packages | CI/deploy bloat |
| D003 | Dev tools in production | Unnecessary load |

## Languages

Python, JavaScript, TypeScript, PHP, Ruby, Go, Rust

## Links

- **Website:** [carbonah.dev](https://carbonah.dev)
- **Docs:** [carbonah.dev/rules](https://carbonah.dev/rules)
- **License:** MIT
