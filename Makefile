run:
	docker-compose up
build:
	docker-compose build
rspec:
	docker-compose run web rspec
