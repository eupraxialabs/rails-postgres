#!/bin/bash
set -e

echo "Executing bundle exec 'rake db:migrate' ..."
#rails db:migrate RAILS_ENV="production"
rails db_schema:load RAILS_ENV="production"

