#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

echo "=== Running database migrations ==="
bundle exec rails db:migrate

echo "=== Precompiling assets ==="
bundle exec rake assets:precompile

echo "=== Starting the app ==="
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
