# AGENTS.md

Personal Quartz 4 fork (SSG, Preact SPA). Content is Obsidian-synced markdown in `content/`; site code in `quartz/`. Live at `animishraa05.github.io` via GitHub Pages (`public/`).

## Commands (pnpm only, `engine-strict=true`)

- Install: `pnpm install --frozen-lockfile` (pkg mgr `pnpm@11.1.3`, Node `>=24` per `engines`; deploy uses Node 24 — `.node-version` saying 22 is stale)
- Verify all: `pnpm check` = `oxfmt --check && oxlint && tsgo --noEmit && tsx --test`
- Lint / format: `pnpm lint` (`oxlint`), format with `oxfmt` (2-space, no semicolons, width 100). Do not introduce eslint/prettier configs.
- Tests: `pnpm test` (`tsx --test`, colocated `*.test.ts(x)`). Single file: `pnpm exec tsx --test <path>`
- Build: `pnpm prod` (production) / `pnpm bundle` (verbose + bundleInfo). Never commit `public/` (gitignored build output).
- Dev: `pnpm swarm` (dev manager: Quartz watch + wrangler, default port 7373) or `pnpm dev` (containerized). Do not run `quartz build --serve` directly.

## Structure

- `quartz.config.ts` — plugin pipeline (transformers → filters → emitters) + `ignorePatterns` (drafts, `private/`, `templates/`, wiki internals). `quartz.layout.ts` — page components.
- `quartz/{components,plugins,processors,util,runtime,scripts}/` — Preact `.tsx` components (`jsxImportSource: preact`), unified/remark/rehype pipeline, TS `strict` + `noUnusedLocals/Params`.
- `content/` — markdown vault. `content/AGENTS.md` governs `content/wiki/` maintenance (page schema, linking, 12-page minimum) — follow it when touching `wiki/`; otherwise don't bulk-edit `content/`.
- `content/content` is a git submodule (`notes` repo); don't edit blindly.

## Gotchas

- CI in `.github/workflows/` is mostly upstream-only (`if: github.repository == 'jackyzha0/quartz'`); only `deploy.yml` (push to `main`/`v4` → `npx quartz build` → Pages) applies here.
- `Dockerfile` is stale (uses `npm ci`); ignore it.
- Health/sync scripts (`pnpm health*`, `strava:*`, `oura:*`, `garmin:*`, `weather:*`, `models:*`) require `.env` credentials and hit external APIs — never run as verification. Same for `pnpm embed` / `train` (need `uv` + local vLLM).
- `pnpm format` has side effects (rewrites `content/References.bib`, `pnpm convert` rewrites images to `.webp`); run only when asked.
- Python files formatted with `ruff` via `uvx`; embedding/pace scripts run with `uv run`.
- No `wrangler.toml`/`worker/`/`migrations/` in tree despite `cf:*`/`db:*` scripts — those targets are currently broken/missing; don't attempt Cloudflare deploys.
