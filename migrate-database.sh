#!/bin/bash
set -e

echo "Executing bundle exec 'rake db:migrate' ..."
RAILS_ENV=production bundle exec rails db:migrate

