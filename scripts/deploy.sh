#!/bin/sh
git pull origin master;
docker compose -f docker-compose-prod.yml build
docker compose -f docker-compose-prod.yml up -d;
docker compose -f docker-compose-prod.yml exec app rake assets:precompile;
docker compose -f docker-compose-prod.yml exec app rails db:migrate:status;
docker compose -f docker-compose-prod.yml restart app;

echo $(date) $(git rev-parse HEAD) >> deploy_history.txt
