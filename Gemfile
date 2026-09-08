source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in thecore_download_documents.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# json 3.0+ turns the long-tolerated, deprecated `quirks_mode:` option into a hard ArgumentError;
# activesupport (Rails 7.2's JSON encoder) still passes it on every JSON.generate call, so any
# request that commits a session cookie crashes. Same fix as the host app's own Gemfile — pin
# until Rails 8 ships a compatible activesupport release.
gem 'json', '< 3.0'

# test/dummy/config/database.yml uses the sqlite3 adapter but nothing declared it.
gem "sqlite3"

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
