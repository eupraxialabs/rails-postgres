#!/bin/bash
set -e

echo "Executing bundle exec 'rake db:schema:load' ..."
#rails db:migrate RAILS_ENV="production"
#rails db_schema:load RAILS_ENV="production"
bundle exec rake db:schema:load

