#!/bin/sh
git pull origin master;
docker-compose build && docker-compose up -d;
docker-compose exec app rake assets:precompile;
docker-compose exec app rails db:migrate:status;
docker-compose restart app;
