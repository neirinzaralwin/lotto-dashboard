# Graphify Guide — lotto_fullstack

Graphify turns this codebase into a queryable knowledge graph so Cursor agents can explore architecture, dependencies, and cross-file relationships without reading every file.

Outputs live in `graphify-out/` (gitignored). Agents should run `graphify query` before broad file exploration — see `.cursor/rules/graphify.mdc`.

---

## Quick Reference

| Task                                          | Command (run from project root)       |
| --------------------------------------------- | ------------------------------------- |
| Query the graph                               | `graphify query "How does X work?"`   |
| Shortest path between symbols                 | `graphify path "A" "B"`               |
| Explain a concept                             | `graphify explain "Draw"`             |
| Incremental update (code only, no API cost)   | `graphify update .`                   |
| Full rebuild (first run or major doc changes) | `graphify . --backend claude-cli`     |
| AST-only first build                          | `graphify . --no-viz`                 |
| Regenerate report only                        | `graphify cluster-only . --no-label`  |
| Check commit hook                             | `graphify hook status`                |
| Skip hook for one commit                      | `GRAPHIFY_SKIP_HOOK=1 git commit ...` |

Cowork / Claude Code sessions can use the wrapper:

```bash
bash scripts/graphify-cowork.sh query "<question>"
bash scripts/graphify-cowork.sh path "<A>" "<B>"
bash scripts/graphify-cowork.sh explain "<concept>"
```

---

## One-Time Setup

```bash
cd ~/Developer/randev/projects/lotto/lotto_fullstack
./setup_graphify.sh
```

The script:

1. Installs `uv` (if missing) and `graphifyy[leiden]` (Python 3.11)
2. Registers the graphify skill for Claude Code (`graphify install`)
3. Builds or updates `graphify-out/graph.json`
4. Ensures `.cursor/rules/graphify.mdc` and `scripts/graphify-cowork.sh` exist
5. Installs a **git post-commit hook** (auto-rebuild after commits)
6. Registers the graph globally (`graphify global add`)

**Prerequisites:** `python3.11` on PATH (`brew install python@3.11` on macOS).

---

## Updating the Graph

### Automatic — after every `git commit`

```bash
graphify hook status
graphify hook install
```

### Manual

```bash
cd ~/Developer/randev/projects/lotto/lotto_fullstack
graphify update .
graphify cluster-only . --no-label
```

---

## Troubleshooting

### `graphify: command not found`

```bash
export PATH="$HOME/.local/bin:$PATH"
uv tool install "graphifyy[leiden]" --python python3.11 --force
```

Or use `bash scripts/graphify-cowork.sh query "..."`.

### Fresh clone — no graph yet

```bash
./setup_graphify.sh
# or
graphify . --no-viz
```

Graph outputs are gitignored. Each developer rebuilds locally after cloning.
