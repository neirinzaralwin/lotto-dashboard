#!/bin/bash
# Graphify Setup Script — builds the knowledge graph and wires it into Cursor + Claude Code.
set -e

export PATH="$HOME/.local/bin:$PATH"

ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "=========================================="
echo "  Graphify Setup - lotto_fullstack"
echo "=========================================="

setup_project() {
  local dir="$1"
  local label="$2"
  echo ""
  echo "[$label] $dir"
  cd "$dir"

  mkdir -p .cursor/rules scripts

  if [ ! -f .cursor/rules/graphify.mdc ]; then
    echo "  Writing .cursor/rules/graphify.mdc..."
    cat > .cursor/rules/graphify.mdc <<'EOF'
---
description: graphify knowledge graph context
alwaysApply: true
---

This project has a graphify knowledge graph at graphify-out/.

**MANDATORY: Before using Read, Grep, Glob, or Bash to explore the codebase, you MUST run graphify first:**
- `graphify query "<question>"` — scoped subgraph for any codebase or architecture question
- `graphify path "<A>" "<B>"` — dependency path between two symbols
- `graphify explain "<concept>"` — all nodes related to a concept

This applies to YOU and to every subagent you spawn. Include this rule explicitly in every subagent prompt that involves code exploration. Do not skip graphify because files are "already known" or because you are executing a plan — the graph surfaces cross-file dependencies and INFERRED edges that grep and Read cannot find.

Only use Read/Grep/Glob directly when:
1. graphify has already oriented you and you need to modify or debug specific lines
2. `graphify-out/graph.json` does not exist yet

- If `graphify-out/wiki/index.md` exists, navigate it instead of reading raw files
- Read `graphify-out/GRAPH_REPORT.md` only for broad architecture review when query/path/explain do not surface enough context
- After modifying code files, run `graphify update .` to keep the graph current (AST-only, no API cost)
EOF
  fi

  if [ ! -f scripts/graphify-cowork.sh ]; then
    echo "  Writing scripts/graphify-cowork.sh..."
    cat > scripts/graphify-cowork.sh <<'EOF'
#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GRAPHIFY="$SCRIPT_DIR/../.graphify-local/node_modules/.bin/graphify"

if [ ! -f "$GRAPHIFY" ]; then
  echo "[graphify-cowork] Binary not found. Reinstalling..."
  npm install @sentropic/graphify --prefix "$SCRIPT_DIR/../.graphify-local" --silent
fi

if [ -z "$1" ]; then
  echo "Usage: $0 query \"<question>\""
  echo "       $0 path \"<A>\" \"<B>\""
  echo "       $0 explain \"<concept>\""
  exit 1
fi

"$GRAPHIFY" "$@"
EOF
    chmod +x scripts/graphify-cowork.sh
  fi

  if [ ! -f .graphify-local/node_modules/.bin/graphify ]; then
    echo "  Installing @sentropic/graphify locally (.graphify-local/)..."
    npm install @sentropic/graphify --prefix .graphify-local --silent
  fi

  if [ ! -f graphify-out/graph.json ]; then
    echo "  Building graph (first run, AST-only)..."
    # Ensure .graphifyignore keeps the corpus code-only when no LLM key is set.
    graphify . --no-viz
  else
    echo "  Graph exists — running AST update..."
    graphify update .
  fi

  echo "  Regenerating GRAPH_REPORT.md..."
  graphify cluster-only . --no-label --no-viz 2>/dev/null || graphify cluster-only . --no-label

  echo "  Registering global graph..."
  graphify global add graphify-out/graph.json --as "$label" 2>/dev/null || true

  echo "  Installing Cursor rule via graphify CLI..."
  graphify install --platform cursor 2>/dev/null || true

  echo "  Installing git post-commit hook..."
  graphify hook install 2>/dev/null || true

  echo "  ✓ $label done"
}

# Step 1: Install uv if missing
echo ""
echo "[1/4] Checking uv..."
if ! command -v uv &>/dev/null; then
  echo "uv not found. Installing..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"
  source "$HOME/.local/bin/env" 2>/dev/null || true
fi
echo "✓ uv ready: $(uv --version)"

# Step 2: Install graphifyy
echo ""
echo "[2/4] Installing graphifyy with Python 3.11 + leiden..."
uv tool install "graphifyy[leiden]" --python python3.11 --force

echo "✓ graphifyy installed: $(graphify --version)"

# Step 3: Register Claude Code skill
echo ""
echo "[3/4] Registering graphify skill with Claude Code..."
graphify install
echo "✓ Skill registered"

# Step 4: Project setup
setup_project "$ROOT" "lotto_fullstack"

echo ""
echo "[verify] Global graphs:"
graphify global list 2>/dev/null || true

echo ""
echo "=========================================="
echo "  Setup complete!"
echo ""
echo "  Cursor: open lotto_fullstack — agents load"
echo "  .cursor/rules/graphify.mdc and should run"
echo "  graphify query before file exploration."
echo ""
echo "  Refresh after big changes:"
echo "    cd lotto_fullstack && graphify update ."
echo "=========================================="
