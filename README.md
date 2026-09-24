This is part of Thecore framework: https://github.com/gabrieletassoni/thecore/tree/release/3

## Publishing

This gem is published to RubyGems.org via `.github/workflows/gempush.yml`, whose `on: push` trigger is scoped to `branches: [release/3]` only. This was tightened after an incident on a sibling repo (`thecore_generators`) where an unscoped `push` trigger published a version bump pushed to an unreviewed feature branch. Keep the trigger scoped to `release/3` so publishing only ever happens on a merge/push to the actual release branch.

## Running the tests

The test suite runs on **PostgreSQL only** (never SQLite) — Postgres is the sole DB target of all Thecore gems and host apps. `test/dummy/config/database.yml` uses the `postgresql` adapter (host/port/user/password from `PGHOST`/`PGPORT`/`PGUSER`/`PGPASSWORD`, defaulting to `db`/`5432`/`postgres`/`postgres`) with per-environment databases `thecore_download_documents_{development,test,production}`.

`DATABASE_URL` overrides `database.yml`, and the devcontainer points it at the host app's dev database. To keep tests (and `db:test:prepare`, which drops and recreates) from ever touching it, `test/dummy/config/boot.rb` rewrites `DATABASE_URL`'s database name to `thecore_download_documents_<RAILS_ENV>`, keeping only its server and credentials. This happens in `boot.rb` rather than the test helper so every entry point is covered.

One-time setup: `cd test/dummy && RAILS_ENV=test bin/rails db:create`, then `bin/test`.
