# Copilot instructions for this repository

NOTE: At the time these instructions were generated, the workspace root (c:\TEMPORALES\DIDIeco\didieco) contained no discoverable source files or agent docs. If you can see source files locally, run a quick inventory (see next section) and re-generate/merge these instructions.

What I (an AI coding agent) should do first

1. Inventory the repository (look for these files, in order):
   - `README.md` (root)
   - language manifests: `package.json`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `pom.xml`, `build.gradle`
   - top-level source dirs: `src/`, `lib/`, `app/`, `backend/`, `frontend/`
   - Docker/infra: `Dockerfile`, `docker-compose.yml`, `.azure/`, `k8s/`, `infrastructure/`
   - CI & config: `.github/workflows/`, `azure-pipelines.yml`, `.env.example`
   - tests: `tests/`, `spec/`, `__tests__/`

2. If the inventory finds code, map the architecture by locating:
   - the application entrypoint (e.g., `src/index.js`, `app.py`, `Main.java`, or `server.ts`) and any `Dockerfile` CMD
   - API surfaces (look for `routes/`, `controllers/`, `api/`, `endpoints/`)
   - data layer files (e.g., `models/`, `migrations/`, `db/`) and the DB config file
   - background workers / schedulers (e.g., `worker/`, `jobs/`, `cron/`)

Quick commands to run (Windows cmd context)

- Search for common manifests:

  dir /s /b package.json
  dir /s /b requirements.txt
  dir /s /b README.md

- Print a short tree of top-level folders (if `tree` installed):

  tree /F | more

What to extract and record (explicit and actionable)

- Build and run commands discovered (exact commands from README, package.json scripts, Dockerfile). Example: if `package.json` contains a `start` script, note `npm install` then `npm run start`.
- Test command(s): e.g., `npm test`, `pytest`, `mvn test` — record test args and any env variables required.
- How secrets/config are loaded: `.env`, environment variables, keyvaults, config files.
- External integrations: any references to external services (S3, Postgres, Redis, Azure services) by scanning for hostnames, connection strings, or SDK imports.

Repository-specific patterns to prefer (examples to replace after inventory)

- Follow existing module layout. If you find `src/<service>/index.*` treat that folder as a boundary and favor changing only inside it unless cross-cutting changes are required.
- If `package.json` uses `workspaces` or a `monorepo/` layout, then prefer edits confined to a package and update its `package.json` scripts rather than global changes.

Examples (replace with real file paths after scanning)

- "If you need to change HTTP handlers, edit `src/server/routes/*.js` and update `src/server/index.js` to wire new routes."
- "Database models live in `models/` and migrations in `migrations/`; add migration files next to existing ones and follow the naming pattern `V{timestamp}__description.sql` if present."

Merging guidance

- If `.github/copilot-instructions.md` already exists, preserve any explicit run commands and environment notes. Only add new, short actionable items discovered during inventory.
- Do not remove project owner or roadmap notes.

When you can't find information

- If README or manifests are missing, create a short PR that adds a `README.md` with detected language and a minimal run/test command discovered by probing (e.g., `node -v` or `python -V` and `dir /s /b *.js` to find entry files).

Reporting back

- After inventory, append a short summary to this file listing:
  - detected language(s)
  - build/run/test commands
  - key entrypoints and why they are important
  - any missing pieces you couldn't infer (e.g., DB credentials, infra manifests)

If you (the human) want a more targeted file

- Share the repository contents or allow me to run a workspace scan. I will then update this file to include concrete file references and 3-5 short examples from the codebase.

---
Generated: automated template (no code files detected). Merge with upstream instructions if present.
