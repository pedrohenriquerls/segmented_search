run:
	docker-compose up
build:
	docker-compose build;docker-compose run web rake db:create; docker-compose run web rake db:migrate;
rspec:
	docker-compose run web rspec
