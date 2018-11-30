#!/bin/sh
git pull origin master;
docker-compose build && docker-compose up -d;
docker-compose exec app rake assets:precompile;
docker-compose restart app;
