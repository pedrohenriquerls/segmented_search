# Segmented Search
[![Code Climate](https://codeclimate.com/github/pedrohenriquerls/segmented_search/badges/gpa.svg)](https://codeclimate.com/github/pedrohenriquerls/segmented_search)  [![Test Coverage](https://codeclimate.com/github/pedrohenriquerls/segmented_search/badges/coverage.svg)](https://codeclimate.com/github/pedrohenriquerls/segmented_search/coverage)
####Techstack
  - Ruby 2.3.0
  - Postgres
  - Docker(to use all make commands is necessary have docker-compose installed)
  
##How to use
###Running
  - make build
  - make run
  - make db_migration env=production
  - open "http://$(docker-machine ip default):3000/"

###Rspec
  - docker-compose run db
  - make db_migration env=test
  - rspec
