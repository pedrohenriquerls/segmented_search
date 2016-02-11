run:
	docker-compose up
build:
	docker-compose build
rspec:
	docker-compose run web rspec
db_migration:
	docker-compose run web rake db:create RAILS_ENV=$(env); docker-compose run web rake db:migrate RAILS_ENV=$(env);
