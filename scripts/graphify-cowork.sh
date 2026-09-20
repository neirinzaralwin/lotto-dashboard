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
