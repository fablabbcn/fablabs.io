.PONY: test up

up:
	docker-compose up -d

install: db/test db/dev

rebuild:
	docker-compose up -d --build

test: up db/test
	docker-compose exec app rake spec

db/test:
    docker-compose exec app rake db:setup RAILS_ENV=test

db/dev:
    docker-compose exec app rake db:setup
	docker-compose exec app rake db:seed

db/migrate:
	docker-compose exec app rake db:migrate

db/backup:
	docker exec fablabsio_db_1 pg_dumpall -c -U postgres > dump_`date +%d-%m-%Y"_"%H_%M_%S`.sql

export/projects:
	mkdir -p export
	docker-compose exec app rake export:projects[/fablabs/export/projects.json]

deploy:
	git pull origin master
	docker-compose up -d --build
