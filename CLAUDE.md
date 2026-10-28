# thecore_download_documents — AI Context

## What this is

A Rails gem (Ruby, a Railtie, not an engine) of the Thecore framework with helpers to export data as
CSV and PDF in a simple tabular notation; PDFs can have a header and a footer on every page (Prawn,
`prawn-table`). It depends on `thecore_ui_commons` and `thecore_ui_rails_admin`. Part of the
framework documented at https://github.com/gabrieletassoni/thecore/tree/release/3.

## Key files

| File | Purpose |
|---|---|
| `lib/thecore_download_documents.rb` | `ThecoreDownloadDocuments.pdf_table(header, footer, rows, table_headers, filename)` and `.csv_table(rows, table_headers, filename)` |
| `lib/thecore_download_documents/railtie.rb` | Hooks the gem into the host app |
| `test/dummy_boot_smoke_test.rb` | Asserts the dummy app boots with the gem |
| `README.md` | Publishing and test setup in detail |

## Running tests

**PostgreSQL only**, never SQLite. `test/dummy/config/database.yml` uses `PGHOST`/`PGPORT`/
`PGUSER`/`PGPASSWORD` (default `db`/`5432`/`postgres`/`postgres`) and databases
`thecore_download_documents_<env>`. When `DATABASE_URL` is set (the devcontainer points it at the
host app's dev database), `test/dummy/config/boot.rb` keeps its server and credentials but rewrites
the database name, so the tests never touch the host's data.

One-time setup: `cd test/dummy && RAILS_ENV=test bin/rails db:create`. Then run `bin/test` from the
gem root (one test: `bin/test test/dummy_boot_smoke_test.rb:6`).

## Release

Bump `lib/thecore_download_documents/version.rb` and push to `release/3`:
`.github/workflows/gempush.yml` tags the version and publishes it to RubyGems.org. A push that
doesn't change the version publishes nothing, and no other branch ever publishes. Then, in each host
app, `bundle update thecore_download_documents --conservative` and commit `Gemfile.lock` together
with the moved submodule pointer.

## Security scanning

Configured in the GitHub repository settings, not in files:

- **CodeQL** default setup (Ruby, the Actions workflows, and JavaScript/TypeScript where the gem
  ships any): on every push to `release/3`, on pull requests and weekly. Findings: Security → Code
  scanning.
- **Secret scanning with push protection**: a push containing a recognised secret is rejected. It
  is the only check that blocks anything. If it fires on a real secret, remove it from the commit and
  rotate the secret; never bypass it.
- **Dependabot alerts and security updates**, but no `dependabot.yml`, so no routine version-bump
  pull requests. This gem commits no `Gemfile.lock`, so Dependabot only sees the gemspec and the
  workflow Actions: CVEs in the resolved Ruby dependencies are caught by `bundler-audit` in the host
  apps' pipelines, whose `Gemfile.lock` resolves every ATOM.
- Findings never block a release: GitHub notifies the owner. When one needs work, open a GitHub
  issue (see Agent skills).

## Agent skills

### Issue tracker

Tasks, issues, bugs, tickets and specs for this repository live **only** in its GitHub Issues
(`gabrieletassoni/thecore_download_documents`), handled with the `gh` CLI. See `docs/agents/issue-tracker.md`.

**Mandatory rule.** Whenever a skill or development work creates, reads, updates, comments on,
assigns, blocks or closes a task, issue, bug, ticket or spec (for example /to-tickets, /to-spec,
/triage, /wayfinder, /implement, /diagnosing-bugs, /code-review, closing a piece of work, a bug found
during a session), do it in this repository's GitHub Issues following `docs/agents/issue-tracker.md`.
Never use Odoo, `.scratch/` or local Markdown files as a tracker: Odoo is only for the repositories
on Bancolini's GitLab. `#123` means a GitHub issue number of this repository. If `gh` doesn't work,
stop and say so instead of falling back to another tracker.

### Triage labels

The five canonical triage roles map to GitHub labels with the same name (`needs-triage`,
`needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: one `GLOSSARY.md` and `docs/adr/` at the repo root, created lazily when the first
term or decision is resolved. See `docs/agents/domain.md`.

### Skills

Matt Pocock's skills come from the `mattpocock-skills` Claude Code plugin installed on the
developer's **host** (`claude plugins install mattpocock-skills`, official marketplace), never
vendored here: no `.agents/skills/`, `.claude/commands/` or `skills-lock.json`. Its `ask-matt` skill
maps how the skills connect.
