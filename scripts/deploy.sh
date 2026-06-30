#!/usr/bin/env bash
# deploy.sh — Build and sync trustnotch-web to the production server.
#
# Usage:
#   TARGET=user@box.example.com ./scripts/deploy.sh
#
# If TARGET is unset the built dist/ is copied locally to /srv/trustnotch-web
# (useful when the build runs directly on the production box).
#
# Requirements: Node 20+, npm, rsync (for remote deploys), ssh access to TARGET.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST="$REPO_ROOT/dist"
REMOTE_PATH="${REMOTE_PATH:-/srv/trustnotch-web}"
TARGET="${TARGET:-}"

echo "==> Building trustnotch-web"
cd "$REPO_ROOT"
npm ci
npm run build

echo "==> Build complete — dist/ ready"

if [ -n "$TARGET" ]; then
  echo "==> Syncing to $TARGET:$REMOTE_PATH"
  rsync -az --delete --checksum "$DIST/" "$TARGET:$REMOTE_PATH/"
  echo "==> Done. Reload Caddy on the box if this is the first deploy:"
  echo "    ssh $TARGET 'caddy validate --config /etc/caddy/Caddyfile && systemctl reload caddy'"
else
  echo "==> TARGET not set — copying locally to $REMOTE_PATH"
  mkdir -p "$REMOTE_PATH"
  rsync -a --delete "$DIST/" "$REMOTE_PATH/"
  echo "==> Done."
fi
