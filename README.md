This is part of Thecore framework: https://github.com/gabrieletassoni/thecore/tree/release/3

## Publishing

This gem is published to RubyGems.org via `.github/workflows/gempush.yml`, whose `on: push` trigger is scoped to `branches: [release/3]` only. This was tightened after an incident on a sibling repo (`thecore_generators`) where an unscoped `push` trigger published a version bump pushed to an unreviewed feature branch. Keep the trigger scoped to `release/3` so publishing only ever happens on a merge/push to the actual release branch.
