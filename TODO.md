# trustnotch-web — TODO

Running task list for the public marketing site. Product/server work lives in the KB
(`trustnotch_workfiles`, files 00–10) — keep that separate; this file is web-only.

## Guardrails (every change)
- `trustnotch-web` only; branch + PR, never merge/deploy from here (Sandro merges + deploys).
- After changes: `npm run build` (must build correctly) + sovereignty check (zero external runtime
  requests; self-hosted fonts only).
- Claims boundary: no eIDAS-qualified / SOC 2 / ISO 27001 / customer claims; no live "Sign up" CTA
  (signup not live yet — early-access `mailto:` is correct); no public pricing page.
- Match existing design tokens; no new deps; don't rearchitect.

## In progress
_(none)_

## Backlog
- [ ] Contact address: site uses `hello@trustnotch.com` everywhere; the dashboard's enterprise CTA
      uses `support@trustnotch.com`. **Decision needed from Sandro** (are these intentionally
      different — e.g. sales vs support — or should they be unified?). Do not change contact links
      until decided. **Also blocks the Privacy page** — privacy contact email is a placeholder
      until this is resolved.
- [ ] Mintlify docs site (still pending; separate from these marketing pages).

## Needs Sandro / counsel — Privacy page placeholders
The `/privacy` page is a draft. The following must be confirmed before it is suitable to publish:

- [ ] **Legal entity name** — e.g. "TrustNotch EOOD" (exact registered name).
- [ ] **Registered address** — Bulgarian EOOD registration address.
- [ ] **Privacy contact email** — depends on the hello@ vs support@ decision above.
- [ ] **Log retention period** — how long are web server access logs kept? (e.g. 30 days rolling).
- [ ] **Hosting provider** — confirm provider name and location (e.g. "Hetzner, Helsinki, Finland")
      for the access-log processing disclosure.
- [ ] **CPDP link** — verify `www.cpdp.bg` is current at time of publish.
- [ ] **Counsel review** — have a lawyer read the draft before relying on it.

## Deferred — coupled to PR-6 (public-signup go-live). DO NOT do these until PR-6 ships.
- [ ] Swap the early-access `mailto:` CTA for a real signup CTA once self-serve signup is live.
- [ ] Decide whether to publish a public pricing page (locked EUR tiers) — a deliberate positioning
      call, likely timed with signup go-live. Not before.

## Done
- [x] 2026-06-30 — Extended site to five pages: added `/faq`, `/how-verification-works`,
      `/why-it-matters` + nav (How it works · Why it matters · MCP Server · FAQ) + cross-links.
      FAQ key-rotation and Bitcoin-footprint answers vetted against the architecture before publish.
      Repo reseeded clean (source-only `origin/main`).
- [x] 2026-06-30 — Polish pass: fixed home "Get started" grid (4 cards → clean 2×2, no empty grey
      cells; `repeat(2,1fr)` + mobile 1-col breakpoint). Fixed `how-verification-works` related
      grid (`auto-fill` → `auto-fit`). Audited all 5 pages — shared Layout nav/header/footer
      consistent across all pages, no divergence found.
- [x] 2026-06-30 — Privacy notice page (`/privacy`) added: cookie scan clean (zero matches),
      original prose for GDPR Article 13 duties, all unverifiable values marked `[PLACEHOLDER]`,
      "Privacy" link added to shared footer. Draft — pending placeholder resolution + counsel review.
