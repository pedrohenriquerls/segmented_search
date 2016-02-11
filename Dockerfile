FROM heroku/ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /segmentation
WORKDIR /segmentation
ADD Gemfile /segmentation/Gemfile
ADD Gemfile.lock /segmentation/Gemfile.lock
RUN bundle install
ADD . /segmentation
