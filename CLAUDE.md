# Claude Instructions — Lotto (fullstack)

## Read Before Every Edit

Follow project architecture defined in docs/knowledge-base/architecture_overview.md
Follow coding standards defined in docs/knowledge-base/coding_rules.md
Follow TypeScript rules defined in docs/knowledge-base/typescript_rules.md
Respect dependency direction from docs/knowledge-base/dependency_map.md
Respect module boundaries from docs/knowledge-base/module_boundaries.md
Apply SOLID principles from docs/knowledge-base/solid_principles.md
Follow state management rules from docs/knowledge-base/state_management.md
Follow folder placement strategy from docs/knowledge-base/folder_structure.md
Follow Supabase rules from docs/knowledge-base/supabase-rules.md when changing schema, RLS, or Edge Functions
Follow Excel import rules from docs/knowledge-base/excel-import-rules.md when changing SheetJS import flows
Follow Design System from docs/design-system.md when modifying apps/admin-dashboard UI
Run npm run lint and npm run check-types in the touched app before finishing changes

Product contract (parent workspace): ../docs/Lotto-app-contract.md

---

## Graphify — Use Before Exploring Code

This project has a graphify knowledge graph at `graphify-out/`.

**MANDATORY: Before using Read, Grep, Glob, or Bash to explore the codebase, run graphify first:**

```bash
# In Cowork/Claude Code sessions, use the wrapper (auto-installs if needed):
bash scripts/graphify-cowork.sh query "<question>"
bash scripts/graphify-cowork.sh path "<A>" "<B>"
bash scripts/graphify-cowork.sh explain "<concept>"

# Or if graphify is already in PATH:
graphify query "<question>"
graphify path "<A>" "<B>"
graphify explain "<concept>"
```

This applies to every subagent spawned. Include this rule in every subagent prompt involving code exploration.

Only use Read/Grep/Glob directly when:

1. graphify has already oriented you and you need to modify specific lines
2. `graphify-out/graph.json` does not exist yet

- If `graphify-out/wiki/index.md` exists, navigate it instead of reading raw files
- Read `graphify-out/GRAPH_REPORT.md` only for broad architecture review
- After modifying code files, run `graphify update .` to keep the graph current

See `GRAPHIFY.md` for setup, updates, and troubleshooting.
