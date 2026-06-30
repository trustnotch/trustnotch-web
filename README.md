# trustnotch-web

Static marketing site for [TrustNotch](https://trustnotch.com). Built with [Astro](https://astro.build).

## Pages

| Path | Description |
|---|---|
| `/` | Minimal home — headline, how-it-works trio, CTA links |
| `/trustnotch-mcp` | MCP server landing page (the `websiteUrl` in the MCP-registry `server.json`) |

## Local development

```bash
npm install
npm run dev        # dev server at http://localhost:4321
npm run build      # production build → dist/
npm run preview    # preview the built site
```

Node 20+ required.

## Production build

`npm run build` produces a fully static `dist/` directory (no server-side rendering).
All fonts are self-hosted via `@fontsource`; the site makes **no outbound network requests**
to any third-party origin on load.

## Deploying

### First deploy (manual steps with operator)

1. **Build** on your machine or directly on the box:
   ```bash
   npm ci && npm run build
   ```

2. **Create the web root** on the box:
   ```bash
   mkdir -p /srv/trustnotch-web
   ```

3. **Sync `dist/`** to the box:
   ```bash
   rsync -az --delete dist/ user@box:/srv/trustnotch-web/
   ```
   Or use `scripts/deploy.sh` with `TARGET=user@box`:
   ```bash
   TARGET=user@box ./scripts/deploy.sh
   ```

4. **Apply the Caddy snippet** (`deploy/Caddyfile.snippet`):
   - Back up the live Caddyfile first.
   - Paste the snippet blocks into `/etc/caddy/Caddyfile`.
   - Validate: `caddy validate --config /etc/caddy/Caddyfile`
   - Reload: `systemctl reload caddy`

> **Important:** Apply the Caddy config only after `dist/` is in place, so the site
> is immediately reachable after reload. The `api.trustnotch.com` reverse-proxy block
> must point to a running API process on `127.0.0.1:8000` before that subdomain is live.

### Subsequent deploys

```bash
TARGET=user@box ./scripts/deploy.sh
```

No Caddy reload needed for static content changes.

## Repo structure

```
├── src/
│   ├── layouts/Layout.astro   # shared head, header, footer
│   ├── pages/
│   │   ├── index.astro        # /
│   │   └── trustnotch-mcp.astro  # /trustnotch-mcp
│   └── styles/global.css
├── public/
│   ├── favicon.svg
│   ├── og-default.svg         # OG image for /
│   └── og-mcp.svg             # OG image for /trustnotch-mcp
├── deploy/
│   └── Caddyfile.snippet      # Caddy host-split config (apply manually)
└── scripts/
    └── deploy.sh              # build + rsync deploy helper
```

## Design notes

- System/self-hosted fonts only (`@fontsource-variable/inter`, `@fontsource/jetbrains-mono`).
  No Google Fonts, no CDN resources.
- Zero client-side JavaScript on these pages (Astro static output, no islands).
- No analytics, trackers, or cookie banners — consistent with TrustNotch's EU-sovereign positioning.
